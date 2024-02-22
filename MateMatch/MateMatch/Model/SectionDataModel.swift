//
//  SectionDataModel.swift
//  MateMatch
//
//  Created by Никита Котов on 21.02.2024.
//

import Foundation

struct SectionDataModel: Identifiable {
    var id: String {
        return name
    }
    
    var name: String
    var description: String
    var expanded: Bool = false
}
