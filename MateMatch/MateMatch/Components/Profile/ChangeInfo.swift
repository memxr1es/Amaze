//
//  ChangeInfo.swift
//  MateMatch
//
//  Created by Никита Котов on 27.02.2024.
//

import SwiftUI

struct ChangeInfo: View {
    
    @State private var newValue: String = ""
    
    @EnvironmentObject var userVM: UserViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    // Focus observers
    @FocusState private var isFocused: Bool
    @State private var isFocus: Bool = false
    
    // Text controllers
    @State private var placeholder: String = "Напиши немного о себе"
    @State private var textLimit: Bool = false
    @State private var characterLimit: Int = 500
    @State private var typedCharacters: Int = 0
    
    var body: some View {
        VStack {
            if userVM.showPhoto {
                changePhoto
            } else if userVM.showInfo {
                changeInfo
            } else if userVM.showStatus {
                ChoicePurpose()
                    .environmentObject(userVM)
            } else if userVM.showBio {
                changeBio
            }
        }
        .onAppear {
            userVM.showBio = true

            newValue = userVM.showInfo ? (userVM.user.city ?? "") : (userVM.showBio ? userVM.user.about : "")
        }
        .onDisappear {
            userVM.showBio = false
            userVM.showInfo = false
            userVM.showPhoto = false
            userVM.showStatus = false
        }
    }
    
    var changePhoto: some View {
        VStack(spacing: 0) {
            
            Text("Добавь больше фото")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .padding(20)
            
            HStack {
                Text("Мои фото")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text("+30%")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            CompositionalView(items: 0...5, id: \.self) { item in
                PhotoProfile(main: item == 0 ? true : false, index: item)
            }
            
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Text("Закрыть")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
                    .padding()
            }
        }
    }
    
    var changeInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Поведай, откуда ты?")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 30)
            
            Text("Твой город")
                .font(.system(size: 14))
                .foregroundStyle(.black.opacity(0.6))
            
            TextField(text: $newValue, prompt: Text("Укажи свой город").font(.system(size: 18)).foregroundStyle(.black.opacity(0.3))) {
                EmptyView()
            }
            .foregroundStyle(.black)
            .focused($isFocused)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(textLimit ? .red.opacity(0.1) : .white)
                
                if !textLimit {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isFocus ? .black : .gray, lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(textLimit ? .red.opacity(0.8) : .gray, lineWidth: 1)
                }
            }
            .tint(textLimit ? .red : .black)
            
            Text("Максимум 25 символов")
                .font(.system(size: 14))
                .foregroundStyle(textLimit ? .red.opacity(0.8) : .black.opacity(0.6))
            
            Button {
                if !textLimit {
                    userVM.user.city = newValue.isEmpty ? nil : newValue
                }
                
                dismiss()
            } label: {
                Text("Сохранить")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
            }
            .frame(height: 100, alignment: .bottom)
        }
        .onChange(of: newValue, { oldValue, newValue in
            textLimit = newValue.count > 26 ? true : false
        })
        .onChange(of: isFocused, { oldValue, newValue in
            withAnimation(.linear(duration: 0.1)) {
                isFocus.toggle()
            }
        })
        .padding()
        .onTapGesture {
            isFocused = false
        }
    }
    
    var changeBio: some View {
        VStack(spacing: 0) {
            
            Text("Расскажи нам о себе")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .padding(.bottom, 10)
            
            HStack {
                Text("Био")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text(newValue.isEmpty ? "+8%" : "\(typedCharacters) / \(characterLimit)")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding()
            
            ZStack(alignment: .leading) {
                TextField(text: $newValue, prompt: Text(placeholder).font(.system(size: 16)).foregroundStyle(.black.opacity(0.3)), axis: .vertical) {
                    EmptyView()
                }
                .font(.system(size: 16, design: .rounded))
                .padding(5)
                .foregroundStyle(.black)
                .opacity(newValue.isEmpty ? 0.25 : 1)
                .padding(5)
                .focused($isFocused)
                .limitText($newValue, to: characterLimit)
                .onChange(of: newValue) { _ , _ in
                    typedCharacters = newValue.count
                }
                .onAppear {
                    if !userVM.user.about.isEmpty {
                        typedCharacters = newValue.count
                    }
                }
                .scrollContentBackground(.hidden)
                .tint(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120, alignment: .top)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isFocus ? .black : .gray.opacity(0.5), lineWidth: 1)
            }
            .padding(.horizontal)
            .onChange(of: isFocused) { oldValue, newValue in
                withAnimation(.linear(duration: 0.1)) {
                    isFocus.toggle()
                }
            }
            .onTapGesture {
                isFocused = false
            }
            
            Button {
                userVM.user.about = newValue
                dismiss()
            } label: {
                Text("Сохранить")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
                    .padding()
            }
            .frame(height: 100, alignment: .bottom)
        }
    }
    
}

#Preview {
    ChangeInfo()
}
