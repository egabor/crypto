//
//  Resolver+Registry.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {

        registerCurrencyDependencies()
        registerNetworkDependencies()
        registerAsyncImageViewDependencies()

        register { NumberShortenerUtils() }
            .scope(.application)

        register { PercentageFormatterUtils() }
            .scope(.application)
    }
}
