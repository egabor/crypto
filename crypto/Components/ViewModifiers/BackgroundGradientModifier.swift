//
//  BackgroundGradientModifier.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Color.backgroundGradientBase
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                .backgroundGradientTop,
                                .backgroundGradientBottom
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func backgroundGradient() -> some View {
        modifier(BackgroundGradientModifier())
    }
}

