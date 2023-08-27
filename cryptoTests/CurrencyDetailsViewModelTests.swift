//
//  CurrencyDetailsViewModelTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 27..
//

import XCTest
import Resolver
import Combine
@testable import crypto

final class CurrencyDetailsViewModelTests: XCTestCase {

    private var subscriptions: Set<AnyCancellable>!
    @LazyInjected private var assetsApi: MockAssetsApi

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        subscriptions = []
        Resolver.resetUnitTestRegistrations()
    }

    func test_viewModelState_initial() throws {
        let payload: Currency = .from(id: "any", name: "any")
        let viewModel = CurrencyDetailsViewModel(currency: payload)

        XCTAssertNotEqual(viewModel.viewData, .empty)
        XCTAssertEqual(viewModel.viewData.id, payload.id)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
    }

    func test_viewModelState_whenReceivingResult() throws {
        assetsApi.mockAssetResult = .successValidResult
        let payload: Currency = .from(id: "any", name: "any")
        let viewModel = CurrencyDetailsViewModel(currency: payload)

        XCTAssertNotEqual(viewModel.viewData, .empty)
        XCTAssertEqual(viewModel.viewData.id, payload.id)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)

        let expectation = self.expectation(description: "Receive result.")

        viewModel.$viewData
            .dropFirst()
            .first()
            .receive(on: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 10)

        XCTAssertNotEqual(viewModel.viewData, .empty)
        XCTAssertNotEqual(viewModel.viewData.id, payload.id)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
    }

    func test_viewModelState_whenReceivingError() throws {
        assetsApi.mockAssetResult = .failure
        let payload: Currency = .from(id: "any", name: "any")
        let viewModel = CurrencyDetailsViewModel(currency: payload)

        XCTAssertNotEqual(viewModel.viewData, .empty)
        XCTAssertEqual(viewModel.viewData.id, payload.id)
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

        XCTAssertNotEqual(viewModel.viewData, .empty)
        XCTAssertEqual(viewModel.viewData.id, payload.id)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, true)
    }
}
