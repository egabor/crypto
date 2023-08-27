//
//  MockAssetsApi.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import Combine
import Resolver
@testable import crypto

class MockAssetsApi: AssetsApiProtocol {

    var mockAssetsResult: MockAssetsResult?
    var mockAssetResult: MockAssetResult?

    func fetchCurrencies() async throws -> crypto.DataWrapper<[crypto.Currency]> {
        guard let fileName = self.mockAssetsResult?.rawValue else {
            throw MockError.resultNotSpecified
        }
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 sec
        return try MockDataProvider().assetsResponse(fileName: fileName)
    }

    func fetchCurrency(by id: String) async throws -> crypto.DataWrapper<crypto.Currency> {
        guard let fileName = self.mockAssetResult?.rawValue else {
            throw MockError.resultNotSpecified
        }
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 sec
        return try MockDataProvider().assetResponse(fileName: fileName)
    }
}
