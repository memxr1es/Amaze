//
//  MatchedMateView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct MatchedMateView: View {
    
    let mate: Mate
    
    var body: some View {
        VStack {
            Image(mate.avatar.first!.name)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay {
                    Image(mate.verified ? "verified" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                }
            
            Text(mate.name)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    MatchedMateView(mate: MOCK_MATE[0])
}
