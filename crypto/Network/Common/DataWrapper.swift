//
//  DataWrapper.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import Foundation

struct DataWrapper<D: Decodable>: Decodable {
    let data: D
}
