//
//  TextStyles.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI

struct TextStyle {
    static let title = TextStyle(font: .system(size: 16, weight: .bold), color: Colors.highlighted)
    static let subtitle = TextStyle(font: .system(size: 12, weight: .semibold), color: Colors.subtitle)
    static let description = TextStyle(font: .system(size: 11, weight: .regular), color: Colors.description)
    static let price = TextStyle(font: .system(size: 16, weight: .bold), color: .mint)

    let font: Font
    let color: Color
}

extension Text {
    func textStyle(_ style: TextStyle) -> Text {
        self.font(style.font)
            .foregroundColor(style.color)
    }
}
