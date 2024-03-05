//
//  ContentView.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: MenuTab = .main
    @State private var showParametersSheet: Bool = false
    
    @State private var changeProfile: Bool = false
    
    @State private var navigationPath: [String] = []
    
    @StateObject private var cardData = CardsViewModel()
    @StateObject private var userVM = UserViewModel()
    @StateObject private var chatVM = ChatAppearanceViewModel()
    @StateObject private var sectionsVM = SectionsViewModel()
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                ZStack {
                    switchViews(selectedTab: selectedTab, showParametersSheet: showParametersSheet)
                        .transition(.scale(scale: 1.1))
                        .navigationDestination(for: String.self) { navPath in
                            if navPath == "Notifications" {
                                NotificationView()
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(userVM)
                            }
                        }
                    
                    TabBar(selectedTab: $selectedTab)
                        .frame(height: 10)
                        .background(.white)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding(.bottom, 20)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .overlay {
            Rectangle()
                .fill(.regularMaterial.opacity(showParametersSheet ? 0.8 : 0))
                .ignoresSafeArea()
                .onTapGesture {
                    showParametersSheet = false
                }
                .animation(.easeInOut, value: showParametersSheet)
        }
        .overlay(sheet)
        .overlay {
            if cardData.showMateProfile {
                MateOverviewView(mate: cardData.selectedMate!, fromChatView: false)
                    .environmentObject(cardData)
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.selectedTab = .profile
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.selectedTab = .main
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.launchScreenState.dismiss()
            }
        }
    }
    
    var sheet: some View {
        ParametersSheet(showParametersSheet: $showParametersSheet)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
            }
            .offset(y: showParametersSheet ? UIScreen.main.bounds.height / 2.2 : 900)
            .animation(.spring, value: showParametersSheet)
    }
    
    @ViewBuilder
    func switchViews(selectedTab: MenuTab, showParametersSheet: Bool) -> some View {
        switch selectedTab {
            case .main:
                CardView(showParametersSheet: $showParametersSheet, path: $navigationPath)
                .environmentObject(cardData)
                .padding(.bottom, 20)
            case .overview:
                PotentialMatchView(selectedTab: $selectedTab)
                .environmentObject(cardData)
            case .message:
                ChatView()
                .environmentObject(chatVM)
                .environmentObject(sectionsVM)
                .environmentObject(cardData)
            case .profile:
                ProfileView(path: $navigationPath)
                .environmentObject(userVM)
                .environmentObject(chatVM)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(LaunchScreenStateManager())
}
