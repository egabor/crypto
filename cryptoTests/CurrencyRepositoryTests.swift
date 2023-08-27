//
//  CurrencyRepositoryTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import XCTest
import Combine
@testable import crypto

final class CurrencyRepositoryTests: XCTestCase {

    private var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        subscriptions = []
    }

    func test_currencyRepository_whenSettingListOfCurrencies_shouldReceiveDataSetUpdate() throws {
        let mockCurrencies = try [Currency].mockData()
        let currencyRepository = CurrencyRepository()
        let expectation = self.expectation(description: "Data set update.")

        currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        currencyRepository.set(currencies: mockCurrencies)

        wait(for: [expectation], timeout: 10)

        XCTAssertEqual(currencyRepository.get(), Array(mockCurrencies.prefix(upTo: Configuration.currencyLimit)))
    }

    func test_currencyRepository_whenSettingCurrency_shouldReceiveDataSetUpdate() throws {
        let mockCurrency = try Currency.mockData()
        let currencyRepository = CurrencyRepository()
        let expectation = self.expectation(description: "Data set update.")

        currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        currencyRepository.set(currency: mockCurrency)

        wait(for: [expectation], timeout: 10)

        XCTAssertEqual(currencyRepository.get(), [mockCurrency])
    }
}
