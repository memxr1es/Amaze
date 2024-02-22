//
//  Tag.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import Foundation

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var tag: Tags
    var isExceeded = false // <-- stop auto update
}

enum Tags: String, CaseIterable {
    case dota = "Dota 2"
    case counterStrike = "CS:2"
    case apexLegends = "Apex Legends"
    case leagueOfLegends = "League of Legends"
    case minecraft = "Minecraft"
    case rocketLeague = "Rocket League"
    case phasmofobia = "Phasmofobia"
    case backrooms = "Backrooms"
    case brawlStars = "Brawl Stars"
    case standoff = "Standoff 2"
    
    var id: Int {
        return Tags.allCases.firstIndex(of: self) ?? 0
    }
}
