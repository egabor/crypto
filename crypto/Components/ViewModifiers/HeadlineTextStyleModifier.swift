//
//  HeadlineTextStyleModifier.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct HeadlineTextStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(PoppinsFont.bold, size: 32))
            .foregroundColor(.contentText)
    }
}

extension View {
    func headlineTextStyle() -> some View {
        modifier(HeadlineTextStyleModifier())
    }
}
