//
//  CurrencyDetailsViewData.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation

struct CurrencyDetailsViewData: Equatable {
    let id: String
    let title: String
    let formattedPriceUsd: String
    let formattedChangePercent24Hr: String
    let change: CurrencyChangeType
    let formattedMarketCap: String
    let formatted24hrVolume: String
    let formattedSupply: String
    let imageUrl: URL?
}

extension CurrencyDetailsViewData {
    static let empty: Self = .init(
        id: "",
        title: "",
        formattedPriceUsd: "",
        formattedChangePercent24Hr: "",
        change: .none,
        formattedMarketCap: "",
        formatted24hrVolume: "",
        formattedSupply: "",
        imageUrl: nil
    )
}
