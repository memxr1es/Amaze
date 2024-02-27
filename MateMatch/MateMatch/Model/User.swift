//
//  User.swift
//  MateMatch
//
//  Created by Никита Котов on 12.02.2024.
//

import Foundation

struct User: Identifiable, Equatable {
    var id = UUID().uuidString
    var firstName: String
    var userPhoto: [String]
    var age: Int
    var birthDay: Date
    var gender: Genders
    var about: String = ""
    var isVerified: Bool = false
    var city: String?
    var game: [Tags]?
    var purpose: Purpose?
}

enum Genders: String, CaseIterable {
    case male = "Мужчина"
    case female = "Женщина"
}
