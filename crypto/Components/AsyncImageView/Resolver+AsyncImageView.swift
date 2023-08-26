//
//  Resolver+AsyncImageView.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

extension Resolver {

    static func registerAsyncImageViewDependencies() {

        register { ImageCache() }
            .implements(ImageCacheProtocol.self)
            .scope(.application)
    }
}
