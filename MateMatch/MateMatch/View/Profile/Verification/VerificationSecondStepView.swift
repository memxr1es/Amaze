//
//  VerificationSecondStepView.swift
//  MateMatch
//
//  Created by Никита Котов on 13.02.2024.
//

import SwiftUI

struct VerificationSecondStepView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var path: [String]
    
    var body: some View {
        VStack {
            Spacer()
            
            header
            actionForVerification
            
            Spacer()
            Spacer()
            
            VStack {
                buttonContinue
                buttonNotNow
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
        VStack {
            Image("user-avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.theme.secondColor.opacity(0.5), lineWidth: 2)
                        .frame(width: 151, height: 151)
                }
                .padding(.bottom, 25)
            
            
            Text("Верифицировать профиль")
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
    
    var actionForVerification: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(systemName: "face.smiling")
                    .font(.system(size: 22, weight: .light))
                    .foregroundColor(.white)
                    .frame(height: 40, alignment: .top)
                    .offset(y: -5)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Сделай селфи, мы сравним его с")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text("твоей аватаркой")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 5)
            
            Rectangle()
                .foregroundStyle(.gray.opacity(0.2))
                .frame(width: 260, height: 1)
                .offset(x: 40)
            
            HStack(spacing: 10) {
                Image(systemName: "lock.shield")
                    .font(.system(size: 22, weight: .light))
                    .foregroundColor(.white)
                    .frame(height: 40, alignment: .top)
                    .offset(y: -5)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Не переживай, все данные")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text("защищены")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 5)
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(
                    .ultraThinMaterial
                        .shadow(
                            .inner(color: .white, radius: 0.5)
                        )
                        .shadow(
                            .drop(color: .gray, radius: 1)
                        )
                )
                .opacity(0.4)
        }
        .padding(.top, 20)
    }
    
    var buttonContinue: some View {
        Button {
            print("Do something")
        } label: {
            Text("Начать")
                .font(.system(size: 18, design: .rounded))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                }
                .padding(.horizontal, 20)
        }
    }
    
    var buttonNotNow: some View {
        Button {
            path.removeAll(where: { ($0 == "Final Step" || $0 == "First Step") })
        } label: {
            Text("Не сейчас")
                .font(.system(size: 18, design: .rounded))
                .foregroundStyle(.white)
                .padding()
        }
    }
}

#Preview {
    VerificationView(path: .constant([]))
}
