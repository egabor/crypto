//
//  CurrencyUtils.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//

import Foundation
import Resolver

class CurrencyUtils: CurrencyUtilsProtocol {

    @Injected private var numberShortener: NumberShortenerUtils
    @Injected private var percentageFormatter: PercentageFormatterUtils

    func convertToListItemViewData(_ currency: Currency) -> CurrencyListItemViewData {
        .init(
            id: currency.id,
            symbol: currency.symbol,
            name: currency.name.uppercased(),
            formattedPriceUsd: numberShortener.shorten(numberString: currency.priceUsd),
            formattedChangePercent24Hr: percentageFormatter.format(currency.changePercent24Hr),
            change: getChangeType(for: currency.changePercent24Hr),
            imageUrl: imageUrl(for: currency)
        )
    }

    func convertToDetailsViewData(_ currency: Currency) -> CurrencyDetailsViewData {
        .init(
            id: currency.id,
            title: currency.name.uppercased(),
            formattedPriceUsd: numberShortener.shorten(numberString: currency.priceUsd),
            formattedChangePercent24Hr: percentageFormatter.format(currency.changePercent24Hr),
            change: getChangeType(for: currency.changePercent24Hr),
            formattedMarketCap: numberShortener.shorten(numberString: currency.marketCapUsd),
            formatted24hrVolume: numberShortener.shorten(numberString: currency.volumeUsd24Hr),
            formattedSupply: numberShortener.shorten(numberString: currency.supply),
            imageUrl: imageUrl(for: currency)
        )
    }
}

extension CurrencyUtils {

    fileprivate func getChangeType(for change: String) -> CurrencyChangeType {
        guard let changeValue = Double(change) else { return .none }
        if changeValue < 0.0 {
            return .negative
        } else if changeValue > 0.0 {
            return .positive
        }
        return .none
    }

    fileprivate func imageUrl(for currency: Currency) -> URL? {
        let symbol = currency.symbol.lowercased()
        return URL(string: Configuration.urlString(for: symbol))
    }
}

