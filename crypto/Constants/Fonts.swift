//
//  Fonts.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 24..
//

import SwiftUI

struct PoppinsFont {
    static let regular = "Poppins-Regular"
    static let bold = "Poppins-Bold"
}

// TODO: move to design system

// MARK: - Headline

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

// MARK: - Headline Small

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


// MARK: - Body

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

// MARK: - Body Bold

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
