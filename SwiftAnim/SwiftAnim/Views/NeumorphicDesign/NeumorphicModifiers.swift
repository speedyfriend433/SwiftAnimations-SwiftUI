//
//  NeumorphicModifiers.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct NeumorphicModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
