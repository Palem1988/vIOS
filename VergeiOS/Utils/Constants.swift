//
//  Constants.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 20/10/2018.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import Foundation

public struct Constants {

    /**
     * The timeout used for fetching wallet data.
     */
    public static let fetchWalletTimeout: Double = 30

    /**
     * The timeout used for fetching fiat rating data.
     */
    public static let fetchRateTimeout: Double = 150

    /**
     * Amounts are fetched in satoshis and so we need to divide all price labels.
     */
    public static let satoshiDivider: Double = 1000000.0

    /**
     * Confirmations needed to change the UI.
     */
    public static let confirmationsNeeded: Int = 1

    /**
     * The maximum of digits.
     */
    public static let maximumFractionDigits: Int = 6

    /**
     * Verge Currency website.
     */
    public static let website: String = "https://vergecurrency.com/"

    /**
     * Verge Currency iOS wallet repository.
     */
    public static let iOSRepo: String = "https://github.com/vergecurrency/vIOS/"

    /**
     * The blockchain explorer used.
     */
    public static let blockchainExlorer: String = "https://verge-blockchain.info/"

    /**
     * The application terms of use link.
     */
    public static let termsOfUse: String = "https://vergecurrency.com/wallets/terms"

    /**
     * The default Verge Wallet Service.
     */
    public static let bwsEndpoint: String = "https://api.vergecurrency.network/vws/api/"

    /**
     * The default Verge Bitcore Node.
     */
    public static let bnEndpoint: String = "https://api.vergecurrency.network/node/api/XVG/mainnet"

    /**
     * The fiat rate data service.
     */
    public static let priceDataEndpoint: String = "https://api.vergecurrency.network/price/api/v1/price/"

    /**
     * Chart data endpoint.
     */
    public static let chartDataEndpoint: String = "https://api.vergecurrency.network/price/api/v1/chart/"

    /**
     * IP Address endpoint.
     */
    public static let ipCheckEndpoint: String = "https://api.vergecurrency.network/price/api/v1/ip/"

    /**
     * The Verge Currency CORE team donation address.
     */
    public static let donationXvgAddress: String = "DHe3mTNQztY1wWokdtMprdeCKNoMxyThoV"

}
