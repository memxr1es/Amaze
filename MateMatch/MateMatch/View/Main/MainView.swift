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
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                ZStack {
                    switchViews(selectedTab: selectedTab, showParametersSheet: showParametersSheet)
                        .transition(.scale(scale: 1.1))
                    TabBar(selectedTab: $selectedTab)
                        .frame(height: 10)
//                        .padding(.bottom, 10)
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
                CardView(showParametersSheet: $showParametersSheet)
                .padding(.bottom, 20)
            case .overview:
                EmptyView()
            case .message:
                ChatView()
            case .profile:
                ProfileView(path: $navigationPath)
        }
    }
}

#Preview {
    MainView()
}
