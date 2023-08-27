//
//  Currency+Mock.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import Foundation
@testable import crypto

enum CurrencyMockError: Error {
    case missingElement
}

extension Currency {
    static func mockData() throws -> Self {
        guard let randomElement = try [Self].mockData().randomElement() else {
            throw CurrencyMockError.missingElement
        }
        return randomElement
    }
}

extension Array where Element == Currency {
    static func mockData() throws -> [Element] {
        return try MockDataProvider().currencies()
    }
}
