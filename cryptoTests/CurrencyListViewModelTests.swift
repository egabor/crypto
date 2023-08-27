//
//  CurrencyListViewModelTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import XCTest
import Resolver
import Combine
@testable import crypto

final class CurrencyListViewModelTests: XCTestCase {

    private var subscriptions: Set<AnyCancellable>!
    @LazyInjected private var assetsApi: MockAssetsApi

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        subscriptions = []
        Resolver.resetUnitTestRegistrations()
    }

    func test_viewModelState_initial() throws {
        let viewModel = CurrencyListViewModel()

        XCTAssertEqual(viewModel.currencyListItems, [])
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
    }

    func test_viewModelState_whenReceivingResults() throws {
        assetsApi.mockAssetsResult = .successValidResults
        let viewModel = CurrencyListViewModel()

        XCTAssertEqual(viewModel.currencyListItems, [])
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)

        let expectation = self.expectation(description: "Receive results.")

        viewModel.$currencyListItems
            .dropFirst()
            .first()
            .receive(on: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 10)

        XCTAssertNotEqual(viewModel.currencyListItems, [])
        XCTAssertLessThanOrEqual(viewModel.currencyListItems.count, Configuration.currencyLimit)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
    }

    func test_viewModelState_whenReceivingError() throws {
        assetsApi.mockAssetsResult = .failure
        let viewModel = CurrencyListViewModel()

        XCTAssertEqual(viewModel.currencyListItems, [])
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)

        let expectation = self.expectation(description: "Receive error.")

        viewModel.$showError
            .dropFirst()
            .first()
            .receive(on: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 10)

        XCTAssertEqual(viewModel.currencyListItems, [])
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, true)
    }
}
