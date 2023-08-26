//
//  ImageCacheProtocol.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import UIKit.UIImage

protocol ImageCacheProtocol {
    subscript(_ url: URL) -> UIImage? { get set }
}
