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
    @Published var showError: Bool = false

    @Injected private var api: AssetsApiProtocol
    @Injected private var currencyUtils: CurrencyUtilsProtocol
    @Injected private var currencyRepository: CurrencyRepositoryProtocol

    private var currencyDatasetNotifierCancellable: AnyCancellable?

    init() {
        fetchCurrencies()
        currencyDatasetNotifierCancellable = currencyRepository
            .dataSetUpdate
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                let currencies = self.currencyRepository.get()
                self.currencyListItems = self.process(currencies: currencies)
            }
    }

    private func fetchCurrencies() {
        Task { @MainActor in
            isLoading = true
            do {
                let response = try await api.fetchCurrencies()
                currencyRepository.set(currencies: response.data)
            } catch {
                showError = true
            }
            isLoading = false
        }
    }

    func getNavigationData(for currency: CurrencyListItemViewData) -> Currency {
        guard let navigationData = currencyRepository.currencies[currency.id] else {
            return Currency.from(id: currency.id, name: currency.name)
        }
        return navigationData
    }

    private func process(currencies: [Currency]) -> [CurrencyListItemViewData] {
        currencies.map { currencyUtils.convertToListItemViewData($0) }
    }
}

// MARK: - Localized

extension CurrencyListViewModel {

    var title: String {
        .currencyListScreenTitle
    }

    var errorAlertTitle: String {
        .alertErrorTitle
    }

    var errorMessage: String {
        .alertErrorGeneralMessage
    }

    var errorAlertOkButtonTitle: String {
        .alertOkButtonTitle
    }
}
