//
//  CurrencyUtilsProtocol.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import Foundation

protocol CurrencyUtilsProtocol {

    func convertToListItemViewData(_ currency: Currency) -> CurrencyListItemViewData
    func convertToDetailsViewData(_ currency: Currency) -> CurrencyDetailsViewData
}
