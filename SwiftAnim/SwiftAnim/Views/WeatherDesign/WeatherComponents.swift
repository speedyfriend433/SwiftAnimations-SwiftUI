//
//  WeatherComponents.swift
//  SwiftAnim
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct WeatherDetailItem: View {
    let icon: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 25))
            Text(value)
                .font(.system(size: 16))
        }
        .foregroundColor(.white)
    }
}

struct WeatherHourlyItem: View {
    let hour: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\((hour + 1) % 12 + 1)\(hour < 11 ? "AM" : "PM")")
                .font(.system(size: 14))
            Image(systemName: "sun.max.fill")
                .font(.system(size: 25))
            Text("\(Int.random(in: 68...75))°")
                .font(.system(size: 16))
        }
        .foregroundColor(.white)
    }
}
