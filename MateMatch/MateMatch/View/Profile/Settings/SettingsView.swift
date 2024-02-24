//
//  SettingsView.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss

//    @EnvironmentObject var sections: SectionsViewModel
//    @EnvironmentObject var userVM: UserViewModel
    
    @StateObject var sections = SectionsViewModel()
    @StateObject var userVM = UserViewModel()
    
    @State private var showFeedback: Bool = false
    @State private var showExit: Bool = false
    
    @Binding var path: [String]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20) {
                mainSection
                appSection
                
                infoForUser
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.bgColor)
        .overlay(header)
        .disabled(showFeedback)
        .overlay {
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring) {
                            showFeedback.toggle()
                        }
                    }
                    .opacity(showFeedback ? 0.7 : 0)
                
                
                FeedbackMenu(showFeedback: $showFeedback)
                    .offset(y: showFeedback ? 280 : 600)
                    .animation(.spring, value: showFeedback)
                    .transition(.move(edge: .bottom))
            }
        }
        .overlay {
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring) {
                            showExit.toggle()
                        }
                    }
                    .opacity(showExit ? 0.7 : 0)
                
                
                ExitMenu(showExit: $showExit)
                    .offset(y: showExit ? 300 : 600)
                    .animation(.spring, value: showExit)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    dismiss()
                }
            
            Spacer()

            
            Text("Настройки")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.leading, -20)
            
            Spacer()
        }
        .padding(.top, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        }
    }
    
    var mainSection: some View {
        VStack(alignment: .leading) {
            main
            userSections(userVM.user)
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.05), radius: 10)
                .shadow(color: .gray.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
        .padding(.top, 70)
    }
    
    var main: some View {
        VStack(alignment: .leading) {
            Text("Основные")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
            
        }
        .padding()
    }
    
    var appSection: some View {
        VStack(alignment: .leading) {
            application
            applicationSection
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.05), radius: 10)
                .shadow(color: .gray.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
    }
    
    var application: some View {
        VStack(alignment: .leading) {
            Text("Приложение")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
            
        }
        .padding()
    }
    
    var applicationSection: some View {
        VStack(alignment: .leading) {
            ForEach(ApplicationSections.allCases.filter({$0 != .feedbackOfError && $0 != .exit}), id: \.self) { application in
                VStack {
                    NavigationLink(value: "Application Section") {
                        HStack(spacing: 15) {
                            Image(systemName: application.icon)
                                .font(.system(size: 20))
                                .foregroundStyle(.black.opacity(0.4))
                                .frame(width: 30, height: 30, alignment: .center)
                            
                            Text(application.rawValue)
                                .font(.system(size: 14, design: .rounded))
                                .foregroundStyle(.black.opacity(0.85))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.black)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(WithoutEffectsButtonStyle())
                }
                .simultaneousGesture(TapGesture().onEnded {
                    sections.selectedAppSection = application
                })
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
            ForEach(ApplicationSections.allCases.filter({$0 == .feedbackOfError || $0 == .exit}), id: \.self) { application in
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: application.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(.black.opacity(0.4))
                            .frame(width: 30, height: 30, alignment: .center)
                        
                        Text(application.rawValue)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(.black.opacity(0.85))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                            .padding(.trailing, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .onTapGesture {
                    withAnimation(.spring) {
                        if application == .feedbackOfError { showFeedback.toggle() }
                        else { showExit.toggle() }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))

        }
    }
    
    var infoForUser: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Политика конфиденциальности")
            Text("Пользовательское соглашение")
            Text("Удалить аккаунт")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 40)
        .font(.system(size: 14))
        .foregroundStyle(.gray.opacity(0.8))
    }
    
    @ViewBuilder
    func userSections(_ user: User) -> some View {
        VStack(alignment: .leading) {
            ForEach(MainSections.allCases, id: \.self) { section in
                NavigationLink(value: "Main Section") {
                    HStack(spacing: 15) {
                        Image(systemName: section.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(.black.opacity(0.4))
                            .frame(width: 30, height: 30, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(section.rawValue)
                                .foregroundStyle(.black.opacity(0.85))
                            
                            Text("\(section == .name ? user.firstName : (section == .birthday ? shortDate(user.birthDay) : user.gender.rawValue))")
                                .foregroundStyle(.gray.opacity(0.8))
                        }
                        .font(.system(size: 14, design: .rounded))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                            .padding(.trailing, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    sections.selectedSection = section
                })
                .buttonStyle(WithoutEffectsButtonStyle())
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
    }
}

#Preview {
    SettingsView(path: .constant([]))
}




