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
