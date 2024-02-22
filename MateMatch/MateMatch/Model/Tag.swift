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
    
    var icon: String {
        switch self {
            case .dota: return "dota2"
            case .counterStrike: return "counter-strike"
            case .apexLegends: return "apex-legends"
            case .leagueOfLegends: return "league-of-legends"
            case .minecraft: return "minecraft"
            case .rocketLeague: return "rocket-league"
            case .phasmofobia: return "phasmofobia"
            case .backrooms: return "backrooms"
            case .brawlStars: return "brawl-stars"
            case .standoff: return "standoff"
        }
    }
}
