//
//  PhotoProfile.swift
//  MateMatch
//
//  Created by Никита Котов on 11.02.2024.
//

import SwiftUI

struct PhotoProfile: View {
    
    let main: Bool
    let index: Int
    @StateObject private var userVM = UserViewModel()
    //    @EnvironmentObject private var userVM: UserViewModel
    
    var body: some View {
        if main {
            Image(userVM.user.userPhoto[0])
                .resizable()
                .scaledToFill()
                .frame(width: 210, height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    Text("Главное фото")
                        .font(.system(size: 14, weight: .thin, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background {
                            VisualEffectView(effect: UIBlurEffect(style: .dark))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .opacity(0.6)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(10)
                }
                .padding(10)
            //                .padding(.leading, 5)
        } else {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.theme.bgColor)
                .frame(width: 100, height: 100)
                .overlay {
                    if index > userVM.user.userPhoto.count - 1 {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.gray.opacity(0.3))
                    }
                    else {
                        Image(userVM.user.userPhoto[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    Text("\(index)")
                        .font(.system(size: 10))
                        .foregroundStyle(.gray.opacity(0.3))
                        .padding(5)
                        .background {
                            Circle()
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(5)
                        .padding(.leading, 5)
                }
        }
    }
}


#Preview {
    PhotoProfile(main: false, index: 1)
//    EditProfileView(path: .constant([]))
}
