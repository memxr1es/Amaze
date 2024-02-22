//
//  CardsViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import Foundation

class CardsViewModel: ObservableObject {
    
    @Published var fetched_mates: [Mate] = [
        Mate(name: "Никита", age: 21, tags: [Tag(tag: .apexLegends), Tag(tag: .backrooms), Tag(tag: .dota), Tag(tag: .counterStrike), Tag(tag: .leagueOfLegends)], avatar: "user-avatar", verified: true),
        Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: "user-avatar-2", verified: true),
        Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: "user-avatar-3", verified: false),
        Mate(name: "Даша", age: 25, avatar: "user-avatar-4", verified: false),
        Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: "user-avatar-5", verified: false),
        Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: "user-avatar-6", verified: true)
    ]
    
    @Published var displaying_mates: [Mate]?
    
    init() {
        fetched_mates = [
            Mate(name: "Никита", age: 21, tags: [Tag(tag: .apexLegends), Tag(tag: .backrooms), Tag(tag: .dota), Tag(tag: .counterStrike), Tag(tag: .leagueOfLegends)], avatar: "user-avatar", verified: true),
            Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: "user-avatar-2", verified: true),
            Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: "user-avatar-3", verified: false),
            Mate(name: "Даша", age: 25, avatar: "user-avatar-4", verified: false),
            Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: "user-avatar-5", verified: false),
            Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: "user-avatar-6", verified: true)
        ]
        
        displaying_mates = fetched_mates
    }
    
    func getIndex(mate: Mate) -> Int {
        let index = displaying_mates?.firstIndex(where: { currentMate in
            return mate.id == currentMate.id
        }) ?? 0
        
        return index
    }
}
