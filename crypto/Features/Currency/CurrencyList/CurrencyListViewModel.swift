//
//  CurrencyListViewModel.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import Foundation
import Combine
import Resolver

class CurrencyListViewModel: ObservableObject {

    @Published var currencyListItems: [CurrencyListItemViewData] = []
    @Published var isLoading: Bool = false

    @Injected private var api: AssetsApiProtocol
    @Injected private var currencyUtils: CurrencyUtilsProtocol
    @Injected private var currencyRepository: CurrencyRepositoryProtocol

    private var currencyDatasetNotifierCancellable: AnyCancellable?
    init() {
//        if let url = Bundle.main.url(forResource: "currencies_mock", withExtension: "json") {
//            do {
//                let jsonData = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let mapped = try decoder.decode([Currency].self, from: jsonData)
//                currencies = process(currencies: mapped)
//            } catch {
//                print(error)
//            }
//        }
        getCurrencies()
        currencyDatasetNotifierCancellable = currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                let currencies = self.currencyRepository.get()
                self.currencyListItems = self.process(currencies: currencies)
            }
    }

    private func getCurrencies() {
        Task { @MainActor in
            isLoading = true
            do {
                let response = try await api.fetchCurrencies()
                currencyRepository.set(currencies: response.data)
            } catch {
                print(error)
                //            shouldShowAlert = true
            }
            isLoading = false
        }
    }

    private func process(currencies: [Currency]) -> [CurrencyListItemViewData] {
        currencies.map { currencyUtils.convertToListItemViewData($0) }
    }

    func getNavigationData(for currency: CurrencyListItemViewData) -> Currency {
        guard let navigationData = currencyRepository.currencies[currency.id] else {
            return Currency.from(id: currency.id, name: currency.name)
        }
        return navigationData
    }
}

// MARK: - Localized

extension CurrencyListViewModel {

    var localizedTitle: String {
        "COINS"
    }
}
