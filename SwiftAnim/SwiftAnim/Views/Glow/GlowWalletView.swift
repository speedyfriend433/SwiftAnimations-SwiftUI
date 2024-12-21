//
//  GlowWalletView.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct GlowWalletView: View {
    @State private var selectedTimeframe = 0
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 25) {

                HStack {
                    Text("WALLET")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    GlowCard(
                        balance: "$4,238.72",
                        change: "+$1,081.23 (34.2%)",
                        isPositive: true
                    )
                    
                    HStack(spacing: 8) {
                        ForEach(0..<3) { i in
                            Circle()
                                .fill(Color.white.opacity(i == 0 ? 1 : 0.3))
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Crypto Wallet Balance")
                        .foregroundColor(.gray)
                    Text("$2,412.8")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    CryptoRow(
                        icon: "bitcoinsign.circle.fill",
                        name: "BTC",
                        amount: "$1,004.2",
                        coins: "0.000072",
                        change: "+2.32%",
                        isPositive: true
                    )
                    
                    CryptoRow(
                        icon: "diamond.circle.fill",
                        name: "ETH",
                        amount: "$1,205.81",
                        coins: "7.3991",
                        change: "+9.61%",
                        isPositive: true
                    )
                    
                    CryptoRow(
                        icon: "circle.hexagongrid.circle.fill",
                        name: "XRP",
                        amount: "$197.57",
                        coins: "39812.2",
                        change: "-4.32%",
                        isPositive: false
                    )
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

struct CryptoRow: View {
    let icon: String
    let name: String
    let amount: String
    let coins: String
    let change: String
    let isPositive: Bool
    
    var body: some View {
        HStack {
            // Icon
            Group {
                switch name {
                case "BTC":
                    Image(systemName: "bitcoinsign.circle.fill")
                case "ETH":
                    Image(systemName: "diamond.circle.fill")
                case "XRP":
                    Image(systemName: "circle.hexagongrid.circle.fill")
                default:
                    Image(systemName: "cryptocurrency.circle.fill")
                }
            }
            .font(.system(size: 24))
            .foregroundColor(iconColor)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(amount)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text("\(coins) \(name)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            
            Spacer()
            
            HStack(spacing: 8) {

                Path { path in
                    path.move(to: CGPoint(x: 0, y: isPositive ? 20 : 0))
                    path.addCurve(
                        to: CGPoint(x: 40, y: isPositive ? 0 : 20),
                        control1: CGPoint(x: 15, y: isPositive ? 0 : 20),
                        control2: CGPoint(x: 25, y: isPositive ? 20 : 0)
                    )
                }
                .stroke(isPositive ? Color.green : Color.red, lineWidth: 2)
                .frame(width: 40, height: 20)
                
                Text(change)
                    .foregroundColor(isPositive ? .green : .red)
                    .font(.system(size: 14))
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
    
    var iconColor: Color {
        switch name {
        case "BTC": return .orange
        case "ETH": return .purple
        case "XRP": return .blue
        default: return .gray
        }
    }
}

struct GlowCard: View {
    let balance: String
    let change: String
    let isPositive: Bool
    
    var body: some View {
        ZStack {

            LinearGradient(
                gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.8549019608, green: 0.2235294118, blue: 0.8, alpha: 1)),
                    Color(#colorLiteral(red: 0.2235294118, green: 0.4, blue: 0.8549019608, alpha: 1))
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(
                color: Color(#colorLiteral(red: 0.8549019608, green: 0.2235294118, blue: 0.8, alpha: 0.5)),
                radius: 20,
                x: 0,
                y: 0
            )
            
            VStack(alignment: .leading, spacing: 10) {
                Text(balance)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Text(change)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 160)
        .padding(.horizontal)
    }
}
