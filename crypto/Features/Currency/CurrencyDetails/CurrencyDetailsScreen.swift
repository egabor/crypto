//
//  CurrencyDetailsScreen.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

struct CurrencyDetailsScreen: View {

    @StateObject private var viewModel: CurrencyDetailsViewModel
    var configuration: Configuration

    @Environment(\.dismiss) var dismiss

    init(
        with currency: Currency,
        configuration: Configuration = .init()
    ) {
        _viewModel = .init(wrappedValue: .init(currency: currency))
        self.configuration = configuration
    }

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .hiddenNavigationBar()
            .backgroundGradient()
    }

    var content: some View {
        VStack {
            navigationBar
            currencyInfoView
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var navigationBar: some View {
        HStack {
            backButton
            title
            Spacer()
            imageView(for: viewModel.viewData.imageUrl)
                .padding(.trailing)
        }
    }

    var currencyInfoView: some View {
        VStack(spacing: configuration.rowSpacing) {
            detailRow(
                title: viewModel.localizedPriceTitle,
                value: viewModel.viewData.formattedPriceUsd
            )
            detailRow(
                title: viewModel.localized24hrChangeTitle,
                value: viewModel.viewData.formattedChangePercent24Hr,
                valueColor: changeColor(for: viewModel.viewData.change)
            )

            contentDivider

            detailRow(
                title: viewModel.localizedMarketCapTitle,
                value: viewModel.viewData.formattedMarketCap
            )
            detailRow(
                title: viewModel.localized24hrVolumeTitle,
                value: viewModel.viewData.formatted24hrVolume
            )
            detailRow(
                title: viewModel.localizedSupplyTitle,
                value: viewModel.viewData.formattedSupply
            )
            Spacer()
        }
        .padding(24)
        .background(
            Color.currencyListItemBackground
                .cornerRadius(configuration.cornerRadius)
        )
        .overlay(loadingOverlay)
        .padding(.horizontal)
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    var backButton: some View {
        Button(
            action: { dismiss() },
            label: {
                Image.chevronLeft
                    .padding()
                    .padding(.trailing)
            }
        )
    }

    var title: some View {
        Text(viewModel.viewData.title)
            .headlineTextStyle()
    }

    @ViewBuilder
    func imageView(for url: URL?) -> some View {
        if let url = url {
            asyncImageView(url: url)
        } else {
            imageViewPlaceholder
        }
    }

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

    @ViewBuilder
    var loadingOverlay: some View {
        if viewModel.isLoading {
            ZStack(alignment: .center) {
                Color.currencyDetailsContentLoadingOverlay
                    .cornerRadius(configuration.cornerRadius)
                ProgressView()
                    .tint(Color.progressViewTint)
            }
            .transition(.opacity.animation(.easeIn))
        }
    }

    func detailRow(
        title: String,
        value: String,
        valueColor: Color = .contentText
    ) -> some View {
        HStack {
            Text(title)
                .bodyTextStyle()
            Spacer()
            Text(value)
                .foregroundColor(valueColor)
                .bodyBoldTextStyle()
        }
    }

    var contentDivider: some View {
        Divider()
            .frame(height: configuration.dividerHeight)
            .overlay(Color.divider)
            .padding(.vertical)
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

extension CurrencyDetailsScreen {
    struct Configuration {
        let iconSize: CGSize
        let rowSpacing: Double
        let cornerRadius: Double
        let dividerHeight: Double

        init(
            iconSize: CGSize = .init(width: 40.0, height: 40.0),
            rowSpacing: Double = 16.0,
            cornerRadius: Double = 16.0,
            dividerHeight: Double = 1.0
        ) {
            self.iconSize = iconSize
            self.rowSpacing = rowSpacing
            self.cornerRadius = cornerRadius
            self.dividerHeight = dividerHeight
        }
    }
}

struct CurrencyDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsScreen(
            with: Currency.from(id: "bitcoin", name: "BITCOIN")
        )
    }
}
