//
//  DetailedPremiumView.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import SwiftUI

struct DetailedPremiumView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var sections: SectionsViewModel
    
    @Binding var path: [String]
    
    var body: some View {
        VStack {
            PremiumCarouselView(selectedTab: $sections.selectedAdvantage)
                .padding(.top, 70)
                .frame(height: 400, alignment: .top)
            
            buttonSubscribe
                .padding(.top, 80)
            
            Spacer()
            
            footer
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [Color(#colorLiteral(red: 0.01106899139, green: 0.03459626809, blue: 0.03383141011, alpha: 1)), Color.theme.mainColor],
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
        }
        .overlay {
            buttonClose
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            buttonReturn
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private var buttonClose: some View {
        Button {
            path.removeAll(where: { $0 == "Advantage premium" || $0 == "Premium View"})
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.white)
                .padding(10)
                .background {
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                        .opacity(0.5)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                .padding(.top, 5)
        }
    }
    
    private var buttonReturn: some View {
        Image(systemName: "chevron.left")
            .font(.system(size: 18))
            .foregroundStyle(.white)
            .padding()
            .onTapGesture {
                dismiss()
            }
    }
    
    private var buttonSubscribe: some View {
        Button {}
        label: {
            Text("Подписаться за \(sections.selectedPrice.price.description) ₽ / \(sections.selectedPrice.rawValue.lowercased())")
                .font(.system(size: 16))
                .foregroundStyle(.white)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white, lineWidth: 1)
        }
        .padding(.horizontal)
    }
    
    private var footer: some View {
        VStack {
            Text("Подписка будет продлеваться автоматически, если она не отменена как минимум за 24 часа до окончания текущего периода. Подписку можно отменить в любой момент в настройках приложения.")
            
            Text("Нажимая на кнопку, ты соглашаешься с \(Text("Условиями подписки").underline()) и \(Text("Политикой конфиденциальности").underline())")
                .frame(width: 300)
                .padding(.vertical, 10)
        }
        .font(.system(size: 12, design: .rounded))
        .foregroundStyle(Color.gray.opacity(0.6))
        .multilineTextAlignment(.center)
        .padding(.horizontal, 20)
    }
}

#Preview {
    DetailedPremiumView(path: .constant([]))
}

