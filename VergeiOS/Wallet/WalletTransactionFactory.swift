//
// Created by Swen van Zanten on 24-08-18.
// Copyright (c) 2018 Verge Currency. All rights reserved.
//

import Foundation

class WalletTransactionFactory {

    var amount: NSNumber = 0.0
    var fiatAmount: NSNumber = 0.0
    var address: String = ""
    var memo: String = ""

    var fiatRateTracker: FiatRateTicker!

    init(fiatRateTracker: FiatRateTicker? = nil) {
        self.fiatRateTracker = fiatRateTracker ?? Application.container.resolve(FiatRateTicker.self)
    }

    func setBy(currency: String, amount: NSNumber) {
        if currency == "XVG" {
            self.amount = amount
        } else {
            fiatAmount = amount
        }

        update(currency: currency)
    }

    func update(currency: String) {
        if let xvgInfo = self.fiatRateTracker.rateInfo {
            if currency == "XVG" {
                fiatAmount = NSNumber(value: amount.doubleValue * xvgInfo.price)
            } else {
                amount = NSNumber(value: fiatAmount.doubleValue / xvgInfo.price)
            }
        }
    }

}
