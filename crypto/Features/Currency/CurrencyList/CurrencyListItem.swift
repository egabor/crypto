//
//  CurrencyListItem.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct CurrencyListItem: View {
    var viewData: CurrencyDetailsViewData

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            imageView(for: currency)

            VStack(alignment: .trailing, spacing: 16) {
                HStack {
                    Text(currency.name)
                        .headlineSmallTextStyle()
                    Spacer(minLength: 16)
                    Text(currency.formattedPriceUsd)
                        .bodyBoldTextStyle()
                }
                HStack {
                    Text(currency.symbol)
                        .bodyTextStyle()
                    Spacer(minLength: 16)
                    Text(currency.formattedChangePercent24Hr)
                        .foregroundColor(changeColor(for: currency.change))
                        .bodyBoldTextStyle()
                }
                Image.arrowRight
            }
        }
        .padding()
        .background(
            Color.currencyListItemBackground.cornerRadius(16)
        )
    }
}

struct CurrerncyListItem_Previews: PreviewProvider {
    static var previews: some View {
        CurrerncyListItem()
    }
}
