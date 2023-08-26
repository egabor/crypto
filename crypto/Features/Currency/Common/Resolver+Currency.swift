//
//  Currency+Dependencies.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

extension Resolver {

    static func registerCurrencyDependencies() {

        register { CurrencyUtils() }
            .implements(CurrencyUtilsProtocol.self)
            .scope(.application)

        register { CurrencyRepository() }
            .implements(CurrencyRepositoryProtocol.self)
            .scope(.application)
    }
}
