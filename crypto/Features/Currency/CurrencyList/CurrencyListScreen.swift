//
//  CurrencyListScreen.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

struct CurrencyListScreen: View {

    @StateObject private var viewModel: CurrencyListViewModel = .init()
    var configuration: Configuration = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .padding(.horizontal)
            .backgroundGradient()
    }

    var content: some View {
        VStack(alignment: .leading) {
            title
            list
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var title: some View {
        Text(viewModel.localizedTitle)
            .headlineTextStyle()
    }

    @ViewBuilder
    var list: some View {
        if viewModel.isLoading { // TODO: double check loading UI
            listLoadingIndicator
        } else {
            listContent
        }
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    var listLoadingIndicator: some View {
        VStack { // TODO: revise
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer()
        }
    }

    var listContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: configuration.rowSpacing) {
                ForEach(viewModel.currencyListItems, content: row)
            }
        }
    }

    func row(_ viewData: CurrencyListItemViewData) -> some View {
        NavigationLink(
            destination: { rowDestination(for: viewData) },
            label: { rowContent(for: viewData) }
        )
    }

    func rowDestination(for viewData: CurrencyListItemViewData) -> some View {
        CurrencyDetailsScreen(with: viewModel.getNavigationData(for: viewData))
    }

    func rowContent(for viewData: CurrencyListItemViewData) -> some View {
        CurrencyListItem(viewData: viewData)
    }
}

extension CurrencyListScreen {
    struct Configuration {
        let rowSpacing: Double

        init(
            rowSpacing: Double = 16.0
        ) {
            self.rowSpacing = rowSpacing
        }
    }
}

struct CurrencyListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListScreen()
    }
}
