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
