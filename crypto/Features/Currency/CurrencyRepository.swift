//
//  CurrencyRepository.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Combine

/// The currency repository stands for the single source of truth in the app regarding the currencies.
protocol CurrencyRepositoryProtocol {

    var dataSetUpdate: PassthroughSubject<Void, Never> { get set }
    var currencies: [String: Currency] { get }

    func set(currency: Currency)
    func set(currencies: [Currency])
    func get() -> [Currency]
}

class CurrencyRepository: CurrencyRepositoryProtocol {

    var dataSetUpdate: PassthroughSubject<Void, Never> = .init()

    private(set) var currencies: [String: Currency] = [:]

    func set(currency: Currency) {
        currencies[currency.id] = currency
        dataSetUpdate.send(())
    }

    func set(currencies: [Currency]) {
        for currency in currencies {
            set(currency: currency)
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
