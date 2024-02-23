//
//  UserViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 21.02.2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user = User(firstName: "Никита", userPhoto: ["user-avatar"], age: 21, birthDay: Date.now, gender: .male, about: "Есть что-то во мне особенное...", game: [.apexLegends, .backrooms, .dota, .minecraft], purpose: nil)
}

