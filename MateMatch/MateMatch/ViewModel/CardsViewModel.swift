//
//  CardsViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import Foundation

class CardsViewModel: ObservableObject {
    
    @Published var fetched_mates: [Mate] = [
        Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-2"), Photo(name: "xxx"), Photo(name: "xxx-2")], verified: true, gender: .male, city: "Москва", purpose: .stream),
        Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: [Photo(name: "user-avatar-3"), Photo(name: "user-avatar-7")], verified: false, gender: .female, city: "Москва"),
        Mate(name: "Даша", age: 25, avatar: [Photo(name: "user-avatar-4"), Photo(name: "user-avatar-8")], verified: false, gender: .female),
        Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-5"), Photo(name: "user-avatar-9")], verified: false, gender: .male),
        Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: [Photo(name: "user-avatar-6"), Photo(name: "user-avatar-10")], verified: true, gender: .male, city: "Санкт-Петербург", purpose: .mate)
    ]
    
    @Published var displaying_mates: [Mate]?
    
    init() {
        fetched_mates = [
            Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-2"), Photo(name: "xxx"), Photo(name: "xxx-2")], verified: true, gender: .male, city: "Москва", purpose: .stream),
            Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: [Photo(name: "user-avatar-3"), Photo(name: "user-avatar-7")], verified: false, gender: .female, city: "Москва"),
            Mate(name: "Даша", age: 25, avatar: [Photo(name: "user-avatar-4"), Photo(name: "user-avatar-8")], verified: false, gender: .female),
            Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-5"), Photo(name: "user-avatar-9")], verified: false, gender: .male),
            Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: [Photo(name: "user-avatar-6"), Photo(name: "user-avatar-10")], verified: true, gender: .male, city: "Санкт-Петербург", purpose: .mate)
        ]
        
        displaying_mates = fetched_mates
    }
    
    @Published var showMateProfile: Bool = false
    @Published var selectedMate: Mate? = nil
    
    func getIndex(mate: Mate) -> Int {
        let index = displaying_mates?.firstIndex(where: { currentMate in
            return mate.id == currentMate.id
        }) ?? 0
        
        return index
    }
}
