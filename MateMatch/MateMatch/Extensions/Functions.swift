//
//  Date.swift
//  MateMatch
//
//  Created by Никита Котов on 16.02.2024.
//

import Foundation

func shortDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "d MMM yyyy"

    
    let formattedDate = dateFormatter.string(from: date)
    
    return formattedDate
}

func declesions(_ count: Int) -> String {
    switch count {
        case 1: return "игра"
        case 2...4: return "игры"
        case 5...6: return "игр"
            
        default: return "игр"
    }
}
