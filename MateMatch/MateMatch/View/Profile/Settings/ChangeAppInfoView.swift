//
//  ChangeAppInfoView.swift
//  MateMatch
//
//  Created by Никита Котов on 20.02.2024.
//

import SwiftUI

struct ChangeAppInfoView: View {
   
    @State private var selectedLanguage: AppLanguage = .russian
    
    @State private var showReset: Bool = false
    @State private var showPreview: Bool = false
    
    @State private var stateOfPush: [PushNotifications: Bool] = [
        .newRequests: false,
        .newMatch: false,
        .newMessage: false,
        .inviteLink: false,
        .appUpdate: false
    ]
    
    @Binding var path: [String]
    
    @EnvironmentObject var sections: SectionsViewModel
    @EnvironmentObject var chatVM: ChatAppearanceViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    private func binding(for item: PushNotifications) -> Binding<Bool> {
        return .init(
            get: { self.stateOfPush[item, default: false] },
            set: { self.stateOfPush[item] = $0 }
        )
    }
    
    var body: some View {
        VStack {
            switch sections.selectedAppSection {
            case .loginMethods:
                logInMethods
            case .notifications:
                pushNotification
            case .chats:
                chatAppearance
            case .language:
                appLanguage
            case .blackList:
                blackList
            case .FAQ:
                faq
            case .feedbackOfError:
                faq
            case .exit:
                faq
            }
        }
        .padding(.top, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.bgColor)
        .overlay(header)
        .onAppear {
            if !showPreview {
                chatVM.selectedTempBGColor = chatVM.selectedColorBackground
                chatVM.selectedTempPhotoColor = chatVM.selectedColorPhoto
                chatVM.selectedTempBackgroundImage = chatVM.selectedBackgroundImage
                chatVM.selectedTempMessageColor = chatVM.selectedMessageColor
            } else {
                showPreview = false
            }
        }
        .onChange(of: [chatVM.selectedTempBGColor, chatVM.selectedTempPhotoColor, chatVM.selectedTempMessageColor]) { oldValue, newValue in
            if chatVM.selectedTempBGColor != chatVM.systemBGColor || chatVM.selectedTempPhotoColor != chatVM.systemPhotoColor ||  chatVM.selectedTempMessageColor != chatVM.systemMessageColor {
                withAnimation(.linear) { showReset = true }
            } else { withAnimation(.linear) { showReset = false } }
        }
        .onChange(of: chatVM.selectedTempBackgroundImage) { oldValue, newValue in
            if chatVM.selectedTempBackgroundImage != chatVM.systemBGImage {
                withAnimation(.linear) { showReset = true }
            } else { withAnimation(.linear) { showReset = false } }
        }
        .onAppear {
            if chatVM.selectedColorBackground != chatVM.systemBGColor || chatVM.selectedColorPhoto != chatVM.systemPhotoColor || chatVM.selectedTempBackgroundImage != chatVM.systemBGImage || chatVM.selectedMessageColor  != chatVM.systemMessageColor {
                if chatVM.selectedTempBackgroundImage != chatVM.systemBGImage {
                    withAnimation(.linear) { showReset = true }
                } else { withAnimation(.linear) { showReset = false } }
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
                    path.removeAll(where: { $0 == "Application Section"})
                }
            
            Spacer()

            
            Text(sections.selectedAppSection == .notifications ? "Push-уведомления" : (sections.selectedAppSection == .language ? "Язык приложения" : sections.selectedAppSection.rawValue))
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.leading, sections.selectedAppSection == .chats ? 20 : -20)
                .opacity(sections.selectedAppSection == .FAQ ? 0 : 1)
            
            Spacer()
            
            if sections.selectedAppSection == .chats {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .rotationEffect(.degrees(showReset ? 0 : 180))
                    .padding(.trailing)
                    .opacity(showReset ? 1 : 0)
                    .onTapGesture {
                        reset()
                    }
            }
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
    
    var logInMethods: some View {
        VStack(spacing: 0) {
            ForEach(SocialNetwork.allCases, id: \.self) { network in
                HStack(spacing: 20) {
                    Image(uiImage: UIImage(named: network.icon)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black.opacity(0.6))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(network.rawValue)
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(.black.opacity(0.8))
                        
                        Text("Не подключен")
                            .font(.system(size: 14))
                            .foregroundStyle(.black.opacity(0.4))
                    }
                    
                    HStack {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                            .padding(.trailing, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
        }
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.05), radius: 10)
                .shadow(color: .gray.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
    }
    
    var pushNotification: some View {
        VStack {
            ForEach(PushNotifications.allCases, id: \.self) { notification in
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(notification.rawValue)
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(.black.opacity(0.8))
                        
                        Text(notification.description)
                            .font(.system(size: 14))
                            .foregroundStyle(.black.opacity(0.4))
                    }
                    .onTapGesture {
                        withAnimation { stateOfPush[notification] = !stateOfPush[notification]!}
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: binding(for: notification)) {
                        
                    }
                    .tint(Color.theme.mainColor)
                    .frame(width: 100)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.05), radius: 10)
                .shadow(color: .gray.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
    }
    
    var appLanguage: some View {
        VStack(alignment: .leading) {
            ForEach(AppLanguage.allCases, id: \.self) { country in
                HStack(alignment: .center, spacing: 20) {
                    Image(uiImage: UIImage(named: country.icon)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(country.rawValue)
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(.black)
                        
                        Rectangle()
                            .fill(.gray.opacity(0.2))
                            .frame(height: 0.5)
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.none) { selectedLanguage = country }
                }
                .overlay {
                    Image(systemName: selectedLanguage == country ? "checkmark" : "")
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.leading)
    }
    
    var blackList: some View {
        VStack {
            Text("Черный список пуст")
                .font(.system(size: 14))
                .foregroundStyle(.black.opacity(0.6))
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    var faq: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(sections.selectedAppSection.rawValue)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                
                Text("Популярные вопросы о приложении")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
            }
            
            VStack {
                ForEach(FAQ.allCases, id: \.self) { part in
                    NavigationLink(value: "FAQ") {
                        VStack {
                            HStack(spacing: 0) {
                                Text(part.rawValue)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black.opacity(0.8))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                            }
                            .padding(.vertical)
                            
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .frame(height: 0.5)
                                .opacity(part == .meeting ? 0 : 1)
                                .padding(.horizontal, -15)
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded { sections.selectedFAQSection = part })
                }
            }
            .padding(.top, 30)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var chatAppearance: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                LazyVStack(spacing: 10) {
                    Text("Кастомизируй чат под себя!")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Text("Вся красота видна только тебе. \nНе переживай если будет кринжово ;)")
                        .font(.system(size: 14))
                        .foregroundStyle(.black.opacity(0.4))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                }
                
                VStack(alignment: .leading) {
                    Text("Фон чата")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(.horizontal)
                    
                    WallpaperCarousel(tempBGColor: $chatVM.selectedTempBGColor, tempPhotoColor: $chatVM.selectedTempPhotoColor, tempBGImage: $chatVM.selectedTempBackgroundImage)
                            .environmentObject(chatVM)
                            .frame(height: 250)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .background(.white)
                .padding(.top, 30)
                
                LazyVStack(alignment: .leading) {
                    Text("Настройка цвета")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Цвет фона")
                                .font(.system(size: 14))
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            CustomColorPicker(typeColor: .backgroundClr, tempBGColor: $chatVM.selectedTempBGColor, tempPhotoColor: $chatVM.selectedTempPhotoColor, tempMessageColor: $chatVM.selectedTempMessageColor)
                                .environmentObject(chatVM)
                        }
                        
                        Rectangle()
                            .fill(.black.opacity(0.1))
                            .frame(height: 0.5)
                            .padding(.vertical, 10)
                        
                        HStack {
                            Text("Цвет рисунка")
                                .font(.system(size: 14))
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            CustomColorPicker(typeColor: .photoClr, tempBGColor: $chatVM.selectedTempBGColor, tempPhotoColor: $chatVM.selectedTempPhotoColor, tempMessageColor: $chatVM.selectedTempMessageColor)
                                .environmentObject(chatVM)
                        }
                        
                        Rectangle()
                            .fill(.black.opacity(0.1))
                            .frame(height: 0.5)
                            .padding(.vertical, 10)
                        
                        HStack {
                            Text("Цвет сообщения")
                                .font(.system(size: 14))
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            CustomColorPicker(typeColor: .messageClr, tempBGColor: $chatVM.selectedTempBGColor, tempPhotoColor: $chatVM.selectedTempPhotoColor, tempMessageColor: $chatVM.selectedTempMessageColor)
                                .environmentObject(chatVM)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .background(.white)
                .padding(.top, 20)
                
                Button {
                    saveSettings()
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
                }
                .padding(.horizontal)
                .padding(.top, 25)
            }
        }
        .overlay {
            Button {
                showPreview = true
                withAnimation { path.append("Preview Chat") }
            } label: {
                Image(systemName: "sparkles")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .fill(.black)
                            .frame(width: 50, height: 50)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding()
            .shadow(color: .white.opacity(0.5), radius: 10)
        }
    }
    
    func saveSettings() {
        chatVM.selectedColorPhoto = chatVM.selectedTempPhotoColor
        chatVM.selectedColorBackground = chatVM.selectedTempBGColor
        chatVM.selectedBackgroundImage = chatVM.selectedTempBackgroundImage
        chatVM.selectedMessageColor = chatVM.selectedTempMessageColor
        
        dismiss()
    }
    
    func reset() {
        if chatVM.selectedTempBGColor != chatVM.systemBGColor || chatVM.selectedTempPhotoColor != chatVM.systemPhotoColor || chatVM.selectedTempBackgroundImage != chatVM.systemBGImage || chatVM.selectedTempMessageColor != chatVM.systemMessageColor  {
            withAnimation {

                chatVM.selectedTempPhotoColor = chatVM.systemPhotoColor
                chatVM.selectedTempBGColor = chatVM.systemBGColor
                chatVM.selectedTempBackgroundImage = chatVM.systemBGImage
                chatVM.selectedTempMessageColor = chatVM.systemMessageColor
                
            }
        }
        
        withAnimation(.linear) {
            showReset.toggle()
        }
    }
}

let plchldr_mate = Mate(name: "Влад", age: 23, avatar: [Photo(name: "plchldr_avtr")], verified: true, gender: .male)

#Preview {
    ChangeAppInfoView(path: .constant([]))
        .environmentObject(SectionsViewModel())
        .environmentObject(ChatAppearanceViewModel())
    
//    PreviewChatView(mate: plchldr_mate, selectedBGColor: .white, selectedPhotoColor: .red, selectedBackgroundImage: "pattern-1")
}

struct PreviewChatView: View {
    
    let mate: Mate
    
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedBGColor: Color
    @State var selectedPhotoColor: Color
    @State var selectedBackgroundImage: String
    @State var selectedMessageColor: Color
    
    @State private var randomHour: Int = 0
    @State private var randomMin: Int = 0
    
    @FocusState private var isFocused: Bool
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ScrollView {
                    VStack {
                        Spacer()
                        
                        MessageBubble(fromUser: true, message: "Здарова Влад, сядем сегодня в дотку в 19?", time: "12:31", messageColor: selectedMessageColor)
                        MessageBubble(fromUser: false, message: "Здарова, смогу только после 8и 🥲", time: "12:45", messageColor: selectedMessageColor)
                        MessageBubble(fromUser: true, message: "Оки, до вечера тогда", time: "13:01", messageColor: selectedMessageColor)
                    }
                    .padding(.bottom)
                    .frame(minHeight: reader.size.height)
                }
                .scrollBounceBehavior(.basedOnSize, axes: .vertical)
                .onTapGesture {
                    isFocused = false
                }
            }
            
            footer
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.white
            selectedBGColor
            
            Image(selectedBackgroundImage)
                .resizable()
                .scaledToFill()
                .foregroundStyle(selectedPhotoColor)
        }
        .overlay(header)
        .onAppear {
            self.randomHour = .random(in: 1...24)
            self.randomMin = .random(in: 10...59)
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

            
            matePreview
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.top, 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .frame(height: 110)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        }
    }
    
    var matePreview: some View {
        HStack(alignment: .center, spacing: 15) {
            Image(mate.avatar.first!.name)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 5) {
                    Text(mate.name)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Image(mate.verified ? "verified" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
                
                Text("Был(а) в сети в \(randomHour):\(randomMin)")
                    .font(.system(size: 12))
                    .foregroundStyle(.black.opacity(0.4))
 
            }
        }
    }
    
    var footer: some View {
        Rectangle()
            .fill(.white)
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width, height: 50)
    }
}
