//
//  WeatherCard.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct WeatherCard: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {

            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {

                VStack {
                    Text("San Francisco")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Sunday, 2:30 PM")
                        .font(.subheadline)
                }
                .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.yellow)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 10)
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                    
                    Text("72°")
                        .font(.system(size: 80, weight: .thin))
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 30) {
                    WeatherDetailItem(icon: "wind", value: "12mph")
                    WeatherDetailItem(icon: "humidity.fill", value: "68%")
                    WeatherDetailItem(icon: "umbrella.fill", value: "0%")
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<8) { hour in
                            WeatherHourlyItem(hour: hour)
                        }
                    }
                    .padding()
                }
                .background(Color.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            .onAppear {
                isAnimating = true
            }
        }
    }
}

