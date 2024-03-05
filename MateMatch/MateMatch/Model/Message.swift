//
//  Message.swift
//  MateMatch
//
//  Created by Никита Котов on 04.03.2024.
//

import Foundation

struct Message: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var time: Date
    var fromUser: Bool = false
}
