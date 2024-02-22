//
//  ChatView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var cardData = CardsViewModel()
    
    var body: some View {
        VStack {
            VStack {
                if let mates = cardData.displaying_mates {
                    
                    if mates.isEmpty {
                        
                    } else {
                        
                        newMatesHeader
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 25) {
                                ForEach(mates, id: \.self) { mateMatch in
                                    MatchedMateView(mate: mateMatch)
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Чаты")
                        .font(.system(size: 26, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    if let mates = cardData.displaying_mates {
                        
                        if mates.isEmpty {
                            
                        } else {
                            
                            List {
                                ForEach(mates, id: \.self) { mateMatch in
                                    MessageView(mate: mateMatch)
                                        .listRowInsets(EdgeInsets(top: 0, leading: -5, bottom: 15, trailing: -5))
                                        .listRowSeparator(.hidden)
                                        .overlay {
                                            Rectangle()
                                                .fill(.gray.opacity(0.2))
                                                .frame(height: 0.5)
                                                .offset(y: 50)
                                        }
                                }
                                .listRowBackground(Rectangle().fill(.white))
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.hidden)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
            Spacer()
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color.white.ignoresSafeArea())
    }
    
    var newMatesHeader: some View {
        HStack {
            Text("Новые дружбаны")
                .font(.system(size: 26, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
            
            Spacer()
            
            HStack {
                Text("Все")
                    .font(.system(size: 18))
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
            }
            .foregroundStyle(Color(.systemGray))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    ChatView()
}
