//
//  ChatView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject private var cardData: CardsViewModel
    @EnvironmentObject private var chatVM: ChatAppearanceViewModel
    @EnvironmentObject private var sectionsVM: SectionsViewModel
    
    @State private var navigationPath: [String] = []
    @State private var arrayOfDictionary: Array<Dictionary<Mate, [Message]>.Keys.Element> = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                VStack {
                    if cardData.matched_mates.isEmpty {

                    } else {
                        newMatesHeader
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 25) {
                                ForEach(Array(cardData.matched_mates.keys), id: \.self) { mateMatch in
                                    MatchedMateView(mate: mateMatch)
                                        .onTapGesture {
                                            navigationPath.removeAll()
                                            cardData.selectedMate = mateMatch
                                            navigationPath.append("Correspondence View")
                                        }
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Чаты")
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black)
                        
                        List {
                            ForEach(Array(cardData.matched_mates.keys), id: \.self) { mateMatch in
                                if !cardData.matched_mates[mateMatch]!.isEmpty {
                                    MessageView(mate: mateMatch, path: $navigationPath)
                                        .environmentObject(cardData)
                                        .listRowInsets(EdgeInsets(top: 0, leading: -5, bottom: 15, trailing: -5))
                                        .listRowSeparator(.hidden)
                                        .overlay {
                                            Rectangle()
                                                .fill(.gray.opacity(0.2))
                                                .frame(height: 0.5)
                                                .offset(y: 50)
                                        }
                                        .listRowBackground(Rectangle().fill(.white))
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .overlay {
                        if cardData.matched_mates.isEmpty {
                            VStack(spacing: 10) {
                                Text("Пу-пу-пу...")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Text("Как дела, Солнце?")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black.opacity(0.2))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(5)
                            }
                            .padding()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
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
                        .environmentObject(sectionsVM)
                } else if navPath == "Mate Profile" {
                    MateOverviewView(mate: cardData.selectedMate!, fromChatView: true)
                        .navigationBarBackButtonHidden()
                        .environmentObject(cardData)
                } else if navPath == "Application Section" {
                    ChangeAppInfoView(path: $navigationPath)
                        .navigationBarBackButtonHidden()
                        .environmentObject(sectionsVM)
                        .environmentObject(chatVM)
                } else if navPath == "Preview Chat" {
                    PreviewChatView(mate: plchldr_mate, selectedBGColor: chatVM.selectedTempBGColor, selectedPhotoColor: chatVM.selectedTempPhotoColor, selectedBackgroundImage: chatVM.selectedTempBackgroundImage, selectedMessageColor: chatVM.selectedTempMessageColor, path: $navigationPath)
                        .navigationBarBackButtonHidden()
                        .environmentObject(chatVM)
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
        .environmentObject(CardsViewModel())
}
