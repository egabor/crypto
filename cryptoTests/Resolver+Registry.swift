//
//  Resolver+Registry.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import Foundation
import Resolver
@testable import crypto

extension Resolver {
    static var unitTests: Resolver!

    static func resetUnitTestRegistrations() {
        Resolver.reset()
        Resolver.defaultScope = .shared

        Resolver.unitTests = .init(child: .main)
        Resolver.root = .unitTests

        Resolver.unitTests.register { MockAssetsApi() }
            .implements(AssetsApiProtocol.self)
            .scope(.shared)
    }
}
