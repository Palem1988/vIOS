//
//  UIView+Localization.swift
//  VergeiOS
//
//  Created by Ivan Manov on 20/04/2019.
//  Copyright © 2019 Verge Currency. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    @IBInspectable var localizationId: String {
        set(value) {
            self.text = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
}

extension UIButton {
    
    @IBInspectable var localizationId: String {
        set(value) {
            self.setTitle(NSLocalizedString(value, comment: ""), for: .normal)
        }
        get {
            return ""
        }
    }
    
}

extension UINavigationItem {
    
    @IBInspectable var localizationTitleId: String {
        set(value) {
            self.title = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var localizationPromptId: String {
        set(value) {
            self.prompt = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var localizationBackButtonId: String {
        set(value) {
            self.backBarButtonItem?.title = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
}

extension UITextField {
    
    @IBInspectable var localizationPlaceholderId: String {
        set(value) {
            self.placeholder = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
}
