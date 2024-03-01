//
//  ChatView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var cardData = CardsViewModel()
    @EnvironmentObject private var chatVM: ChatAppearanceViewModel
    
    @State private var navigationPath: [String] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                                            .onTapGesture {
                                                navigationPath.append("Correspondence View")
                                                cardData.selectedMate = mateMatch
                                            }
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
                                            .onTapGesture {
                                                navigationPath.append("Correspondence View")
                                                cardData.selectedMate = mateMatch
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
            .navigationDestination(for: String.self) { navPath in
                if navPath == "Correspondence View" {
                    CorrespondenceView(mate: cardData.selectedMate!, path: $navigationPath)
                        .navigationBarBackButtonHidden()
                        .environmentObject(cardData)
                        .environmentObject(chatVM)
                    
                } else if navPath == "Mate Profile" {
                    MateOverviewView(mate: cardData.selectedMate!, fromChatView: true)
                        .navigationBarBackButtonHidden()
                        .environmentObject(cardData)
                }
            }
        }
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
        .environmentObject(ChatAppearanceViewModel())
}
