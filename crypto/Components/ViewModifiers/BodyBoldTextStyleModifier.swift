//
//  BodyBoldTextStyleModifier.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct BodyBoldTextStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(PoppinsFont.bold, size: 16))
            .foregroundColor(.contentText)
    }
}

extension View {
    func bodyBoldTextStyle() -> some View {
        modifier(BodyBoldTextStyleModifier())
    }
}
