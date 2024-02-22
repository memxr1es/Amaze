//
//  PremiumView.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import SwiftUI

struct PremiumView: View {
    
    @State private var isAnimated: Bool = false
    
    @Binding var path: [String]
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sections: SectionsViewModel
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let color = Color(#colorLiteral(red: 0.0183273498, green: 0.09191649407, blue: 0.095268704, alpha: 1))
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            header
            
            choicePrice
                .padding(.top, 20)
            
            listOfAdvantages
                .padding(.vertical)
            
            footer
                .padding(.bottom, 100)
        }
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                isAnimated = true
            }
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
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 2)) {
                isAnimated.toggle()
            }
        }
        .overlay {
            ZStack {
                HStack(alignment: .top) {
                    buttonSubscribe
                        .padding(.top, 15)
                }
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .top)
                .background(color)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                
                buttonClose
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "bolt.fill")
                .font(.system(size: 84))
                .foregroundStyle(.yellow)
                .opacity(isAnimated ? 1 : 0.2)
                .offset(y: isAnimated ? -25 : 0)
                .scaleEffect(isAnimated ? 1.3 : 1)
                .overlay {
                    Circle()
                        .fill(.black.opacity(0.1))
                        .frame(width: 50)
                        .rotation3DEffect(
                            .degrees(80),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                        .offset(x: -5, y: isAnimated ? 90 : 55)
                        .scaleEffect(isAnimated ? 0.6 : 1)
                }
                .padding(.top, 50)
            
            Text("Amaze Premium")
                .font(.system(size: 26, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
            
            VStack(spacing: 3) {
                Text("Покупай премиум и получай больше")
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
                Text("возможностей")
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var choicePrice: some View {
        HStack(alignment: .center, spacing: 10) {
            ForEach(PricePremium.allCases, id: \.self) { choice in
                VStack(alignment: .center, spacing: 8) {
                    Text(choice.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text("\(choice.price.description) ₽")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text("\(choice.pricePerYear.description) ₽ / год")
                        .font(.system(size: 12))
                        .foregroundStyle(.white.opacity(0.4))
                }
                .padding(10)
                .padding(.vertical, 10)
                .padding(.horizontal, 6)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.theme.mainColor.gradient.opacity(0.2))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(sections.selectedPrice == choice ? .white : .clear, lineWidth: 1)
                        }
                }
                .onTapGesture {
                    sections.selectedPrice = choice
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var buttonSubscribe: some View {
        Button {
            
        } label: {
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
    
    private var listOfAdvantages: some View {
        VStack(alignment: .leading, spacing: 12)  {
            ForEach(AdvantagesOfPremium.allCases, id: \.self) { advantage in
                NavigationLink(value: "Advantage premium") {
                    HStack(spacing: 15) {
                        Image(systemName: advantage.icon)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .rotation3DEffect(.degrees(advantage == .bringItBack ? 180 : 0), axis: (1, 0, 0))
                            .frame(width: 50, height: 50)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white.gradient.opacity(0.2))
                            }
                            
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(advantage.rawValue)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            
                            Text(advantage.description)
                                .font(.system(size: 14, design: .rounded))
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16))
                            .foregroundStyle(.white.opacity(0.5))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.gradient.opacity(0.15)
                                .shadow(
                                    .inner(color: .white.opacity(1), radius: 1)
                                )
                                    .shadow(
                                        .drop(color: .gray, radius: 1)
                                    )
                            )
                    }
                    .padding(.horizontal)
                }
                .buttonStyle(WithoutEffectsButtonStyle())
                .simultaneousGesture(TapGesture().onEnded { _ in
                    sections.selectedAdvantage = advantage
                })
            }
        }
    }
    
    private var footer: some View {
        VStack {
            Text("Подписка будет продлеваться автоматически, если она не отменена как минимум за 24 часа до окончания текущего периода. Подписку можно отменить в любой момент в настройках приложения.")
            
            Text("Нажимая на кнопку, ты соглашаешься с \(Text("Условиями подписки").underline()) и \(Text("Политикой конфиденциальности").underline())")
                .frame(width: 300)
                .padding(.vertical, 10)
            
            Text("Восстановить покупки")
                .underline()
        }
        .font(.system(size: 12, design: .rounded))
        .foregroundStyle(Color.gray.opacity(0.6))
        .multilineTextAlignment(.center)
        .padding(.horizontal, 20)
    }
    
    private var buttonClose: some View {
        Button {
            dismiss()
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
}

#Preview {
    MainView()
}

enum PricePremium: String, CaseIterable {
    case oneWeek = "Неделя"
    case oneMonth = "Месяц"
    case threeMonth = "3 месяца"
    
    var price: Int {
        switch self {
            case .oneWeek: return 499
            case .oneMonth: return 999
            case .threeMonth: return 1990
        }
    }
    
    var pricePerYear: Int {
        switch self {
            case .oneWeek: return self.price * 52
            case .oneMonth: return self.price * 12
            case .threeMonth: return self.price * 4
        }
    }
}

enum AdvantagesOfPremium: String, CaseIterable {
    case viewingLikes = "Просмотр лайков"
    case superlikes = "Суперлайки"
    case bringItBack = "Вернуть назад"
    
    var description: String {
        switch self {
            case .viewingLikes: return "Узнай, кому ты нравишься"
            case .superlikes: return "Обрати на себя внимание"
            case .bringItBack: return "Забери дизлайк"
        }
    }
    
    var icon: String {
        switch self {
            case .viewingLikes: return "heart.fill"
            case .superlikes: return "star.fill"
            case .bringItBack: return "return"
        }
    }
    
    var iconForCarousel: String {
        switch self {
            case .viewingLikes: return "eye"
            case .superlikes: return "sparkles"
            case .bringItBack: return "return"
        }
    }
    
    var detailWithoutPremium: String {
        switch self {
            case .viewingLikes: return "1 лайк / 8 часов"
            case .superlikes: return "1 суперлайк / сутки"
            case .bringItBack: return "3 раза / сутки"
        }
    }
    
    var detailWithPremium: String {
        switch self {
            case .viewingLikes: return "Без ограничений"
            case .superlikes: return "5 суперлайков / сутки"
            case .bringItBack: return "Безлимит"
        }
    }
    
    var descriptionCarousel: String {
        switch self {
            case .viewingLikes: return "Узнай кому ты нравишься"
            case .superlikes: return "Показываются в ленте первыми и повышают твои шансы на мэтч"
            case .bringItBack: return "Активно свайпали и пропустили крутого тиммейта? Не проблема, одна кнопка вернет дружбана в ленту"
        }
    }
}
