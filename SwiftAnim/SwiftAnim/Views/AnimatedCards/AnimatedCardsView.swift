//
//  AnimatedCardsView.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct AnimatedCardsView: View {
    @State private var isAnimating = false
    @State private var selectedCard: Int? = nil
    @State private var dragAmount = CGSize.zero
    @State private var cards: [CardItem] = [
        CardItem(color: .purple, icon: "swift", title: "Swift"),
        CardItem(color: .blue, icon: "paintpalette.fill", title: "Design"),
        CardItem(color: .orange, icon: "gear", title: "Settings"),
        CardItem(color: .green, icon: "chart.bar.fill", title: "Analytics")
    ]
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(hex: "1a1a1a")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .overlay(
                ZStack {
                    ForEach(0..<20) { index in
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: CGFloat.random(in: 10...50))
                            .position(
                                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                            )
                            .blur(radius: 2)
                            .opacity(isAnimating ? 1 : 0)
                            .animation(
                                Animation.easeInOut(duration: 3)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 0.1),
                                value: isAnimating
                            )
                    }
                }
            )
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Interactive Cards")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.1),
                            value: isAnimating
                        )
                    
                    ForEach(cards.indices, id: \.self) { index in
                        AnimatedCard(
                            card: cards[index],
                            isSelected: selectedCard == index,
                            onTap: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    selectedCard = selectedCard == index ? nil : index
                                }
                            }
                        )
                        .offset(y: CGFloat(index * (selectedCard == nil ? 0 : -20)))
                        .zIndex(selectedCard == index ? 1 : 0)
                        .scaleEffect(selectedCard == index ? 1.1 : 1)
                        .opacity(selectedCard == nil ? 1 : (selectedCard == index ? 1 : 0.7))
                    }
                }
                .padding()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                isAnimating = true
            }
        }
    }
}

struct CardItem {
    let color: Color
    let icon: String
    let title: String
}

struct AnimatedCard: View {
    let card: CardItem
    let isSelected: Bool
    let onTap: () -> Void
    @State private var isHovered = false
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            card.color,
                            card.color.opacity(0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: card.color.opacity(0.3), radius: isSelected ? 20 : 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: card.icon)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(rotation))
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .repeatForever(autoreverses: false),
                            value: rotation
                        )
                    
                    Text(card.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    if isSelected {
                        Text("Tap to minimize")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .transition(.opacity)
                    }
                }
                Spacer()
                
                ZStack {
                    ForEach(0..<3) { i in
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            .frame(width: CGFloat(40 + i * 20))
                            .scaleEffect(isHovered ? 1.1 : 1)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.2),
                                value: isHovered
                            )
                    }
                }
            }
            .padding()
        }
        .frame(height: isSelected ? 200 : 100)
        .onTapGesture(perform: onTap)
        .onAppear {
            isHovered = true
            rotation = 360
        }
    }
}

// MARK: - RGB Helper

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
