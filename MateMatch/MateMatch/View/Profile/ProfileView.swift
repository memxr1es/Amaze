//
//  ProfileView.swift
//  MateMatch
//
//  Created by Никита Котов on 09.02.2024.
//

import SwiftUI

struct CircularProgressView: View {
    
    let color = Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1))
    var value: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke ( // Back Circle
                    color.opacity(0.2),
                    lineWidth: 10
                )
            
            Circle()
                .trim(from: 0, to: value / 100)
                .stroke ( // Progress Circle
                    color,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.bouncy, value: value)
            
        }
    }
}

struct ProfileView: View {
    
    @State private var circleValue: CGFloat = .zero
    
    @State private var showQRCode: Bool = false
    @State private var testSystem: Bool = false
    
    @State private var showMore: Bool = false
    @State private var testShow: Bool = false
    
    @State private var showSheet: Bool = false
    
    @StateObject var sections = SectionsViewModel()
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var chatVM: ChatAppearanceViewModel

    @Binding var path: [String]
    
    private func timeConsumingCalculation() -> Int {
        (1 ... 10_000_000).reduce(0, +)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                
                Color.theme.bgColor.ignoresSafeArea()
                
                
                LazyVStack(spacing: 5) {
                    
                    profileSection
                    
                    fillProfile
                    
                    checkCompatibility
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 50)
                .padding(.bottom, 100)
            }
            .disabled(showQRCode)
            .onDisappear {
                showQRCode = false
                
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .overlay {
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .sheet(isPresented: $showSheet, content: {
                ChangeInfo()
                    .environmentObject(userVM)
                    .presentationDetents([.height(userVM.showPhoto ? 520 : (userVM.showStatus ? 590 : (userVM.showInfo ? 560 : 340)))])
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    .presentationCornerRadius(20)
                    .background(.white)
        })
        .background(Color.theme.bgColor)
        .overlay {
            QRCodeView(showQRCode: $showQRCode)
                .opacity(showQRCode ? 1 : 0)
        }
        .navigationDestination(for: String.self) { navPath in
            if navPath == "Edit Profile" {
                EditProfileView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(userVM)
            } else if navPath == "First Step" {
                VerificationView(path: $path)
                    .navigationBarBackButtonHidden()
            } else if navPath == "Final Step" {
                VerificationSecondStepView(path: $path)
                    .navigationBarBackButtonHidden()
            } else if navPath == "Premium View" {
                PremiumView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(sections)
            } else if navPath == "Settings" {
                SettingsView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(userVM)
                    .environmentObject(sections)
            } else if navPath == "Application Section" {
                ChangeAppInfoView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(sections)
                    .environmentObject(chatVM)
            } else if navPath == "Preview Chat" {
                PreviewChatView(mate: plchldr_mate, selectedBGColor: chatVM.selectedTempBGColor, selectedPhotoColor: chatVM.selectedTempPhotoColor, selectedBackgroundImage: chatVM.selectedTempBackgroundImage, selectedMessageColor: chatVM.selectedTempMessageColor)
                    .navigationBarBackButtonHidden()
                
            } else if navPath == "Main Section" {
                ChangeMainInfoView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(userVM)
                    .environmentObject(sections)
            } else if navPath == "FAQ" {
                FAQView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(sections)
            } else if navPath == "Advantage premium" {
                DetailedPremiumView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(sections)
            } else if navPath == "Profile Overview" {
                OverviewProfileView(path: $path)
                    .navigationBarBackButtonHidden()
                    .environmentObject(userVM)
            } else if navPath == "Notifications" {
                NotificationView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(userVM)
            }
        }
        .task {
            withAnimation {
                userVM.fillCompleted()
                circleValue = userVM.fillCompleteValue
            }
        }
        .onChange(of: userVM.user) { oldValue, newValue in
            DispatchQueue.main.async {
                userVM.fillCompleted()
                circleValue = userVM.fillCompleteValue
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
            
            HStack(alignment: .bottom, spacing: 0) {
                
                buttonQR(icon: "qrcode")
                
                Spacer()
                
                button(icon: "gearshape")
                
                button(icon: "bell")
                    .padding(.trailing, 5)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxHeight: 900, alignment: .top)
    }
    
    var profileSection: some View {
        LazyVStack {
            NavigationLink(value: "Profile Overview") {
                HStack(spacing: 15) {
                    Image("user-avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    
                    LazyVStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(userVM.user.firstName)
                                .font(.system(size: 26, weight: .semibold, design: .rounded))
                                .foregroundStyle(.black)
                            
                            Image(systemName: testSystem ? "checkmark.seal.fill" : "checkmark.seal")
                                .foregroundStyle(testSystem ? .blue : Color(.systemGray))
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    withAnimation { testSystem.toggle() }
                                }
                        }
                        
                        Text("Профиль")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black.opacity(0.3))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            }
            
            LazyHStack {
                buttonProfile(icon: "pencil.and.scribble", text: "Изменить", alignment: false)
                
                Spacer()

                buttonProfile(icon: "bolt.fill", text: "Premium", alignment: true)
            }
            .padding()
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        }
        .padding()
    }
    
    var fillProfile: some View {
        LazyVStack {
            HStack {
                ZStack {
                    CircularProgressView(value: circleValue)
                        .frame(width: 70, height: 70)
                    
                    Text("\(userVM.fillCompleteValue, specifier: "%.f")%")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.mainColor)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Заполни профиль")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Text("Повысь свои шансы \nнайти тиммейта")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(Color(.systemGray))
                        .lineSpacing(5)
                }
                .padding(.horizontal)
                .frame(height: 100)
                
                Image(systemName: showMore ? "chevron.up" : "chevron.down")
                    .foregroundStyle(Color(.systemGray))
                
            }
            .onTapGesture {
                showMore.toggle()
            }
            
            if showMore {
                MoreInfo(showSheet: $showSheet)
                    .environmentObject(userVM)
                    .padding(.horizontal, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        }
        .padding(.horizontal)
    }
    
    var checkCompatibility: some View {
        LazyVStack(spacing: 15) {
            LazyHStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Что общего?")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                    Text("Позови друга или подругу \nи узнай, что между вами общего")
                        .font(.system(size: 14, design: .rounded))
                        .lineSpacing(5)
                }
                .foregroundColor(.white)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        Circle()
                            .foregroundColor(Color.theme.secondColor.opacity(0.6))
                    }
            }
            
            Button {
                
            } label: {
                HStack {
                    Text("Отправить ссылку")
                        .font(.system(size: 16, design: .rounded))
                    
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 14))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.white)
                }
                .padding(.horizontal, 30)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.theme.mainColor)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    func button(icon: String) -> some View {
        NavigationLink(value: icon == "bell" ? "Notifications" : "Settings") {
            Image(systemName: icon)
                .font(.system(size: 16))
                .frame(width: 40, height: 40)
                .padding(.horizontal, 10)
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(color: Color.theme.shadowColor, radius: 10)
                        .shadow(color: Color.theme.shadowColor.opacity(0.6), radius: 10)
                        .shadow(color: Color.theme.shadowColor.opacity(0.3), radius: 10)
                }
                .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
        }
    }
    
    @ViewBuilder
    func buttonQR(icon: String) -> some View {
        Button {
            withAnimation { showQRCode.toggle() }
        } label: {
            HStack {
                Image(systemName: icon)
                Text("Пригласить")
            }
            .padding(10)
            .font(.system(size: 16))
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: Color.theme.shadowColor.opacity(1), radius: 5)
                    .shadow(color: Color.theme.shadowColor.opacity(0.6), radius: 10)
            }
            .padding(.leading, 10)
            .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
        }
    }
    
    @ViewBuilder
    func buttonProfile(icon: String, text: String, alignment: Bool) -> some View {
        NavigationLink(value: alignment ? "Premium View" : "Edit Profile") {
            HStack {
                Text(text)
                Image(systemName: icon)
                    .foregroundColor(icon == "bolt.fill" ? .yellow : .black)
                    .symbolEffect(.variableColor, options: .repeating.speed(0.0001), isActive: icon == "bolt.fill" ? true : false)
            }
            .padding(13)
            .padding(.horizontal, 10)
            .font(.system(size: 16, weight: .light, design: .rounded))
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: Color.theme.shadowColor.opacity(1), radius: 10)
                    .shadow(color: Color.theme.shadowColor.opacity(0.5), radius: 10)
                    .shadow(color: Color.theme.shadowColor.opacity(0.3), radius: 10)
            }
            .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
        }
    }
}

#Preview {
    MainView()
        .environmentObject(LaunchScreenStateManager())
}
