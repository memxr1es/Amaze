//
//  ChatAppearanceViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import Foundation
import SwiftUI

class ChatAppearanceViewModel: ObservableObject {
    @Published var selectedBackgroundImage: String = "pattern-1"
    
    let background: [String] = [
        "pattern-1", "pattern-2", "pattern-3", "pattern-4", "pattern-5", "pattern-6", "pattern-7", "pattern-8", "pattern-9", "pattern-10", "pattern-11", "pattern-12", "pattern-13", "pattern-14", "pattern-15", "pattern-16", "pattern-17", "pattern-18", "pattern-19", "pattern-20", "pattern-21", "pattern-22", "pattern-24", "pattern-25", "pattern-26", "pattern-28", "pattern-29", "pattern-31", "pattern-32", "pattern-33"
    ]
    
    @Published var selectedColorBackground: Color = Color.theme.bgColor
    @Published var selectedColorPhoto: Color = Color.black.opacity(0.05)
    @Published var selectedMessageColor = Color.blue
    
    @Published var selectedTempBGColor = Color.theme.bgColor
    @Published var selectedTempPhotoColor = Color.black
    @Published var selectedTempMessageColor = Color.blue
    @Published var selectedTempBackgroundImage = ""
    
    let systemBGImage = "pattern-1"
    let systemBGColor = Color.theme.bgColor
    let systemPhotoColor = Color.black.opacity(0.05)
    let systemMessageColor = Color.blue
}
