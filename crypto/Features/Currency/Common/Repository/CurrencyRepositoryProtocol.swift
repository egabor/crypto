//
//  CurrencyRepositoryProtocol.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
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
