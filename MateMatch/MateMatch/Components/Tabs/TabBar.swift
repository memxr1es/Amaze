//
//  TabBar.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: MenuTab
    
    var body: some View {
        customTabBar()
    }
    
    @ViewBuilder
    func customTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(MenuTab.allCases, id: \.self) { item in
                TabItem(tab: item, selectedTab: $selectedTab)
                    .padding(.top, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TabBar(selectedTab: .constant(.main))
}
