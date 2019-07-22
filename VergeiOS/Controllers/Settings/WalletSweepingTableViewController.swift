//
//  WalletSweepingTableViewController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 12/07/2019.
//  Copyright © 2019 Verge Currency. All rights reserved.
//

import UIKit

struct WalletSweepingItem {
    public let id: String
    public let name: String
    public let subtitle: String
}

class WalletSweepingTableViewController: UITableViewController {

    let items = [
        WalletSweepingItem(id: "privateKey", name: "Private key", subtitle: "Paper wallet, Card wallet etc"),
        WalletSweepingItem(id: "electrum", name: "Electrum", subtitle: "V2.1.0 or lower"),
        WalletSweepingItem(id: "android", name: "Android", subtitle: "v1.0.0 or lower")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sweeping method"
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Choose a sweeping method to transfer one of the external wallets into your current iOS wallet."
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.subtitle
        cell.accessoryType = .disclosureIndicator
        cell.updateColors()

        cell.textLabel?.font = UIFont.avenir(size: 17).demiBold()
        cell.detailTextLabel?.font = UIFont.avenir(size: 12)

        return cell
    }

    @IBAction func openCamera(_ sender: Any) {
        let paperWalletScanViewController = PaperWalletScanViewController()

        self.present(paperWalletScanViewController, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
