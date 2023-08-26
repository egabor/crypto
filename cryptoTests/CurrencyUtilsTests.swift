//
//  CurrencyUtilsTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import XCTest
@testable import crypto

final class CurrencyUtilsTests: XCTestCase {

    let currencyUtils = CurrencyUtils()

    func testCurrencyUtils_methodConvertToListItemViewData_forValidInput_shouldReturnValidOutput() throws {
        let input: Currency = .init(
            id: "id",
            rank: "1",
            symbol: "BTC",
            name: "Bitcoin",
            priceUsd: "26578.532",
            changePercent24Hr: "2.34842367347",
            marketCapUsd: "1234634536.34523522425",
            volumeUsd24Hr: "7000.000000",
            supply: "1"
        )
        let output: CurrencyListItemViewData = .init(
            id: "id",
            symbol: "BTC",
            name: "BITCOIN",
            formattedPriceUsd: "$26.57K",
            formattedChangePercent24Hr: "2.35%",
            change: .positive,
            imageUrl: URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png")
        )

        XCTAssertEqual(currencyUtils.convertToListItemViewData(input), output)
    }

    func testCurrencyUtils_methodConvertToDetailsViewData_forValidInput_shouldReturnValidOutput() throws {
        let input: Currency = .init(
            id: "id",
            rank: "1",
            symbol: "ETH",
            name: "Ethereum",
            priceUsd: "26578.532",
            changePercent24Hr: "2.34842367347",
            marketCapUsd: "1234634536.34523522425",
            volumeUsd24Hr: "7000.000000",
            supply: "1"
        )
        let output: CurrencyDetailsViewData = .init(
            id: "id",
            title: "ETHEREUM",
            formattedPriceUsd: "$26.57K",
            formattedChangePercent24Hr: "2.35%",
            change: .positive,
            formattedMarketCap: "$1.23B",
            formatted24hrVolume: "$7.00K",
            formattedSupply: "1.00",
            imageUrl: URL(string: "https://assets.coincap.io/assets/icons/eth@2x.png")
        )

        XCTAssertEqual(currencyUtils.convertToDetailsViewData(input), output)
    }
}
