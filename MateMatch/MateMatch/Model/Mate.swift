//
//  Mate.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import Foundation

struct Mate: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var age: Int
    var tags: [Tag]?
    var avatar: [Photo]
    var verified: Bool
    var gender: Genders
    var about: String = ""
    var city: String?
    var purpose: Purpose?
}

struct Photo: Identifiable, Hashable {
    var id: UUID = .init()
    var name: String
}
