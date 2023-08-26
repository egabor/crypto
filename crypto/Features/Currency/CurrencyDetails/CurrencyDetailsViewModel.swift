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

    private var currency: Currency

    @Injected private var api: AssetsApiProtocol
    @Injected private var currencyUtils: CurrencyUtilsProtocol
    @Injected private var currencyRepository: CurrencyRepositoryProtocol

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
                print(error)
                //            shouldShowAlert = true
            }
            isLoading = false
        }
    }
}

// MARK: - Localized

extension CurrencyDetailsViewModel {

    var localizedPriceTitle: String {
        "Price"
    }

    var localized24hrChangeTitle: String {
        "Change (24hr)"
    }

    var localizedMarketCapTitle: String {
        "Market Cap"
    }

    var localized24hrVolumeTitle: String {
        "Volume (24hr)"
    }

    var localizedSupplyTitle: String {
        "Supply"
    }
}
