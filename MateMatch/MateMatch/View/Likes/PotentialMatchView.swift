//
//  PotentialMatchView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.03.2024.
//

import SwiftUI

struct PotentialMatchView: View {
    
    @Binding var selectedTab: MenuTab
    
    @EnvironmentObject var cardData: CardsViewModel
    
    let columns: [GridItem] = [GridItem(.fixed(170)), GridItem(.fixed(170))]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                if !cardData.mates_who_likes_you.isEmpty {
                    ForEach(cardData.mates_who_likes_you) { mate in
                        PotentialMateCard(mate: mate)
                            .environmentObject(cardData)
                    }
                }
            }
        }
        .padding(.top, 80)
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal)
        .overlay {
            if cardData.mates_who_likes_you.isEmpty {
                placeholder
            }
        }
        .background(Color.theme.bgColor)
        .overlay(header)
    }
    
    var header: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, -50)
            
            HStack(alignment: .bottom) {
                
                Text("Лайки")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
                
                Image("double_hearts")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(
                        .linearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1))], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .frame(width: 30, height: 30)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxHeight: 900, alignment: .top)
    }
    
    var placeholder: some View {
        VStack(spacing: 10) {
            Image(systemName: "heart")
                .font(.system(size: 24, weight: .light))
                .foregroundStyle(.black.opacity(0.3))
                .background {
                    Circle()
                        .fill(.black.opacity(0.05))
                        .frame(width: 60, height: 60)
                }
                .padding(.bottom, 30)
            
            Text("Тут будут появляться лайки")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.black)
            
            Text("Найдем кого-нибудь в ленте?")
                .font(.system(size: 16))
                .foregroundStyle(.black.opacity(0.4))
            
            Button {
                withAnimation { selectedTab = .main }
            } label: {
                Text("Найти пару")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
            }
            .padding(.top, 20)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.top, 100)
    }
}

#Preview {
    PotentialMatchView(selectedTab: .constant(.main))
        .environmentObject(CardsViewModel())
}
