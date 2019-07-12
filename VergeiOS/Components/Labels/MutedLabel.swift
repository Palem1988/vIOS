//
//  MutedLabel.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 14/04/2019.
//  Copyright © 2019 Verge Currency. All rights reserved.
//

import UIKit

class MutedLabel: TitleLabel {

    override func updateColors() {
        self.textColor = ThemeManager.shared.vergeGrey()
    }

}
