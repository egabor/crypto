//
//  PercentageFormatterUseCase.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation

protocol PercentageFormatterUseCaseProtocol {
    
    func callAsFunction(_ numberString: String) -> String
}

class PercentageFormatterUseCase: PercentageFormatterUseCaseProtocol {

    private lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }()

    func callAsFunction(_ numberString: String) -> String {
        guard let doubleValue = Double(numberString) else { return numberString }
        let numberValue = NSNumber(floatLiteral: doubleValue / 100.0)
        return numberFormatter.string(from: numberValue) ?? numberString
    }
}
