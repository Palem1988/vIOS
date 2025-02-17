//
//  MainTabBarController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 23-09-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTabBarController: UITabBarController {

    let sendViewIndex: Int = 2
    let receiveViewIndex: Int = 3

    var applicationRepository: ApplicationRepository!
    var shortcutsManager: ShortcutsManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(demandSendView(notification:)),
            name: .demandSendView,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDeviceShaken(notification:)),
            name: .didDeviceShaken,
            object: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            if let sendTransaction = delegate.sendRequest {
                // Prepare the send view with the transaction.
                prepareSendView(transaction: sendTransaction)

                // Remove the transaction from the delegate.
                delegate.sendRequest = nil
            } else if self.shortcutsManager.needHandleShortcut {
                proceedShortcut()
                self.shortcutsManager.needHandleShortcut = false
            }
        }
    }

    func proceedShortcut() {
        let shortCutType = self.shortcutsManager.lastShortcutType
        switch shortCutType {
        case ShortcutsManager.ShortcutIdentifier.send.type:
            selectedIndex = sendViewIndex
        case ShortcutsManager.ShortcutIdentifier.receive.type:
            selectedIndex = receiveViewIndex
        default:
            break
        }
    }

    func prepareSendView(transaction: WalletTransactionFactory) {
        // Select the send view.
        selectedIndex = sendViewIndex

        guard let navigationController = viewControllers?[sendViewIndex] as? UINavigationController else {
            return
        }

        guard let sendViewController = navigationController.viewControllers.first as? SendViewController else {
            return
        }

        // Set the transaction on the send view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            sendViewController.didChangeSendTransaction(transaction)
        }
    }

    @objc func demandSendView(notification: Notification) {
        if let sendTransaction = notification.object as? WalletTransactionFactory {
            prepareSendView(transaction: sendTransaction)
        }
    }

    @objc func didDeviceShaken(notification: Notification? = nil) {
        self.applicationRepository.secureContent = !self.applicationRepository.secureContent
    }
}
