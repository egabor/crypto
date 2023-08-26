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
    var viewData: CurrencyDetailsViewData {
        viewModel.viewData
    }

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
                value: viewData.formattedPriceUsd
            )
            DetailRow(
                title: viewModel.localized24hrChangeTitle,
                value: viewData.formattedChangePercent24Hr,
                valueCustomColor: color(for: viewData.change)
            )

            contentDivider

            DetailRow(
                title: viewModel.localizedMarketCapTitle,
                value: viewData.formattedMarketCap
            )
            DetailRow(
                title: viewModel.localized24hrVolumeTitle,
                value: viewData.formatted24hrVolume
            )
            DetailRow(
                title: viewModel.localizedSupplyTitle,
                value: viewData.formattedSupply
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
        Text(viewData.title)
            .headlineTextStyle()
    }

    var imageView: some View {
        AsyncImageView(
            url: viewData.imageUrl,
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

    func color(for change: CurrencyChangeType) -> Color {
        change.color
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
