//
//  CarouselTabView.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import SwiftUI

struct CarouselTabView: View {
    
    let premiumChoiced: AdvantagesOfPremium
    
    
    var body: some View {
        VStack {
            image
            
            VStack(spacing: 0) {
                description
                    .frame(height: 135, alignment: .top)
                
                detail
            }
        }
    }
    
    var image: some View {
        Image(systemName: premiumChoiced.iconForCarousel)
            .font(.system(size: 84))
            .foregroundStyle(Color.theme.bgColor)
            .padding()
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(premiumChoiced.rawValue)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
            
            Text(premiumChoiced.descriptionCarousel)
                .font(.system(size: 16, design: .rounded))
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var detail: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Бесплатно")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                
                Text(premiumChoiced.detailWithoutPremium)
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Divider()
                .frame(height: 50)
            Spacer()
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Premium")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                
                Text(premiumChoiced.detailWithPremium)
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DetailedPremiumView(path: .constant([]))
}
