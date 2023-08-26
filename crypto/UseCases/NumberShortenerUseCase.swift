//
//  NumberShortenerUseCase.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation

protocol NumberShortenerUseCaseProtocol {
    
    func callAsFunction(_ numberString: String, formatAsCurrency: Bool) -> String
}

class NumberShortenerUseCase: NumberShortenerUseCaseProtocol {

    private lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.currencyCode = self.currencyCode
        numberFormatter.locale = self.locale
        numberFormatter.groupingSeparator = " "
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyGroupingSeparator = " "
        numberFormatter.currencyDecimalSeparator = "."
        return numberFormatter
    }()

    private let shorts = ["K", "M", "B"]
    private let currencyCode: String
    private let locale: Locale

    init(currencyCode: String = "USD", locale: Locale = .init(identifier: "en_US")) {
        self.currencyCode = currencyCode
        self.locale = locale
    }

    private func preFormat(numberString: String) -> String {
        guard let doubleValue = Double(numberString) else { return numberString }
        let numberValue = NSNumber(floatLiteral: doubleValue)
        let formattedString = numberFormatter.string(from: numberValue) ?? numberString
        return formattedString
    }

    func callAsFunction(_ numberString: String, formatAsCurrency: Bool) -> String {
        if formatAsCurrency {
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = currencyCode
        } else {
            numberFormatter.numberStyle = .none
            numberFormatter.currencyCode = nil
        }
        let formattedNumber = preFormat(numberString: numberString)
        var slices = formattedNumber.components(separatedBy: " ")
        let head = slices.removeFirst()

        var index = -1
        var tail: String?

        while 0 < slices.count && index < shorts.count - 1 {
            tail = slices.removeLast()
            index += 1
        }

        if 0 <= index, let tail = tail {
            let short = shorts[index]
            let decimals = String(tail.prefix(2))
            let joined = slices.joined()
            return head + joined + "." + decimals + short
        }
        return head
    }
}
