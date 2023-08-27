//
//  CurrencyRepository.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Combine

class CurrencyRepository: CurrencyRepositoryProtocol {

    var dataSetUpdate: PassthroughSubject<Void, Never> = .init()

    private(set) var currencies: [String: Currency] = [:]

    func set(currency: Currency) {
        currencies[currency.id] = currency
        dataSetUpdate.send(())
    }

    func set(currencies: [Currency]) {
        for currency in currencies {
            self.currencies[currency.id] = currency
        }
        dataSetUpdate.send(())
    }

    func get() -> [Currency] {
        let currencies = currencies
            .values
            .sorted(
                by: { (currencyA, currencyB) in
                    Double(currencyA.rank) ?? 0.0 < Double(currencyB.rank) ?? 0.0
                }
            )
            .prefix(Configuration.currencyLimit)
        return Array(currencies)
    }
}
