//
//  Configuration.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import Foundation

struct Configuration {
    static let currencyLimit = 10

    static func urlString(for symbol: String) -> String {
        "https://assets.coincap.io/assets/icons/\(symbol)@2x.png"
    }
}
