//
//  BodyTextStyleModifier.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct BodyTextStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(PoppinsFont.regular, size: 16))
            .foregroundColor(.contentText)
    }
}

extension View {
    func bodyTextStyle() -> some View {
        modifier(BodyTextStyleModifier())
    }
}
