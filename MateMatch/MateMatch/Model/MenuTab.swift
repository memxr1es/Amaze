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
    
    var icon_out: String {
        switch self {
        case .main:
            return "a_out"
        case .overview:
            return "heart_out"
        case .message:
            return "chat_out"
        case .profile:
            return "person_out"
        }
    }
    
    var icon_fill: String {
        switch self {
        case .main:
            return "a_fill"
        case .overview:
            return "heart_fill"
        case .message:
            return "chat_fill"
        case .profile:
            return "person_fill"
        }
    }
    
    var id: Int {
        return MenuTab.allCases.firstIndex(of: self) ?? 0
    }
}
