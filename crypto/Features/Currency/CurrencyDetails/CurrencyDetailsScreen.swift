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
            imageView
                .padding(.trailing)
        }
    }

    var currencyInfoView: some View {
        VStack(spacing: configuration.rowSpacing) {
            DetailRow(
                title: viewModel.localizedPriceTitle,
                value: viewModel.viewData.formattedPriceUsd
            )
            DetailRow(
                title: viewModel.localized24hrChangeTitle,
                value: viewModel.viewData.formattedChangePercent24Hr,
                valueCustomColor: viewModel.viewData.change.color
            )

            contentDivider

            DetailRow(
                title: viewModel.localizedMarketCapTitle,
                value: viewModel.viewData.formattedMarketCap
            )
            DetailRow(
                title: viewModel.localized24hrVolumeTitle,
                value: viewModel.viewData.formatted24hrVolume
            )
            DetailRow(
                title: viewModel.localizedSupplyTitle,
                value: viewModel.viewData.formattedSupply
            )
            Spacer()
        }
        .padding(configuration.infoViewPadding)
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

    var imageView: some View {
        AsyncImageView(
            url: viewModel.viewData.imageUrl,
            configuration: .init(iconSize: configuration.iconSize)
        )
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

    var contentDivider: some View {
        Divider()
            .frame(height: configuration.dividerHeight)
            .overlay(Color.divider)
            .padding(.vertical)
    }
}

extension CurrencyDetailsScreen {
    struct Configuration {
        let iconSize: CGSize
        let rowSpacing: Double
        let cornerRadius: Double
        let dividerHeight: Double
        let infoViewPadding: Double

        init(
            iconSize: CGSize = .init(width: 40.0, height: 40.0),
            rowSpacing: Double = 16.0,
            cornerRadius: Double = 16.0,
            dividerHeight: Double = 1.0,
            infoViewPadding: Double = 24.0
        ) {
            self.iconSize = iconSize
            self.rowSpacing = rowSpacing
            self.cornerRadius = cornerRadius
            self.dividerHeight = dividerHeight
            self.infoViewPadding = infoViewPadding
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
