//
//  StackCardView.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct StackCardView: View {
    
    @EnvironmentObject var cardData: CardsViewModel
    var mate: Mate
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            /// Computing values
            let index = CGFloat(cardData.getIndex(mate: mate))
            let topOffset = (index <= 0 ? index : 2) * 15
            let scale = (CGFloat(index <= 0 ? 1 : 0.95))
            let disabled = index <= 0 ? false : true
            let opacity = CGFloat(index == 0 ? 0 : 1)
            ///
            
            ZStack {
                MateCard(mateInfo: mate, topOffset: topOffset)
                    .overlay {
                        VisualEffectView(effect: UIBlurEffect(style: .light))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .opacity(opacity)
                    }
                    .scaleEffect(scale)
                    .offset(y: -topOffset)
                    .environmentObject(cardData)
                    .disabled(disabled)

            }
            .frame(width: size.width, height: size.height)
        }
    }
}

#Preview {
    StackCardView(mate: MOCK_MATE[1])
}
