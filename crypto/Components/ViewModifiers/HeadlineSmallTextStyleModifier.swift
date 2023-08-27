//
//  HeadlineSmallTextStyleModifier.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct HeadlineSmallTextStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(PoppinsFont.bold, size: 20))
            .foregroundColor(.contentText)
    }
}

extension View {
    func headlineSmallTextStyle() -> some View {
        modifier(HeadlineSmallTextStyleModifier())
    }
}
