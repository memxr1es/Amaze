//
//  MenuTab.swift
//  MateMatch
//
//  Created by Никита Котов on 30.01.2024.
//

import Foundation
import SwiftUI

enum MenuTab: String, CaseIterable {
    case main
    case overview
    case message
    case profile
    
    var icon: String {
        switch self {
        case .main:
            return "heart.circle.fill"
        case .overview:
            return "sparkle.magnifyingglass"
        case .message:
            return "bubble.left.and.bubble.right.fill"
        case .profile:
            return "person.circle.fill"
        }
    }
    
    var id: Int {
        return MenuTab.allCases.firstIndex(of: self) ?? 0
    }
}
