//
// Created by Swen van Zanten on 2019-02-14.
// Copyright (c) 2019 Verge Currency. All rights reserved.
//

import UIKit

class TransactionProposalsTableViewController: EdgedTableViewController {

    var walletClient: WalletClient!
    var proposals: [TxProposalResponse] = []

    var hasProposals: Bool {
        return proposals.count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl?.addTarget(
            self,
            action: #selector(TransactionProposalsTableViewController.loadProposals),
            for: .valueChanged
        )

        loadProposals()
    }

    @objc func loadProposals() {
        refreshControl?.beginRefreshing()

        self.walletClient.getTxProposals { proposals, _ in
            self.proposals = proposals

            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasProposals ? proposals.count : 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return hasProposals ? "settings.transactions.removeProposal".localized : ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !hasProposals {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.themeable = true
            cell.textLabel?.text = "settings.transactions.noProposals".localized
            cell.textLabel?.textColor = ThemeManager.shared.vergeGrey()
            cell.selectionStyle = .none
            cell.updateColors()

            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "proposals") else {
            return UITableViewCell()
        }

        let proposal = proposals[indexPath.row]
        let amount = NSNumber(value: Double(proposal.amount) / Constants.satoshiDivider).toXvgCurrency()

        cell.textLabel?.text = proposal.id
        cell.detailTextLabel?.text = "[\(proposal.status)] - \(amount)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if proposals.isEmpty {
            return
        }

        let proposal = proposals[indexPath.row]

        let sheet = UIAlertController(
            title: "settings.transactions.removeProposal".localized,
            message: "settings.transactions.releaseXvg".localized,
            preferredStyle: .alert
        )
        sheet.addAction(UIAlertAction(title: "defaults.cancel".localized, style: .cancel))
        sheet.addAction(UIAlertAction(title: "defaults.remove".localized, style: .destructive) { _ in
            self.refreshControl?.beginRefreshing()

            self.walletClient.deleteTxProposal(txp: proposal) { _ in
                self.loadProposals()
            }
        })

        present(sheet, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
