//
//  GlassmorphicCard.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct GlassmorphicCard: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {

            LinearGradient(
                gradient: Gradient(colors: [.purple, .blue, .teal]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .hueRotation(.degrees(isAnimating ? 45 : 0))
            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
            
            VStack {
                GlassProfileCard()
                    .padding()
                GlassStatsView()
                    .padding()
                GlassActionButtons()
                    .padding()
            }
            .frame(maxWidth: 350)
            .glassBackground()
            .onAppear {
                isAnimating = true
            }
        }
    }
}
