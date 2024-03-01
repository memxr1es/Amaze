//
//  Color.swift
//  MateMatch
//
//  Created by Никита Котов on 10.02.2024.
//

import SwiftUI

extension Color {
    static let theme = ProjectTheme()
}

struct ProjectTheme {
    let bgColor = Color(#colorLiteral(red: 0.9764705882, green: 0.9725490196, blue: 0.9921568627, alpha: 1))
    let accentColor = Color(#colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9607843137, alpha: 1))
    let mainColor = Color(#colorLiteral(red: 0, green: 0.8, blue: 0.7803921569, alpha: 1))
    let secondColor = Color(#colorLiteral(red: 0, green: 0.8745098039, blue: 0.8509803922, alpha: 1))
    let shadowColor = Color(#colorLiteral(red: 0.964160502, green: 0.9669174552, blue: 1, alpha: 1))
}
