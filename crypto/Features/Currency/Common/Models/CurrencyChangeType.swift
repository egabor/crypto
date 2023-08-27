//
//  CurrencyChangeType.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import SwiftUI

enum CurrencyChangeType {
    case none, positive, negative
}

extension CurrencyChangeType {
    var color: Color {
        switch self {
            case .none: return .contentText
            case .positive: return .contentGreen
            case .negative: return .contentRed
        }
    }
}
