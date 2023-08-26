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
            imageView(for: viewData.imageUrl)
            currencyInfoView
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    @ViewBuilder
    func imageView(for url: URL?) -> some View {
        if let url = url {
            asyncImageView(url: url)
        } else {
            imageViewPlaceholder
        }
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

    func asyncImageView(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                imageViewPlaceholder
            } else {
                imageLoadingPlaceholder
            }
        }
        .frame(
            width: configuration.iconSize.width,
            height: configuration.iconSize.height,
            alignment: .center
        )
//        AsyncImageView(
//            url: url,
//            placeholder: imageLoadingPlaceholder,
//            image: image
//        )
    }

    var imageLoadingPlaceholder: some View {
        ProgressView()
            .frame(
                width: configuration.iconSize.width,
                height: configuration.iconSize.height
            )
            .tint(Color.progressViewTint)
    }

    var imageViewPlaceholder: some View {
        Circle()
            .frame(
                width: configuration.iconSize.width,
                height: configuration.iconSize.height
            )
            .foregroundColor(Color.black.opacity(0.1))
    }

//    func image(_ image: UIImage) -> some View {
//        Image(uiImage: image)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(
//                width: configuration.iconSize.width,
//                height: configuration.iconSize.height
//            )
//    }

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
