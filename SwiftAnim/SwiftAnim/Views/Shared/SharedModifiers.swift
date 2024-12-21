//
//  SharedModifiers.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

extension View {
    func glassBackground() -> some View {
        self.modifier(GlassModifier())
    }
    
    func neumorphicStyle() -> some View {
        self.modifier(NeumorphicModifier())
    }
}
