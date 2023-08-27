//
//  MockDataProvider.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import Foundation
@testable import crypto

enum MockDataProviderError: Error {
    case missingFile
}

class MockDataProvider {
    func currencies() throws -> [Currency] {
        if let url = Bundle(for: type(of: self)).url(forResource: "currencies", withExtension: "json") {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let mapped = try decoder.decode([Currency].self, from: jsonData)
            return mapped
        }
        throw MockDataProviderError.missingFile
    }
}
