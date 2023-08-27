//
//  CurrencyDetailsViewModel.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import Foundation
import Resolver

final class CurrencyDetailsViewModel: ObservableObject {

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
        .currencyDetailsScreenPriceTitle
    }

    var last24hrChangeTitle: String {
        .currencyDetailsScreenLast24HrChangeTitle
    }

    var marketCapTitle: String {
        .currencyDetailsScreenMarketCapTitle
    }

    var last24hrVolumeTitle: String {
        .currencyDetailsScreenLast24HrVolumeTitle
    }

    var supplyTitle: String {
        .currencyDetailsScreenSupplyTitle
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
