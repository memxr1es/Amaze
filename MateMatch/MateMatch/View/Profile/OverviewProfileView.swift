//
//  OverviewProfileView.swift
//  MateMatch
//
//  Created by Никита Котов on 22.02.2024.
//

import SwiftUI

struct OverviewProfileView: View {
    
    @Binding var path: [String]
    
    @StateObject var userVM = UserViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                userPhoto
                if userVM.user.about != nil {
                    bio
                }
                
                if userVM.user.game != nil {
                    games
                }
            }
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.bgColor)
        .overlay(header)
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    path.removeAll(where: { $0 == "Main Section" })
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
        Image(userVM.user.userPhoto.first!)
            .resizable()
            .scaledToFill()
            .frame(height: 500)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 10)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 200, endRadius: 400))
                        .padding(.horizontal, 10)
                    
                    
                    HStack {
                        Image(systemName: userVM.user.purpose?.icon ?? "")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        
                        Text(userVM.user.purpose?.rawValue ?? "")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(25)
                        
                }
            }
    }
    
    var bio: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Био")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            Text(userVM.user.about ?? "")
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
        .foregroundStyle(.black.opacity(0.7))
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
