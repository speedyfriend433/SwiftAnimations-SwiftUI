//
//  ContentView.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @State private var selectedDesign: DesignType = .glassmorphic
    @State private var menuOpacity: Double = 0
    
    var body: some View {
        ZStack {
            
            selectedDesign.getView()
            
            if showMenu {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        closeMenu()
                    }
                    .opacity(menuOpacity)
            }
            
            VStack {
                HStack {
                    ZStack(alignment: .topLeading) {
                        Button(action: {
                            if showMenu {
                                closeMenu()
                            } else {
                                openMenu()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                                .rotation3DEffect(
                                    .degrees(showMenu ? 90 : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                        }
                        .zIndex(2)
                        
                        if showMenu {
                            MenuOverlay(selectedDesign: $selectedDesign, isShowing: $showMenu, closeMenu: closeMenu)
                                .offset(y: 50)
                                .opacity(menuOpacity)
                                .transition(.opacity)
                                .zIndex(1)
                        }
                    }
                    
                    if !showMenu {
                        Text(selectedDesign.title)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(20)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, -10)
                
                Spacer()
            }
            .zIndex(3)
        }
    }
    
    private func openMenu() {
        withAnimation(.easeOut(duration: 0.2)) {
            showMenu = true
        }
        withAnimation(.easeOut(duration: 0.3)) {
            menuOpacity = 1
        }
    }
    
    private func closeMenu() {
        withAnimation(.easeIn(duration: 0.2)) {
            menuOpacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeIn(duration: 0.1)) {
                showMenu = false
            }
        }
    }
}

struct MenuOverlay: View {
    @Binding var selectedDesign: DesignType
    @Binding var isShowing: Bool
    let closeMenu: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Select Design")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            
            Divider()
                .background(Color.white.opacity(0.2))
            
            ForEach(DesignType.allCases) { design in
                Button(action: {
                    withAnimation(.spring()) {
                        selectedDesign = design
                        closeMenu()
                    }
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: design.icon)
                            .font(.system(size: 20))
                            .frame(width: 24)
                        
                        Text(design.title)
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if selectedDesign == design {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                    .foregroundColor(selectedDesign == design ? .white : .gray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        selectedDesign == design ?
                        Color.blue.opacity(0.3) :
                        Color.clear
                    )
                }
                .contentShape(Rectangle())
                .hoverEffect(.highlight)
            }
        }
        .background(
            Color.black.opacity(0.9)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .frame(width: 200)
    }
}

enum DesignType: String, CaseIterable, Identifiable {
    case glassmorphic
    case neumorphic
    case weather
    case glow
    case animated
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .glassmorphic: return "Glassmorphic"
        case .neumorphic: return "Neumorphic"
        case .weather: return "Weather"
        case .glow: return "Glow"
        case .animated: return "Animated"
        }
    }
    
    var icon: String {
        switch self {
        case .glassmorphic: return "circle.hexagongrid.fill"
        case .neumorphic: return "square.stack.3d.up.fill"
        case .weather: return "cloud.sun.fill"
        case .glow: return "creditcard.fill"
        case .animated: return "sparkles"
        }
    }
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .glassmorphic:
            GlassmorphicCard()
        case .neumorphic:
            NeumorphicDashboard()
        case .weather:
            WeatherCard()
        case .glow:
            GlowWalletView()
        case .animated:
            AnimatedCardsView()
        }
    }
}

// MARK: - Glassmorphic Card




// MARK: - Neumorphic Dashboard




// MARK: - Weather Card




// MARK: - Supporting Views




// MARK: - View Modifiers




// MARK: - View Extensions




// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: - Preview

#Preview {
    ContentView()
}
