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
        HStack {
            Image(uiImage: UIImage(named: tag.icon)!)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
            
            Text(tag.rawValue)
                .font(.system(size: 14, weight: .medium, design: .rounded))
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
