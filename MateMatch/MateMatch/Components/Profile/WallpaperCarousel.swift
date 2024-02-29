//
//  WallpaperCarousel.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import SwiftUI

struct WallpaperCarousel: View {
    
    @EnvironmentObject private var chatVM: ChatAppearanceViewModel
    
    @Binding var tempBGColor: Color
    @Binding var tempPhotoColor: Color
    @Binding var tempBGImage: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(0...chatVM.background.count - 1, id: \.self) { index in
                    
                    Image(chatVM.background[index])
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(tempPhotoColor)
                        .frame(width: 150, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            tempBGImage = chatVM.background[index]
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(tempBGColor)
                        }
                        .overlay {
                            if tempBGImage == chatVM.background[index] {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.black, lineWidth: 1)
                                    
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                        .background {
                                            Circle()
                                                .fill(.black)
                                                .frame(width: 50, height: 50)
                                        }
                                }
                            }
                        }
                        .tag(index)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    WallpaperCarousel(tempBGColor: .constant(.red), tempPhotoColor: .constant(.yellow), tempBGImage: .constant("pattern-10"))
        .environmentObject(ChatAppearanceViewModel())
}
