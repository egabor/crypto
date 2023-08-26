//
//  HiddenNavigationBar.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}

extension View {
    func hiddenNavigationBar() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
