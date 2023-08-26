//
//  AsyncImageView.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 25..
//
//  Source: https://stackoverflow.com/questions/60677622/how-to-display-image-from-a-url-in-swiftui
//  Using a custom view for loading async images as the built-in AsyncImage cancels the image loading
//  when the user scrolls fast. 

import SwiftUI

struct AsyncImageView<Placeholder: View, Image: View>: View {

    @StateObject private var viewModel: AsyncImageViewModel

    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(
        url: URL?,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image
    ) {
        self.placeholder = placeholder()
        self.image = image
        _viewModel = .init(wrappedValue: .init(url: url))
    }

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .onAppear(perform: viewModel.loadImage)
    }

    @ViewBuilder
    var content: some View {
        if let cachedImage = viewModel.image {
            image(cachedImage)
        } else {
            placeholder
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents
}
