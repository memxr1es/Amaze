//
//  MateCard.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI

struct MateCard: View {
    
    @State var mateInfo: Mate
    @State var topOffset: CGFloat = 0.0
    
    @State private var cardColor: Color = .clear
    @State private var width: Double =  .zero
    @State private var height: Double = .zero
    @State private var startPoint: UnitPoint = .zero
    @State private var endPoint: UnitPoint = .zero
    
    @State var swipeEnd: Bool = false
    @State var like: Bool = false
    @State var dismiss: Bool = false
    @State var superLike: Bool = false
    
    @EnvironmentObject var cardData: CardsViewModel

    var body: some View {
        ZStack {
            userPhoto
            shadowRectangle
            userInfo
            overlayRectangle
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 220)
        .overlay {
            choiceIcon
            
            shortInfo
        }
        .offset(x: width, y: height)
        .rotationEffect(.degrees(Double(width / 40)))
        .gesture(gesture)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            withAnimation {
                cardData.showMateProfile.toggle()
                cardData.selectedMate = mateInfo
            }
        }))
    }
    
    var shadowRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(
                .linearGradient(colors: [.black.opacity(0.8), .black.opacity(0.5), .clear, .clear], startPoint: .bottom, endPoint: .top)
            )
    }
    
    var shortInfo: some View {
        HStack(spacing: 20) {
            HStack(spacing: 5) {
                Image(systemName: mateInfo.city != nil ? "network" : "")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                
                Text(mateInfo.city ?? "")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
            }
            
            HStack(spacing: 5) {
                Image(systemName: mateInfo.purpose?.icon ?? "")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                
                Text(mateInfo.purpose?.rawValue ?? "")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Image(systemName: "hand.raised")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .opacity(0.8)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 30)
        .padding(.horizontal, 20)
    }
    
    var choiceIcon: some View {
        Image(width > 100 ? "flag" : (width < -100 ? "game-over" : ""))
            .resizable()
            .scaledToFill()
            .frame(width: 70, height: 70)
            .animation(.none, value: width)
            .rotationEffect(.degrees(width > 100 ? 30 : 0))
    }
    
    var userInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 5) {
                Text("\(mateInfo.name),")
                    .font(.system(size: 36, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                
                Text("\(mateInfo.age)")
                    .font(.system(size: 36, weight: .thin, design: .rounded))
                    .foregroundStyle(.white)
            }
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 20, data: mateInfo.tags ?? [], spacing: 10, alignment: .leading) { item in
                UserTag(tag: item.tag)
            }
        
            HStack {
                Spacer()
                Spacer()
                buttonDismiss
                Spacer()
                buttonSuperLike
                Spacer()
                buttonLike
                Spacer()
                Spacer()
            }
            .frame(height: 70)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 220, alignment: .bottom)
    }
    
    var userPhoto: some View {
        Image("\(mateInfo.avatar.first!)")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 220, alignment: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.radialGradient(Gradient(colors: [.clear, .black]), center: .center, startRadius: 250, endRadius: 400))
            }
        
    }
    
    var overlayRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(
                .linearGradient(colors: [cardColor.opacity(0.7), cardColor.opacity(0.5), cardColor.opacity(0.3), .clear, .clear], startPoint: startPoint, endPoint: endPoint)
            )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
            case -500...(-150):
                endSwipeActions()
                self.width = -500
            case 150...500:
                endSwipeActions()
                self.width = 500
            default:
                self.width = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
            case -500...(-100):
                cardColor = .red
            case 100...500:
                cardColor = .green
            default:
                cardColor = .clear
        }
    }
    
    func switchPoints(width: CGFloat) {
        switch width {
            case -500...(-100):
                startPoint = .bottomLeading
                endPoint = .topTrailing
            case 100...500:
                startPoint = .bottomTrailing
                endPoint = .topLeading
            default:
                startPoint = .zero
                endPoint = .zero
        }
    }
    
    func endSwipeActions() {
        withAnimation(.none) {swipeEnd = true}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = cardData.displaying_mates?.first {
                let _ = withAnimation {
                    cardData.displaying_mates?.removeFirst()
                }
            }
        }
    }
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                width = value.translation.width
                
                withAnimation {
                    changeColor(width: width)
                    switchPoints(width: width)
                }
            }
            .onEnded { _ in
                withAnimation {
                    swipeCard(width: width)
                    changeColor(width: width)
                    switchPoints(width: width)
                }
            }
    }
    
    var buttonDismiss: some View {
        Button {
            withAnimation { dismiss = true }
            
            width = -500
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.7992287278, green: 0.2787470222, blue: 0.1960831881, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.3494336605, blue: 0.2451342344, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6274509804, blue: 0, alpha: 1))], startPoint: .leading, endPoint: .trailing)
                )
                .font(.system(size: 32, weight: .bold))
                .padding()
                .overlay {
                    Circle()
                        .stroke(Color(#colorLiteral(red: 0.7992287278, green: 0.2787470222, blue: 0.1960831881, alpha: 1)), lineWidth: 2)
                }
        }
    }
    
    var buttonLike: some View {
        Button {
            withAnimation { like = true }
        } label: {
            Image(systemName: "heart.fill")
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.03890835494, green: 0.7837518454, blue: 0.04897373915, alpha: 1)), Color(#colorLiteral(red: 0.3239632249, green: 0.9754689336, blue: 0.2939786017, alpha: 1)), Color(#colorLiteral(red: 0.4171791077, green: 0.9745394588, blue: 0.4454519749, alpha: 1)), Color(#colorLiteral(red: 0.7059798241, green: 0.9696601033, blue: 0.7210475802, alpha: 1))], startPoint: .leading, endPoint: .trailing)
                )
                .font(.system(size: 30, weight: .bold))
                .padding(15)
                .overlay {
                    Circle()
                        .stroke(Color(#colorLiteral(red: 0.03890835494, green: 0.7837518454, blue: 0.04897373915, alpha: 1)), lineWidth: 2)
                }
        }
    }
    
    var buttonSuperLike: some View {
        Button {
            withAnimation { superLike = true }
        } label: {
            Image(systemName: "star.fill")
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1))], startPoint: .leading, endPoint: .trailing)
                )
                .font(.system(size: 24, weight: .regular))
                .padding(12)
                .overlay {
                    Circle()
                        .stroke(Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), lineWidth: 2)
                }
        }
    }
}

struct PressEffectButtonStyle_Choice: ButtonStyle {
    
    let gradient: LinearGradient
    @Binding var action: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

let MOCK_MATE = [
    Mate(name: "Никита", age: 21, tags: [Tag(tag: .apexLegends), Tag(tag: .backrooms), Tag(tag: .dota), Tag(tag: .counterStrike), Tag(tag: .leagueOfLegends)], avatar: ["user-avatar"], verified: true, gender: .male),
    Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: ["user-avatar-2"], verified: true, gender: .male, city: "Москва", purpose: .stream),
    Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: ["user-avatar-3"], verified: false, gender: .female, city: "Москва"),
    Mate(name: "Даша", age: 25, avatar: ["user-avatar-4"], verified: false, gender: .female),
    Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: ["user-avatar-5"], verified: false, gender: .male),
    Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: ["user-avatar-6"], verified: true, gender: .male, city: "Санкт-Петербург", purpose: .mate)
]

#Preview {
    MateCard(mateInfo: MOCK_MATE[5])
}
