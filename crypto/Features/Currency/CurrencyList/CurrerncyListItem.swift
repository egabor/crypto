//
//  CurrencyListItem.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct CurrencyListItem: View {

    let viewData: CurrencyListItemViewData
    var configuration: Configuration = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .padding()
            .background(
                Color.currencyListItemBackground
                    .cornerRadius(configuration.cornerRadius)
            )
    }

    var content: some View {
        HStack(
            alignment: .top,
            spacing: configuration.innerSpacing
        ) {
            imageView
            currencyInfoView
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var imageView: some View {
        AsyncImageView(
            url: viewData.imageUrl,
            configuration: .init(iconSize: configuration.iconSize)
        )
    }

    var currencyInfoView: some View {
        VStack(
            alignment: .trailing,
            spacing: configuration.innerSpacing
        ) {
            HStack {
                currencyName(viewData.name)
                Spacer()
                currencyPrice(viewData.formattedPriceUsd)
            }
            HStack {
                currencySymbol(viewData.symbol)
                Spacer()
                currency24HrChange(
                    viewData.formattedChangePercent24Hr,
                    change: viewData.change
                )
            }
            arrowImage
        }
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    func currencyName(_ name: String) -> some View {
        Text(name)
            .headlineSmallTextStyle()
    }

    func currencyPrice(_ price: String) -> some View {
        Text(viewData.formattedPriceUsd)
            .bodyBoldTextStyle()
    }

    func currencySymbol(_ symbol: String) -> some View {
        Text(symbol)
            .bodyTextStyle()
    }

    func currency24HrChange(_ changePercent: String, change: CurrencyChangeType) -> some View {
        Text(changePercent)
            .foregroundColor(changeColor(for: change))
            .bodyBoldTextStyle()
    }

    var arrowImage: some View {
        Image.arrowRight
    }

    // TODO: eliminate Code duplication
    private func changeColor(for changeType: CurrencyChangeType) -> Color {
        switch changeType {
            case .none: return .contentText
            case .positive: return .contentGreen
            case .negative: return .contentRed
        }
    }
}

extension CurrencyListItem {
    struct Configuration {
        let cornerRadius: Double
        let innerSpacing: Double
        let iconSize: CGSize

        init(
            cornerRadius: Double = 16.0,
            innerSpacing: Double = 16.0,
            iconSize: CGSize = .init(width: 56.0, height: 56.0)
        ) {
            self.cornerRadius = cornerRadius
            self.innerSpacing = innerSpacing
            self.iconSize = iconSize
        }
    }
}

//struct CurrerncyListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrerncyListItem()
//    }
//}
