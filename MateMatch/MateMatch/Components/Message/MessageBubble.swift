//
//  MessageBubble.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import SwiftUI

struct MessageBubble: View {
    
    let fromUser: Bool
    let message: String
    let time: String
    
    let messageColor: Color
    
    var body: some View {
        if fromUser {
            HStack(spacing: 0) {
                Text(message)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 5)
                    .padding(5)
                    .padding(.trailing, 45)
                    .overlay {
                        HStack(alignment: .bottom) {
                            Text(time)
                                .font(.system(size: 10))
                                .foregroundStyle(.white.opacity(0.5))
                                .padding(.trailing, 8)
                                .padding(.bottom, 2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
            }
            .padding(5)
            .background {
                Rectangle()
                    .fill(messageColor.gradient)
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
            
        } else {
            HStack(spacing: 0) {
                Text(message)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 5)
                    .padding(5)
                    .padding(.trailing, 45)
                    .overlay {
                        HStack(alignment: .bottom) {
                            Text(time)
                                .font(.system(size: 10))
                                .foregroundStyle(.white.opacity(0.5))
                                .padding(.trailing, 8)
                                .padding(.bottom, 2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
            }
            .padding(5)
            .background {
                Rectangle()
                    .fill(.black.gradient)
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomRight])
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
        }
    }
}

#Preview {
    Group {
//        MessageBubble(fromUser: true, message: "Здарова Влад, сядем сегодня в дотку в 19?")
//        MessageBubble(fromUser: false, message: "Здарова, смогу только после 8и 🥲")
//        MessageBubble(fromUser: true, message: "Оки, до вечера тогда")
    }
}
