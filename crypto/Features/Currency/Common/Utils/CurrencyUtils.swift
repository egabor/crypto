//
//  CurrencyUtils.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

class CurrencyUtils: CurrencyUtilsProtocol {

    @Injected private var numberShortener: NumberShortenerUseCaseProtocol
    @Injected private var percentageFormatter: PercentageFormatterUseCaseProtocol

    func convertToListItemViewData(_ currency: Currency) -> CurrencyListItemViewData {
        .init(
            id: currency.id,
            symbol: currency.symbol,
            name: currency.name.uppercased(),
            formattedPriceUsd: numberShortener(currency.priceUsd),
            formattedChangePercent24Hr: percentageFormatter(currency.changePercent24Hr),
            change: getChangeType(for: currency.changePercent24Hr),
            imageUrl: imageUrl(for: currency)
        )
    }

    func convertToDetailsViewData(_ currency: Currency) -> CurrencyDetailsViewData {
        .init(
            id: currency.id,
            title: currency.name.uppercased(),
            formattedPriceUsd: numberShortener(currency.priceUsd),
            formattedChangePercent24Hr: percentageFormatter(currency.changePercent24Hr),
            change: getChangeType(for: currency.changePercent24Hr),
            formattedMarketCap: numberShortener(currency.marketCapUsd),
            formatted24hrVolume: numberShortener(currency.volumeUsd24Hr),
            formattedSupply: numberShortener(currency.supply),
            imageUrl: imageUrl(for: currency)
        )
    }
}

extension CurrencyUtils {

    private func getChangeType(for change: String) -> CurrencyChangeType {
        guard let changeValue = Double(change) else { return .none }
        if changeValue < 0.0 {
            return .negative
        } else if changeValue > 0.0 {
            return .positive
        }
        return .none
    }

    private func imageUrl(for currency: Currency) -> URL? {
        let symbol = currency.symbol.lowercased()
        return URL(string: Configuration.urlString(for: symbol))
    }
}

