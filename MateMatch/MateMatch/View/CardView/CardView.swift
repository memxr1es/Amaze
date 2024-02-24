//
//  CardView.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var cardData: CardsViewModel
    @Binding var showParametersSheet: Bool
    
    var body: some View {
        ZStack {
            
            Color.theme.bgColor.ignoresSafeArea()
            
            header
            
            if let mates = cardData.displaying_mates {
                
                if mates.isEmpty {
                    Text("Возвращайся позже, мы подберем тебе еще напарников!")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.top, 60)
                } else {
                    ForEach(mates.reversed(), id: \.self) { mate in
                        StackCardView(mate: mate)
                            .environmentObject(cardData)
                    }
                    .padding(.top, 60)
                }
            } else {
                ProgressView()
            }
        }
    }
    
    var header: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, -50)
//                .ignoresSafeArea()
            
            HStack(alignment: .center) {
                
                button(icon: "bell")
                
                Spacer()
                
                Text("AMAZE")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundStyle(.gray)
                
                Spacer()
                
                button(icon: "slider.horizontal.3")
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func button(icon: String) -> some View {
        Button {
            withAnimation { showParametersSheet.toggle() }
        } label: {
            Image(systemName: icon)
                .font(.system(size: 18))
                .frame(width: 40, height: 40)
                .padding(.horizontal)
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(color: Color.theme.bgColor, radius: 10)
                        .shadow(color: Color.theme.bgColor, radius: 10)
                        .shadow(color: Color.theme.bgColor, radius: 10)
                }
                .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
        }
    }
}

#Preview {
    MainView()
}
