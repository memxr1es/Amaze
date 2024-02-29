//
//  MateMatchApp.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import SwiftUI
import UserNotifications

@main
struct MateMatchApp: App {
    
    @StateObject private var launchScreenState = LaunchScreenStateManager()

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor.white
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .none
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView()
                
                if launchScreenState.state != .finished {
                    SplashScreenView()
                }
            }
            .environmentObject(launchScreenState)
        }
    }
}

