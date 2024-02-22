//
//  VerificationView.swift
//  MateMatch
//
//  Created by Никита Котов on 12.02.2024.
//

import SwiftUI

struct VerificationView: View {
    
    @Environment(\.dismiss) private var dismiss
//    @Binding var nextStep: Bool
    
    @Binding var path: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            header
            listOfAdvantages
                .padding(.vertical)
            
            Spacer()
            
            VStack(spacing: 30) {
                buttonContinue
                buttonDismiss
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
    }
    
    var header: some View {
        VStack(spacing: 5) {
            Image(systemName: "checkmark.seal")
                .font(.system(size: 84, weight: .thin))
                .foregroundStyle(.white)
                .padding(.bottom, 20)
            
            Text("Верифицируй свой профиль")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.bottom, 5)
            
            Text("Больше возможностей с подтвержденным")
                .font(.system(size: 18, weight: .light, design: .rounded))
                .foregroundStyle(.white)
            Text("аккаунтом")
                .font(.system(size: 18, weight: .light, design: .rounded))
                .foregroundStyle(.white)
        }
    }
    
    var listOfAdvantages: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(AdvantagesOfVerification.allCases, id: \.self) { advantage in
                HStack {
                    Image(systemName: advantage.icon)
                        .font(.system(size: 16, weight: advantage == .trust ? .black : .regular))
                        .foregroundStyle(.white)
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
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 80)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.gradient.opacity(0.15)
                            .shadow(
                                .inner(color: .white.opacity(0.5), radius: 1)
                            )
                            .shadow(
                                .drop(color: .gray, radius: 1)
                            )
                        )
                }
                .padding(.horizontal)
            }
        }
    }
    
    var buttonContinue: some View {
        NavigationLink(value: "Final Step") {
            Text("Пройти верификацию")
                .font(.system(size: 18, design: .rounded))
                .foregroundStyle(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                }
                .padding(.horizontal)
        }
    }
    
    var buttonDismiss: some View {
        Button {
            dismiss()
        } label: {
            Text("Не сейчас")
                .font(.system(size: 18))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    VerificationView(path: .constant([]))
}

enum AdvantagesOfVerification: String, CaseIterable {
    case unlimitedLikes = "Безлимитные лайки"
    case trust = "Доверие соискателей"
    case priority = "Приоритет в ленте"
    
    var description: String {
        switch self {
            case .unlimitedLikes: return "Отправляй лайки без ограничений"
            case .trust: return "Люди будут знать, что ты не чей-то фейк"
            case .priority: return "Галочка будет круто выглядеть рядом с твоей фоткой в ленте"
        }
    }
    
    var icon: String {
        switch self {
            case .unlimitedLikes: return "infinity"
            case .trust: return "sparkle"
            case .priority: return "checkmark.seal.fill"
        }
    }
}
