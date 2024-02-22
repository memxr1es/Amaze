//
//  MessageView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct MessageView: View {
    
    let mate: Mate
    
    var body: some View {
        HStack(spacing: 15) {
            Image(mate.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text(mate.name)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Image(mate.verified ? "verified" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                    
                    Text("17:21")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.horizontal)
                }
                
                Text("Oh yeah, малыш (Малыш), I’m perfect (Perfect), Я слышал somebody get hurt (Get hurt), They wish me dead, no coffin (Coffin), I stick to the hate, they giving me profit (My life), Living my life, this shit so perfect, Grabbin' that bag and manifest options, (Yeah, yeah, yeah, yeah, Я-я, я-я)")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
//            .frame(width: .infinity, height: 70)
        }
        .padding(5)
        .background(.white)
    }
}

#Preview {
    MessageView(mate: MOCK_MATE[1])
}
