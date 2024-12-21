//
//  GlassmorphicModifiers.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct GlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(0.2))
            .background(Color.white.opacity(0.5).blur(radius: 10))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
            )
    }
}

struct GlassProfileCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [.purple, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ), lineWidth: 4)
                )
                .shadow(radius: 10)
            
            Text("Speedyfriend67")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Developer & Producer")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

struct GlassStatsView: View {
    var body: some View {
        HStack(spacing: 30) {
            StatItem(value: "6.7K", title: "Posts")
            StatItem(value: "9.5K", title: "Followers")
            StatItem(value: "782", title: "Following")
        }
        .glassBackground()
    }
}

struct StatItem: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.vertical)
    }
}

struct GlassActionButtons: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Label("Follow", systemImage: "person.badge.plus")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.3))
                    .clipShape(Capsule())
            }
            
            Button(action: {}) {
                Label("Message", systemImage: "message.fill")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.purple.opacity(0.3))
                    .clipShape(Capsule())
            }
        }
    }
}
