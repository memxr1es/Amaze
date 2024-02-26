//
//  PremiumCarouselSwiftui.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import SwiftUI

struct PremiumCarouselView: View {
    
    @Binding var selectedTab: AdvantagesOfPremium
    @State private var tempTab: AdvantagesOfPremium = .bringItBack
    @State private var tabs: [AdvantagesOfPremium] = [.viewingLikes, .superlikes, .bringItBack]
    
    @State private var timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AdvantagesOfPremium.allCases, id: \.self) { advantage in
                CarouselTabView(premiumChoiced: advantage)
                    .tag(advantage)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(customPoints().offset(y: 190))
        .onReceive(timer) { _ in
            withAnimation {
                selectedTab = selectedTab == tabs.last ? tabs.first! : tabs[tabs.index(after: tabs.firstIndex(of: selectedTab)!)]
            }
        }
        .onChange(of: selectedTab) { _, _ in
            withAnimation {
                timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
            }
        }
    }
    
    @ViewBuilder
    func customPoints() -> some View {
        HStack {
            ForEach(AdvantagesOfPremium.allCases, id: \.self) { advantage in
                Circle()
                    .fill(selectedTab == advantage ? .white : Color(.systemGray4).opacity(0.5))
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    PremiumCarouselView(selectedTab: .constant(.bringItBack))
}
