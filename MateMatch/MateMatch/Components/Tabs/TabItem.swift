//
//  TabItem.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI

struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(configuration.isPressed ? Color.black.opacity(0.2) : Color.clear)
            .cornerRadius(50)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)
            .clipped()
            .padding(10)
        
    }
}

struct TabItem: View {
    
    let tab: MenuTab
    @Binding var selectedTab: MenuTab
    
    var body: some View {
        Button {
            withAnimation(.smooth) {
                selectedTab = tab
            }
        } label: {
            Image(systemName: tab.icon)
                .font(.system(size: tab == .message ? 22 : 26))
                .foregroundStyle(
                    tab == selectedTab ?
                        .linearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1))], startPoint: tab == selectedTab ? .bottomLeading : .zero, endPoint: tab == selectedTab ? .topTrailing : .zero)
                    :
                            .linearGradient(colors: [Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1))], startPoint: .topLeading, endPoint: .trailing)
                )
                .scaleEffect(tab == selectedTab ? 1.1 : 1)
                .animation(.none, value: selectedTab)
        }
        .buttonStyle(PressEffectButtonStyle())
    }
}

#Preview {
    HStack {
        TabItem(tab: .main, selectedTab: .constant(.message))
        TabItem(tab: .message, selectedTab: .constant(.message))
    }
}
