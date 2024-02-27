//
//  EditProfileView.swift
//  MateMatch
//
//  Created by Никита Котов on 10.02.2024.
//

import SwiftUI
import NavigationTransitions

struct EditProfileView: View {
    
    @State private var placeholder: String = "Напиши немного о себе"
    
    @FocusState private var isFocused: Bool
    @State private var isFocus: Bool = false
    @State private var showChoice: Bool = false
    @State private var showVerification: Bool = false
    
    @State private var characterLimit: Int = 500
    @State private var typedCharacters: Int = 0
    
    @State private var progress: CGFloat = 0
    
    @State var nextStep: Bool = false
    
    @Binding var path: [String]
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userVM: UserViewModel
    
    let columns = [GridItem(.fixed(40), alignment: .top), GridItem(.flexible(), alignment: .leading), GridItem(.fixed(30), alignment: .center)]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                userPhoto
                bio
                verification
                lookingFor
                main
            }
            .padding(.top, 100)
            .padding(.bottom, 50)
            .onChange(of: userVM.user) { oldValue, newValue in
                userVM.fillCompleted()
                
                withAnimation {
                    progress = (userVM.fillCompleteValue * 1.3).rounded()
                }
            }
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showChoice) {
            ChoicePurpose()
                .environmentObject(userVM)
                .presentationDetents([.fraction(0.8)])
        }
        .sheet(isPresented: $userVM.showInfo) {
            ChangeInfo()
                .environmentObject(userVM)
                .presentationDetents([.height(300)])
                .padding(.top, 40)
                .padding(.bottom, 25)
                .presentationCornerRadius(20)
                .background(.white)
        }
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            customNavBar
        }
        .background(Color.theme.bgColor.opacity(0.3))
        .background(Color.white)
        .onAppear {
            withAnimation {
                progress = (userVM.fillCompleteValue * 1.3).rounded()
            }
        }
        .onTapGesture {
            isFocused = false
        }
    }
    
    var userPhoto: some View {
        VStack(spacing: 0) {
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
        }
    }
    
    var bio: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Био")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text(userVM.user.about.isEmpty ? "+30%" : "\(typedCharacters) / \(characterLimit)")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding()
            
            ZStack(alignment: .leading) {
                if userVM.user.about.isEmpty {
                    TextEditor(text: $placeholder)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundStyle(.gray)
                        .disabled(true)
                        .padding(5)
                        .scrollContentBackground(.hidden)
                        .background(.white)
                }
                
                TextEditor(text: $userVM.user.about)
                    .font(.system(size: 20, design: .rounded))
                    .foregroundStyle(.black)
                    .opacity(userVM.user.about.isEmpty ? 0.25 : 1)
                    .padding(5)
                    .focused($isFocused)
                    .limitText($userVM.user.about, to: characterLimit)
                    .onChange(of: userVM.user.about) { _ , _ in
                        typedCharacters = userVM.user.about.count
                    }
                    .onAppear {
                        if !userVM.user.about.isEmpty {
                            typedCharacters = userVM.user.about.count
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .tint(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
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
        }
    }
    
    var verification: some View {
        NavigationLink(value: "First Step") {
            VStack(spacing: 0) {
                HStack {
                    Text("Верификация")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("+20%")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(.gray)
                }
                .padding()
                
                LazyVGrid(columns: columns, alignment: .center) {
                    Image(systemName: "checkmark.seal")
                        .font(.system(size: 22))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Верифицируй свой")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black)
                        Text("профиль")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black)
                        
                        Text("Больше возможностей с")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundStyle(.gray)
                        
                        Text("подтвержденным аккаунтом")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundStyle(.gray)
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18))
                        .foregroundStyle(.gray)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.theme.bgColor)
                }
                .padding(.horizontal)
            }
        }
        .buttonStyle(WithoutEffectsButtonStyle())
    }
    
    var lookingFor: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Я здесь для")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text("+16%")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding()
            
            if userVM.user.purpose == nil {
                LazyVGrid(columns: columns, alignment: .center) {
                    Image(systemName: "bolt")
                        .font(.system(size: 22))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Укажи статус")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black)
                        
                        Text("Пользователи будут видеть")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundStyle(.gray)
                        
                        Text("твой статус в ленте")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundStyle(.gray)
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18))
                        .foregroundStyle(.gray)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.theme.bgColor)
                }
                .onTapGesture {
                    withAnimation { showChoice.toggle() }
                }
                .padding(.horizontal)

            } else {
                choicedPurpose
                    .onTapGesture {
                        withAnimation { showChoice.toggle() }
                    }
            }
        }
    }
    
    var main: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Дополнительно")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text("+8%")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding()
            
            LazyVGrid(columns: columns) {
                Image(systemName: "network")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.gray)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Город")
                        .foregroundStyle(.black)
                        .fontDesign(.rounded)
                    
                    Text(userVM.user.city != nil ? userVM.user.city! : "Не выбрано")
                        .foregroundStyle(.gray)
                        .fontDesign(.rounded)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .shadow(color: Color.theme.bgColor, radius: 10)
                    .shadow(color: Color.theme.bgColor.opacity(0.6), radius: 10)
                    .shadow(color: Color.theme.bgColor.opacity(0.3), radius: 10)
            }
            .padding(.horizontal, 15)
            .onTapGesture {
                userVM.showInfo = true
            }
        }
    }
    
    var customNavBar: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .opacity(0.97)
                .ignoresSafeArea()
                .frame(height: 70)
            
            HStack {
                Button {
                    path.removeAll()
                }
                label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
                .padding(.leading)
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("Заполнен на \(userVM.fillCompleteValue, specifier: "%.f")%")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(Color(.systemGray))
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 130, height: 4)
                            .foregroundStyle(Color.theme.bgColor)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: progress, height: 4)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.bottom, 5)
                
                Spacer()
                
                NavigationLink(value: "Profile Overview") {
                    Text("Просмотр")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemGray))
                        .padding(.trailing)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var choicedPurpose: some View {
        LazyVGrid(columns: columns) {
            Image(systemName: userVM.user.purpose?.icon ?? "")
                .font(.system(size: 20))
                .foregroundStyle(.gray.opacity(0.5))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(userVM.user.purpose?.rawValue ?? "")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Text(userVM.user.purpose?.description ?? "")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.gray.opacity(0.6))
                    .lineSpacing(5)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(color: Color.theme.bgColor, radius: 10)
                .shadow(color: Color.theme.bgColor.opacity(0.6), radius: 10)
                .shadow(color: Color.theme.bgColor.opacity(0.3), radius: 10)
        }
        .padding(.horizontal, 15)
    }
}

struct WithoutEffectsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

#Preview {
    MainView()
}

