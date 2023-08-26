//
//  CurrencyListItemViewData.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation

struct CurrencyListItemViewData: Identifiable {
    let id: String
    let symbol: String
    let name: String
    let formattedPriceUsd: String
    let formattedChangePercent24Hr: String
    let change: CurrencyChangeType
    let imageUrl: URL?
}
