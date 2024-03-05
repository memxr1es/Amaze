//
//  CardsViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import Foundation
import Combine

class CardsViewModel: ObservableObject {
    
    @Published var fetched_mates: [Mate] = [
        Mate(name: "Данил", age: 22, tags: [Tag(tag: .brawlStars), Tag(tag: .phasmofobia), Tag(tag: .rocketLeague), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-2"), Photo(name: "xxx"), Photo(name: "xxx-2")], verified: true, gender: .male, about: "Радуюсь жизни. Пишу треки. Don't even star ✨", city: "Москва", purpose: .stream),
        Mate(name: "Настя", age: 16, tags: [Tag(tag: .dota), Tag(tag: .leagueOfLegends)], avatar: [Photo(name: "user-avatar-3"), Photo(name: "user-avatar-7")], verified: false, gender: .female, about: "Are u seriously?", city: "Москва"),
        Mate(name: "Даша", age: 25, avatar: [Photo(name: "user-avatar-4"), Photo(name: "user-avatar-8")], verified: false, gender: .female),
        Mate(name: "Иван", age: 18, tags: [Tag(tag: .counterStrike), Tag(tag: .apexLegends), Tag(tag: .standoff)], avatar: [Photo(name: "user-avatar-5"), Photo(name: "user-avatar-9")], verified: false, gender: .male, about: "Здесь по приколу 😗✌️"),
        Mate(name: "Дима", age: 20, tags: [Tag(tag: .phasmofobia), Tag(tag: .minecraft), Tag(tag: .backrooms), Tag(tag: .rocketLeague)], avatar: [Photo(name: "user-avatar-6"), Photo(name: "user-avatar-10")], verified: true, gender: .male, about: "Хотелось бы найти друга на постоянку, чтобы проводить лампово вечера", city: "Санкт-Петербург", purpose: .mate)
    ]
    
    @Published var displaying_mates: [Mate] = []
    @Published var mates_with_messages: [Mate]?
    
    @Published var matched_mates: [Mate: [Message]] = [:]
    @Published var liked_mates: [Mate] = []
    @Published var disliked_mates: [Mate] = []
    @Published var mates_who_likes_you: [Mate] = []
    
    init() {
        displaying_mates = fetched_mates
        
        fetchMates()
        
        print("⚠️", displaying_mates.last!)
    }
    
    @Published var showMateProfile: Bool = false
    @Published var selectedMate: Mate? = nil
    
    func fetchMates() {
        mates_who_likes_you.append(fetched_mates.last!)
        
        for i in 0...mates_who_likes_you.count - 1 {
            displaying_mates.remove(at: getIndex(mate: mates_who_likes_you[i]))
        }
    }
    
    func getIndex(mate: Mate) -> Int {
        let index = displaying_mates.firstIndex(where: { currentMate in
            return mate.id == currentMate.id
        }) ?? 0
        
        return index
    }
    
    func sendMessage(mate: Mate, message: String) {
        matched_mates[mate]?.append(Message(text: message, time: Date(), fromUser: true))
    }
    
    func addMate(_ mate: Mate) {
        matched_mates[mate] = []
    }
}

