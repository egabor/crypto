//
//  cryptoApp.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

@main
struct cryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CurrencyListScreen()
            }
        }
    }
}

// TODO: move to its own file

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
