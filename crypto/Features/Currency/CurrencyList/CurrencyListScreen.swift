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
            .alert(
                LocalizedStringKey(viewModel.errorAlertTitle),
                isPresented: $viewModel.showError,
                actions: errorAlertActions,
                message: errorAlertMessage
            )
    }

    var content: some View {
        VStack {
            title
            list
        }
    }
    
    // MARK: - LEVEL 1 Views: Main UI Elements
    
    var title: some View {
        HStack {
            Text(LocalizedStringKey(viewModel.title))
                .headlineTextStyle()
            Spacer()
        }
    }
    
    @ViewBuilder
    var list: some View {
        if viewModel.isLoading {
            listLoadingIndicator
        } else {
            listContent
        }
    }
    
    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents
    
    var listLoadingIndicator: some View {
        VStack {
            Spacer()
            ProgressView()
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

    func errorAlertActions() -> some View {
        Text(LocalizedStringKey(viewModel.errorAlertOkButtonTitle))
    }

    func errorAlertMessage() -> some View {
        Text(LocalizedStringKey(viewModel.errorMessage))
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
