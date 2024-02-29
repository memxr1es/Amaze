//
//  CorrespondenceView.swift
//  MateMatch
//
//  Created by Никита Котов on 28.02.2024.
//

import SwiftUI

struct CorrespondenceView: View {
    
    let mate: Mate
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var cardData: CardsViewModel
//    @StateObject private var cardData: CardsViewModel = CardsViewModel()
    
    @State private var randomHour: Int = 0
    @State private var randomMin: Int = 0
    
    @FocusState private var isFocused: Bool
    
    @State private var message: String = ""
    
    @Binding var path: [String]
    
    var body: some View {
        VStack {
            ScrollView {
                
            }
            .onTapGesture {
                isFocused = false
            }
            
            footer
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.theme.bgColor
            
            Image("chat-wallpaper")
                .resizable()
                .scaledToFill()
                .opacity(0.05)
        }
        .overlay(header)
        .onAppear {
            self.randomHour = .random(in: 1...24)
            self.randomMin = .random(in: 10...59)
        }
        .overlay {
            if cardData.showMateProfile {
                MateOverviewView(mate: mate, fromChatView: true)
                    .environmentObject(cardData)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    dismiss()
                }
            
            Spacer()

            
            matePreview
                .onTapGesture {
                    withAnimation {
                        path.append("Mate Profile")
                    }
                }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.top, 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .frame(height: 110)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        }
    }
    
    var matePreview: some View {
        HStack(alignment: .center, spacing: 15) {
            Image(mate.avatar.first!.name)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 5) {
                    Text(mate.name)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Image(mate.verified ? "verified" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
                
                Text("Был(а) в сети в \(randomHour):\(randomMin)")
                    .font(.system(size: 12))
                    .foregroundStyle(.black.opacity(0.4))
 
            }
        }
    }
    
    var footer: some View {
        VStack {
            HStack {
                Image("attach")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 27, height: 27)
                    .foregroundStyle(.black.opacity(0.4))
                    .padding(.trailing, 5)
                
                TextField(text: $message, prompt: Text("Сообщение...").font(.system(size: 16)).foregroundStyle(.black.opacity(0.3))) {
                    EmptyView()
                }
                .foregroundStyle(.black)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.1), lineWidth: 1)
                }
                .tint(.black)
                .focused($isFocused)
                
                Button {
                    
                } label: {
                    Image("arrowhead")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(message.isEmpty ? 180 : 90))
                        .background {
                            Circle()
                                .fill(message.isEmpty ? .black.opacity(0.2) : .black.opacity(0.9))
                                .frame(width: 30, height: 30)
                        }
                        .padding(.leading, 8)
                }
                .disabled(message.isEmpty)
            }
        }
        .animation(.bouncy, value: message)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .padding(.top, 5)
        .padding(.bottom, isFocused ? 5 : 0)
        .background(.white)
        .animation(isFocused ? .none : .easeOut(duration: 0.9), value: isFocused)
    }
}

#Preview {
    CorrespondenceView(mate: MOCK_MATE[0], path: .constant([]))
}
