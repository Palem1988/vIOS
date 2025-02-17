//
//  SelectPinViewController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 23-07-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit

class SelectPinViewController: ThemeableViewController, KeyboardDelegate {

    @IBOutlet weak var pinTextField: PinTextField!
    @IBOutlet weak var pinKeyboard: PinKeyboard!

    var pin: String = ""
    var segueIdentifier: String?
    var completion: ((_ pin: String) -> Void)?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if (UIDevice.current.userInterfaceIdiom != .pad) {
            return .default
        }

        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pinKeyboard.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.pin = ""
        self.pinTextField.reset()
    }

    func didReceiveInput(_ sender: Keyboard, input: String, keyboardKey: KeyboardKey) {
        if (keyboardKey.isKind(of: BackKey.self)) {
            self.pinTextField.removeCharacter()

            if (self.pin.count > 0) {
                self.pin = String(self.pin[..<self.pin.index(self.pin.endIndex, offsetBy: -1)])
            }
        } else {
            self.pinTextField.addCharacter()

            if (self.pin.count < self.pinTextField.pinCharacterCount) {
                self.pin = "\(self.pin)\(input)"
            }

            // When all pins are set.
            if (self.pin.count == self.pinTextField.pinCharacterCount) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.performSegue(withIdentifier: "confirmPin", sender: self)
                }
            }
        }
    }

    @IBAction func showSettings(_ sender: Any) {
        let settings = UIAlertController(
            title: "setup.pinCode.alert.chooseSize".localized,
            message: nil,
            preferredStyle: .actionSheet
        )

        let digitCounts = [4, 5, 6, 7, 8]
        for count in digitCounts {
            let action = UIAlertAction(
                title: "\(count) " + "setup.pinCode.alert.digits".localized,
                style: .default
            ) { _ in
                self.pinTextField.pinCharacterCount = count
                self.pinTextField.reset()
                self.pin = ""
            }
            action.setValue(UIImage(named: "\(count)Digits"), forKey: "image")
            settings.addAction(action)
        }

        settings.addAction(UIAlertAction(title: "defaults.cancel".localized, style: .cancel))

        self.present(settings, animated: true)
    }

    // Dismiss the view
    @IBAction func backToWelcome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func unwindToSelection(segue: UIStoryboardSegue) {}

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "confirmPin") {
            if let vc = segue.destination as? ConfirmPinViewController {
                let backItem = UIBarButtonItem()
                backItem.title = "defaults.back".localized
                navigationItem.backBarButtonItem = backItem

                vc.previousPin = self.pin
                vc.pinCount = self.pinTextField.pinCharacterCount
                vc.segueIdentifier = self.segueIdentifier
                vc.completion = self.completion
            }
        }
     }

}
