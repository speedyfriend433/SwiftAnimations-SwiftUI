//
//  NeumorphicDashboard.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct NeumorphicDashboard: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Dashboard")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("Welcome back, Speedy")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .neumorphicStyle()
                    }
                    .padding()
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        NeumorphicCard(title: "Revenue", value: "$12,849", icon: "dollarsign.circle.fill", color: .green)
                        NeumorphicCard(title: "Orders", value: "124", icon: "cart.fill", color: .blue)
                        NeumorphicCard(title: "Customers", value: "847", icon: "person.2.fill", color: .purple)
                        NeumorphicCard(title: "Products", value: "42", icon: "cube.fill", color: .orange)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Activity")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack(alignment: .bottom, spacing: 15) {
                            ForEach(0..<7) { index in
                                ActivityBar(height: CGFloat.random(in: 50...150))
                            }
                        }
                        .padding()
                    }
                    .neumorphicStyle()
                    .padding()
                }
            }
        }
    }
}

struct NeumorphicCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 30))
            
            Text(title)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .neumorphicStyle()
    }
}

struct ActivityBar: View {
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.blue)
            .frame(width: 30, height: height)
            .neumorphicStyle()
    }
}
