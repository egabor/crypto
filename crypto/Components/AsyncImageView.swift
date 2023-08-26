//
//  AsyncImageView.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct AsyncImageView: View {

    let url: URL?
    var configuration: Configuration

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .frame(
                width: configuration.iconSize.width,
                height: configuration.iconSize.height,
                alignment: .center
            )
    }

    @ViewBuilder
    var content: some View {
        if let url = url {
            asyncImageView(url: url)
        } else {
            imageViewPlaceholder
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

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
    }

    var imageLoadingPlaceholder: some View {
        ProgressView()
            .tint(Color.progressViewTint)
    }

    var imageViewPlaceholder: some View {
        Circle()
            .foregroundColor(Color.black.opacity(0.1))
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents
}

extension AsyncImageView {
    struct Configuration {
        let iconSize: CGSize
        
        init(
            iconSize: CGSize = .init(width: 40.0, height: 40.0)
        ) {
            self.iconSize = iconSize
        }
    }
}

//struct AsyncImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView()
//    }
//}
