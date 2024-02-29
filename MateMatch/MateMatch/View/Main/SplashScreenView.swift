//
//  SplashScreenView.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @State private var firstAnimation: Bool = false
    @State private var secondAnimation: Bool = false
    @State private var startFadeoutAnimation: Bool = false
    
    var body: some View {
        ZStack {
            background
            text
        }
        .onReceive(animationTimer) { _ in
            updateAnimation()
        }
        .opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private var text: some View {
        Text("AMAZE")
            .font(.system(size: 38, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .scaleEffect(firstAnimation ? 0.5 : (secondAnimation ? 3 : 0))
            .opacity(startFadeoutAnimation ? 0.5 : 1)
    }
    
    private let animationTimer = Timer
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    private var background: some View {
        LinearGradient(
            colors: [Color(#colorLiteral(red: 0.01106899139, green: 0.03459626809, blue: 0.03383141011, alpha: 1)), Color.theme.mainColor],
            startPoint: .bottom,
            endPoint: .top
        )
        .ignoresSafeArea()
    }
    
    private func updateAnimation() {
        switch launchScreenState.state {
            case .firstStep:
                withAnimation(.easeInOut(duration: 0.9)) { firstAnimation = true }
            case .secondStep:
                if !secondAnimation {
                    withAnimation(.linear(duration: 2)) {
                        self.firstAnimation = false
                        self.secondAnimation = true
                        startFadeoutAnimation = true
                    }
                }
            case .finished:
                break
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(LaunchScreenStateManager())
}

enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}
