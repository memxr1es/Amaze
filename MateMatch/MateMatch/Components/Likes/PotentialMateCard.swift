//
//  PotentialMateCard.swift
//  MateMatch
//
//  Created by Никита Котов on 04.03.2024.
//

import SwiftUI

struct PotentialMateCard: View {
    
    let mate: Mate
    
    @EnvironmentObject var cardData: CardsViewModel
    
    var body: some View {
        Image(mate.avatar.first!.name)
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 230)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .overlay(buttons)
    }
    
    var buttons: some View {
        HStack {
            Button {
                cardData.disliked_mates.append(mate)
                cardData.mates_who_likes_you.removeAll(where: { $0 == mate })
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black.opacity(0.8))
                    }
            }
            
            Button {
                cardData.addMate(mate)
                cardData.mates_who_likes_you.removeAll(where: { $0 == mate })
            } label: {
                Image(systemName: "heart.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.red.opacity(0.8))
                    }
            }
        }
        .padding(.horizontal, 10)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom)
    }
}

#Preview {
    PotentialMateCard(mate: MOCK_MATE[0])
        .environmentObject(CardsViewModel())
}
