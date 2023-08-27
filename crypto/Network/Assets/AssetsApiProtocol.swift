//
//  AssetsApiProtocol.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import Foundation

protocol AssetsApiProtocol {
    func fetchCurrencies() async throws -> DataWrapper<[Currency]>
    func fetchCurrency(by id: String) async throws -> DataWrapper<Currency>
}
