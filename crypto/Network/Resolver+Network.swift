//
//  Resolver+Network.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

extension Resolver {

    static func registerNetworkDependencies() {

        register { AssetsApi() }
            .implements(AssetsApiProtocol.self)
            .scope(.application)
    }
}
