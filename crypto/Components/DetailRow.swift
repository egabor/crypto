//
//  DetailRow.swift
//  crypto
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import SwiftUI

struct DetailRow: View {

    let title: String
    let value: String
    var valueCustomColor: Color = .contentText

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
    }

    var content: some View {
        HStack {
            titleText
            Spacer()
            valueText
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var titleText: some View {
        Text(LocalizedStringKey(title))
            .bodyTextStyle()
    }

    var valueText: some View {
        Text(value)
            .foregroundColor(valueCustomColor)
            .bodyBoldTextStyle()
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents
}
