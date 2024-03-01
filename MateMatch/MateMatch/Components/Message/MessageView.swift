//
//  MessageView.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct MessageView: View {
    
    let mate: Mate
    
    @State private var randomHour: Int
    @State private var randomMin: Int
    
    init(mate: Mate) {
        self.mate = mate
        randomHour = .random(in: 1...24)
        randomMin = .random(in: 10...59)
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(mate.avatar.first!.name)
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
                    
                    HStack(spacing: 5) {
                        Text("\(randomHour):\(randomMin)")
                            .font(.system(size: 14))
                            .foregroundStyle(.black.opacity(0.4))
                        
                        Image("double-check")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(width: 15, height: 15)
                    }
//                    .padding(.horizontal)
                }
                
                Text("Oh yeah, малыш (Малыш), I’m perfect (Perfect), Я слышал somebody get hurt (Get hurt), They wish me dead, no coffin (Coffin), I stick to the hate, they giving me profit (My life), Living my life, this shit so perfect, Grabbin' that bag and manifest options, (Yeah, yeah, yeah, yeah, Я-я, я-я)")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 110)
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
