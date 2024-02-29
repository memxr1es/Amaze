//
//  LaunchScreenStateManager.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import Foundation 
final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            try? await Task.sleep(for: Duration.seconds(1))
            
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(2.5))

            self.state = .finished
        }
    }
}
