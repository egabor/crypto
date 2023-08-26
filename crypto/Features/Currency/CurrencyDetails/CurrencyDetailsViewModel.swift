//
//  CurrencyDetailsViewModel.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import Foundation
import Resolver

class CurrencyDetailsViewModel: ObservableObject {

    @Published var viewData: CurrencyDetailsViewData = .empty
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false

    @Injected private var api: AssetsApiProtocol
    @Injected private var currencyUtils: CurrencyUtilsProtocol
    @Injected private var currencyRepository: CurrencyRepositoryProtocol

    private var currency: Currency

    init(currency: Currency) {
        self.currency = currency
        self.viewData = currencyUtils.convertToDetailsViewData(currency)
        getCurrency(by: currency.id)
    }

    private func getCurrency(by id: String) {
        Task { @MainActor in
            isLoading = true
            do {
                let response = try await api.fetchCurrency(by: id)
                currency = response.data
                viewData = currencyUtils.convertToDetailsViewData(currency)
                currencyRepository.set(currency: currency)
            } catch {
                showError = true
            }
            isLoading = false
        }
    }
}

// MARK: - Localized

extension CurrencyDetailsViewModel {

    var priceTitle: String {
        "Price"
    }

    var last24hrChangeTitle: String {
        "Change (24hr)"
    }

    var marketCapTitle: String {
        "Market Cap"
    }

    var last24hrVolumeTitle: String {
        "Volume (24hr)"
    }

    var supplyTitle: String {
        "Supply"
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
