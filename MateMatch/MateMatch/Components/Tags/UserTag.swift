//
//  UserTag.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI

struct UserTag: View {
    
    let tag: Tags
    
    var body: some View {
        HStack(spacing: 5) {
            Image(uiImage: UIImage(named: tag.icon)!)
                .resizable()
                .scaledToFill()
                .frame(width: 15, height: 15)
                .foregroundStyle(.white)
            
            Text(tag.rawValue)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .fixedSize()
                .foregroundStyle(.white.opacity(1))
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.5))
        }
    }
}

#Preview {
    UserTag(tag: .apexLegends)
}
