//
//  View+HiddenNavigationBar.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

public extension View {
    func hiddenNavigationBar() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

public struct HiddenNavigationBar: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}
