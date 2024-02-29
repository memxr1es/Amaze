//
//  MateOverviewView.swift
//  MateMatch
//
//  Created by Никита Котов on 24.02.2024.
//

import SwiftUI

struct MateOverviewView: View {

    let mate: Mate
    let fromChatView: Bool
    
    @State private var onAppear: Bool = false
    
    @State private var currentPhoto: String = ""
    @State private var indexOfPhoto: Int = 0
    
    @EnvironmentObject var cardData: CardsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                userPhoto
                    .onTapGesture(coordinateSpace: .global) { location in
                        tapCalculate(location)
                    }
                
                if !mate.about.isEmpty {
                    bio
                }
                
                if mate.tags != nil {
                    games
                }
                
                complainButton
            }
            .padding(.top, 80)
            .padding(.bottom, 100)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.bgColor)
        .overlay {
            ZStack {
                header
                
                bottomButtons
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation {
                    onAppear.toggle()
                }
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
                    if fromChatView {
                        dismiss()
                    } else {
                        withAnimation { cardData.showMateProfile.toggle() }
                    }
                }
            
            Spacer()

            
            Text("\(mate.name), \(mate.age)")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "hand.raised")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .opacity(0.8)
                .padding(.trailing)
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
    
    var userPhoto: some View {
        TabView(selection: $currentPhoto) {
            ForEach(mate.avatar) { avatar in
                RoundedRectangle(cornerRadius: 0)
                    .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 250, endRadius: 400))
                    .background {
                        Image(avatar.name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250, alignment: .bottom)
                            .clipShape(Rectangle())
                    }
                    .tag(avatar.id.uuidString)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.default, value: currentPhoto)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(shortAboutUser)
        .overlay(photoSlider)
    }
    
    func tapCalculate(_ location: CGPoint) {
        if location.x < 150 {
            indexOfPhoto = indexOfPhoto > 0 ? indexOfPhoto - 1 : 0

            currentPhoto = mate.avatar[indexOfPhoto].id.uuidString
            
        } else if location.x > 250 {
            indexOfPhoto = indexOfPhoto < mate.avatar.count - 1 ? indexOfPhoto + 1 : mate.avatar.count - 1
            
            currentPhoto = mate.avatar[indexOfPhoto].id.uuidString
        }
    }
    
    var shortAboutUser: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 200, endRadius: 400))
            
            HStack(spacing: 15) {
                HStack(spacing: 5) {
                    Image(systemName: mate.city != nil ? "network" : "")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text(mate.city ?? "")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                
                HStack(spacing: 5) {
                    Image(systemName: mate.purpose?.icon ?? "")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text(mate.purpose?.rawValue ?? "")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, mate.avatar.count > 1 ? 40 : 20)
            .padding(.horizontal, 20)
        }
    }
    
    var bio: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Био")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            Text(mate.about)
                .font(.system(size: 14))
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var games: some View {
        VStack(alignment: .leading) {
            Text("Игры")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
        
            TagLayout(alignment: .leading, spacing: 10) {
                ForEach(mate.tags!, id: \.self) { tag in
                    listTag(tag)
                }
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var bottomButtons: some View {
        HStack {
            if fromChatView {
                Button {
                    withAnimation(.smooth) { dismiss() }
                } label: {
                    Image(systemName: "ellipsis.message.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                        .padding(15)
                        .background {
                            Circle()
                                .fill(.black.opacity(0.9))
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            } else {
                ForEach(TypeOfBottomButton.allCases, id: \.self) { type in
                    bottomButtons(type)
                        .scaleEffect(onAppear ? 1 : 0)
                    
                    if type == .dislike {
                        Spacer()
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
        .padding(.leading, 5)
    }
    
    var complainButton: some View {
        Button {
            
        } label: {
            Text("Пожаловаться")
                .font(.system(size: 18))
                .foregroundStyle(.black.opacity(0.3))
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.theme.accentColor)
                }
                .padding(.horizontal)
        }
        .padding(.top, 50)
    }
    
    var photoSlider: some View {
        HStack {
            if mate.avatar.count > 1 {
                ForEach(0...mate.avatar.count - 1, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(indexOfPhoto == index ? .white : .white.opacity(0.2))
                        .frame(maxWidth: .infinity, maxHeight: 3)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func bottomButtons(_ type: TypeOfBottomButton) -> some View {
        Button {
            
        } label: {
            Image(systemName: type.icon)
                .font(.system(size: 22, weight: type.weight))
                .foregroundStyle(.white)
                .padding(type.padding)
                .background {
                    Circle()
                        .fill(type.color)
                }
        }
    }
    
    @ViewBuilder
    func listTag(_ tag: Tag) -> some View {
        HStack {
            Image(uiImage: UIImage(named: tag.tag.icon)!)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            
            Text(tag.tag.rawValue)
        }
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .fixedSize()
        .foregroundStyle(.black.opacity(0.5))
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.theme.accentColor)
        }
    }
}

#Preview {
    MateOverviewView(mate: MOCK_MATE[0], fromChatView: true)
}

enum TypeOfBottomButton: String, CaseIterable {
    case dislike
    case superlike
    case like
    
    var icon: String {
        switch self {
            case .dislike: return "xmark"
            case .superlike: return "star.fill"
            case .like: return "heart.fill"
        }
    }
    
    var color: Color {
        switch self {
            case .dislike: return .black.opacity(0.9)
            case .superlike: return .black.opacity(0.9)
            case .like: return .red.opacity(0.9)
        }
    }
    
    var weight: Font.Weight {
        switch self {
            case .dislike: return .bold
            case .superlike: return .regular
            case .like: return .regular
        }
    }
    
    var padding: CGFloat {
        switch self {
            case .dislike: return 15
            case .superlike: return 13
            case .like: return 15
        }
    }
}
