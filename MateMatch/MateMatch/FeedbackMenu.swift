//
//  TestVie.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct FeedbackMenu: View {
    
    @Binding var showFeedback: Bool

    var body: some View {
        VStack(spacing: 8) {
            ForEach(FeedbackButtons.allCases, id: \.self) { button in
                Text(button.rawValue)
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .foregroundStyle(button.color)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                    }
                    .padding(.horizontal, 30)
                    .onTapGesture {
                        if button == .cancel {
                            withAnimation(.spring) { showFeedback = false }
                        } else {
                            button.action
                        }
                    }
            }
            
            Button {
                
            } label: {
                
            }

        }
        .background {
            Color.clear
        }
    }
}

struct ExitMenu: View {
    
    @Binding var showExit: Bool

    var body: some View {
        VStack(spacing: 8) {
            ForEach(ExitButtons.allCases, id: \.self) { button in
                Text(button.rawValue)
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .foregroundStyle(button.color)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                    }
                    .padding(.horizontal, 30)
                    .onTapGesture {
                        if button == .cancel {
                            withAnimation(.spring) { showExit = false }
                        } else {
                            button.action
                        }
                    }
            }
            
            Button {
                
            } label: {
                
            }

        }
        .background {
            Color.clear
        }
    }
}

#Preview {
    ExitMenu(showExit: .constant(false))
}

enum FeedbackButtons: String, CaseIterable {
    case telegram = "Telegram"
    case mail = "Почта"
    case cancel = "Отмена"
    
    var color: Color {
        switch self {
            case .telegram: return .black
            case .mail: return .black
            case .cancel: return Color.theme.mainColor
        }
    }
    
    var action: Void {
        switch self {
            case .telegram:
                openTelegram()
            case .mail:
                sendMail()
            case .cancel:
                placeholder()
        }
    }
    
    func openTelegram() {
        let profileURL = URL(string: "https://t.me/memx_bus")
        
        if UIApplication.shared.canOpenURL(profileURL!) {
            UIApplication.shared.open(profileURL!)
        } else {
            
        }
    }
    
    func sendMail() {
        let message = URL(string: "mailto:memxr1es-dev@yandex.ru?subject=Ошибка в Amaze")
        
        if UIApplication.shared.canOpenURL(message!) {
            UIApplication.shared.open(message!)
        } else {
            
        }
    }
    
    func placeholder() {
        
    }
}
enum ExitButtons: String, CaseIterable {
    case exit = "Выйти"
    case cancel = "Отмена"
    
    var color: Color {
        switch self {
            case .exit: return .black
            case .cancel: return Color.theme.mainColor
        }
    }
    
    var action: Void {
        switch self {
            case .exit:
                print("Do exit")
            case .cancel:
                placeholder()
        }
    }
    
    func placeholder() {
        
    }
}
