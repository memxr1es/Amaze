//
//  OverviewProfileView.swift
//  MateMatch
//
//  Created by Никита Котов on 22.02.2024.
//

import SwiftUI

struct OverviewProfileView: View {
    
    @Binding var path: [String]
    
    @EnvironmentObject var userVM: UserViewModel
//    @StateObject var userVM = UserViewModel()
    
    @State private var currentPhoto: String = ""
    @State private var indexOfPhoto: Int = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                userPhoto
                    .onTapGesture(coordinateSpace: .global) { location in
                        tapCalculate(location)
                    }
                
                if !userVM.user.about.isEmpty {
                    bio
                }
                
                if userVM.user.game != nil {
                    games
                }
            }
            .padding(.top, 80)
            .padding(.bottom, 100)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.bgColor)
        .overlay(header)
        .overlay(editButton)
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    path.removeAll(where: { $0 == "Profile Overview" })
                }
            
            Spacer()

            
            Text("\(userVM.user.firstName), \(userVM.user.age)")
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
    
    var userPhoto: some View {
        TabView(selection: $currentPhoto) {
            ForEach(userVM.user.userPhoto, id: \.self) { avatar in
                RoundedRectangle(cornerRadius: 0)
                    .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 250, endRadius: 400))
                    .background {
                        Image(avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250, alignment: .bottom)
                            .clipShape(Rectangle())
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut, value: currentPhoto)
        .transition(.slide)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(shortAboutUser)
        .overlay(photoSlider)
    }
    
    var photoSlider: some View {
        HStack {
            if userVM.user.userPhoto.count > 1 {
                ForEach(0...userVM.user.userPhoto.count - 1, id: \.self) { index in
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
    
    var shortAboutUser: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 200, endRadius: 400))
            
            HStack(spacing: 15) {
                HStack(spacing: 5) {
                    Image(systemName: userVM.user.city != nil ? "network" : "")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text(userVM.user.city ?? "")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                
                HStack(spacing: 5) {
                    Image(systemName: userVM.user.purpose?.icon ?? "")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Text(userVM.user.purpose?.rawValue ?? "")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, userVM.user.userPhoto.count > 1 ? 40 : 20)
            .padding(.horizontal, 20)
        }
    }
    
    var bio: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Био")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            Text(userVM.user.about)
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
                ForEach(userVM.user.game!, id: \.self) { tag in
                    listTag(tag)
                }
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var editButton: some View {
        NavigationLink(value: "Edit Profile") {
            HStack {
                Text("Изменить")
                    .font(.system(size: 16, design: .monospaced))
                
                Image(uiImage: UIImage(named: "edit")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
            }
            .foregroundStyle(.white)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    func tapCalculate(_ location: CGPoint) {
        if location.x < 150 {
            if indexOfPhoto > 0 {
                withAnimation {
                    indexOfPhoto -= 1
                    currentPhoto = userVM.user.userPhoto[indexOfPhoto]
                }
            }
        } else if location.x > 300 {
            if indexOfPhoto < userVM.user.userPhoto.count - 1 {
                withAnimation {
                    indexOfPhoto += 1
                    currentPhoto = userVM.user.userPhoto[indexOfPhoto]
                }
            }
        }
    }
    
    @ViewBuilder
    func listTag(_ tag: Tags) -> some View {
        HStack {
            Image(uiImage: UIImage(named: tag.icon)!)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            
            Text(tag.rawValue)
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
    OverviewProfileView(path: .constant([]))
}
