//
//  CurrencyRepositoryTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import XCTest
@testable import crypto

final class CurrencyRepositoryTests: XCTestCase {

    func testCurrencyRepository_whenSettingListOfCurrencies_shouldReceiveDataSetUpdate() throws {
        let mockCurrencies = try [Currency].mockData()
        let currencyRepository = CurrencyRepository()
        let dataSetUpdateExpectation = self.expectation(description: "Data set update.")

        let cancellable = currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { _ in
                dataSetUpdateExpectation.fulfill()
            }

        currencyRepository.set(currencies: mockCurrencies)

        wait(for: [dataSetUpdateExpectation], timeout: 10)

        XCTAssertEqual(currencyRepository.get(), Array(mockCurrencies.prefix(upTo: Configuration.currencyLimit)))
    }

    func testCurrencyRepository_whenSettingCurrency_shouldReceiveDataSetUpdate() throws {
        let mockCurrency = try Currency.mockData()
        let currencyRepository = CurrencyRepository()
        let dataSetUpdateExpectation = self.expectation(description: "Data set update.")

        let cancellable = currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { _ in
                dataSetUpdateExpectation.fulfill()
            }

        currencyRepository.set(currency: mockCurrency)

        wait(for: [dataSetUpdateExpectation], timeout: 10)

        XCTAssertEqual(currencyRepository.get(), [mockCurrency])
    }
}
