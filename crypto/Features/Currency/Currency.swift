//
//  Currency.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation

struct Currency: Identifiable, Equatable, Decodable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let priceUsd: String
    let changePercent24Hr: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let supply: String
}

extension Currency {
    static func from(
        id: String,
        name: String
    ) -> Self {
        .init(
            id: id,
            rank: "",
            symbol: "",
            name: name,
            priceUsd: "",
            changePercent24Hr: "",
            marketCapUsd: "",
            volumeUsd24Hr: "",
            supply: ""
        )
    }
}
