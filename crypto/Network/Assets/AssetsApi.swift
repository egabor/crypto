//
//  AssetsApi.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import Foundation
import Combine

class AssetsApi: AssetsApiProtocol {
    private let baseURL: URL? = URL(string: "http://api.coincap.io")

    func fetchCurrencies() async throws -> DataWrapper<[Currency]> {
        guard var url = baseURL?.appendingPathComponent("/v2/assets") else {
            throw AssetsApiError.endpointURLNotConfigured
        }
        url.append(queryItems: [.init(name: "limit", value: "\(Configuration.currencyLimit)")])

        let json: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataWrapper<[Currency]>.self, from: json.data)
    }

    func fetchCurrency(by id: String) async throws -> DataWrapper<Currency> {
        guard let url = baseURL?.appendingPathComponent("/v2/assets/\(id)") else {
            throw AssetsApiError.endpointURLNotConfigured
        }

        let json: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataWrapper<Currency>.self, from: json.data)
    }
}
