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
    @Namespace private var animation
    
    @State private var selectedTags: [Tags] = []
    
    // Focus observers
    @FocusState private var isFocused: Bool
    @State private var isFocus: Bool = false
    
    // Text controllers
    @State private var placeholder: String = "Напиши немного о себе"
    @State private var textLimit: Bool = false
    @State private var characterLimit: Int = 500
    @State private var typedCharacters: Int = 0
    @State private var scrollReader: ScrollViewProxy?
    
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
            selectedTags = userVM.user.game != nil ? userVM.user.game! : []

            newValue = userVM.showInfo ? (userVM.user.city ?? "") : (userVM.showBio ? userVM.user.about : "")
        }
        .onDisappear {
            userVM.showBio = false
            userVM.showInfo = false
            userVM.showPhoto = false
            userVM.showStatus = false
            
            userVM.selectedInfoSection = ""
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        VStack(spacing: 0) {
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        changeInfoCity
                        
                        changeInfoGames
                    }
                    .frame(maxHeight: 500, alignment: .bottom)
                }
                .onChange(of: newValue, { oldValue, newValue in
                    textLimit = newValue.count > 26 ? true : false
                })
                .onChange(of: isFocused, { oldValue, newValue in
                    withAnimation(.linear(duration: 0.1)) {
                        isFocus.toggle()
                    }
                })
                .onTapGesture {
                    isFocused = false
                }
                .onAppear {
                    scrollReader = value
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        value.scrollTo(userVM.selectedInfoSection)
                    }
                }
            }
            .scrollDisabled(true)
            
            customPicker
            
            Button {
                if userVM.selectedInfoSection == "Город" {
                    if !textLimit {
                        userVM.user.city = newValue.isEmpty ? nil : newValue
                    }
                } else {
                    userVM.user.game = selectedTags
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
            .frame(height: 50, alignment: .bottom)
            .padding()
        }
        .onChange(of: userVM.selectedInfoSection) { oldValue, newValue in
            withAnimation(.linear) {
                scrollReader?.scrollTo(userVM.selectedInfoSection, anchor: .bottom)
            }
        }
    }
    
    var changeInfoCity: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Поведай, откуда ты?")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 30)
            
            Spacer()
            
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
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 30, alignment: .center)
        .padding(.horizontal)
        .id("Город")
        .background(Color.white)
    }
    
    var changeInfoGames: some View {
        VStack(spacing: 0) {
            Text("В чем любишь скоротать вечер?")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 25)
            
            Spacer()
            
            selectedTagView
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .overlay {
                    if selectedTags.isEmpty {
                        HStack {
                            Image(systemName: "chevron.down")
                            Text("Выберите игры")
                            Image(systemName: "chevron.down")
                        }
                        .font(.callout)
                        .foregroundStyle(.gray)
                    }
                }
                .background(.white)
                .zIndex(1)
                .frame(width: UIScreen.main.bounds.width)
            
            tagListView
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
            
            Spacer()
            
        }
        .id("Игры")
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 450, alignment: .bottom)
        .clipShape(Rectangle())
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
    
    var selectedTagView: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(selectedTags, id: \.self) { tag in
                    listTag(tag, Color(#colorLiteral(red: 0, green: 0.7045553327, blue: 0.6918279529, alpha: 1)), "checkmark")
                        .matchedGeometryEffect(id: tag, in: animation)
                    // Removing from Selected List
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedTags.removeAll(where: {$0 == tag})
                            }
                        }
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 30, alignment: .center)
            .padding(.top, 30)
            .padding(.bottom, 30)
        }
    }
    
    var tagListView: some View {
        ScrollView(.vertical) {
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(Tags.allCases.filter{ !selectedTags.contains($0)}, id: \.self) { tag in
                    listTag(tag, Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)), "plus")
                        .matchedGeometryEffect(id: tag, in: animation)
                        .onTapGesture {
                            // Adding to Selected Tag List
                            withAnimation(.snappy) {
                                selectedTags.insert(tag, at: 0)
                            }
                        }
                }
            }
            .padding(.top)
        }
        .frame(height: 200)
        .background(Color.theme.bgColor)
        .clipShape(Rectangle())
    }
    
    var customPicker: some View {
        HStack {
            ForEach(["Город", "Игры"], id: \.self) { tag in
                Text(tag)
                    .font(.system(size: 14))
                    .foregroundStyle(userVM.selectedInfoSection == tag ? .white : .black.opacity(0.5))
                    .padding(10)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(userVM.selectedInfoSection == tag ? .black : .clear)
                    }
                    .onTapGesture {
                        userVM.selectedInfoSection = tag
                    }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black.opacity(0.05))
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func listTag(_ tag: Tags, _ color: Color, _ icon: String) -> some View {
        HStack(spacing: 5) {
            Image(uiImage: UIImage(named: tag.icon)!)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            
            Text(tag.rawValue)
            
            Image(systemName: icon)
        }
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .fixedSize()
        .foregroundStyle(.white.opacity(1))
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(color.opacity(0.5))
        }
    }
}

#Preview {
    ChangeInfo()
        .environmentObject(UserViewModel())
}
