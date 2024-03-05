//
//  MessageView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct MessageView: View {
    
    let mate: Mate
    
    @State private var randomHour: Int = 0
    @State private var randomMin: Int = 0
    
    @Binding var path: [String]
    
    @EnvironmentObject var cardData: CardsViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            Image(mate.avatar.first!.name)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text(mate.name)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Image(mate.verified ? "verified" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Text(timeDate(cardData.matched_mates[mate]?.last?.time ?? Date()))
                            .font(.system(size: 14))
                            .foregroundStyle(.black.opacity(0.4))
                        
                        Image("double-check")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(width: 15, height: 15)
                    }
//                    .padding(.horizontal)
                }
                
                Text(cardData.matched_mates[mate]?.last?.text ?? "")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 110, alignment: .leading)
            }
//            .frame(width: .infinity, height: 70)
        }
        .padding(5)
        .background(.white)
        .onTapGesture {
            path.removeAll()
            cardData.selectedMate = mate
            path.append("Correspondence View")
        }
        .onAppear {
            randomHour = .random(in: 1...24)
            randomMin = .random(in: 10...59)
        }
    }
}

#Preview {
    MessageView(mate: MOCK_MATE[1], path: .constant([]))
}
