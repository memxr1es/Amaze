//
//  UserViewModel.swift
//  MateMatch
//
//  Created by Никита Котов on 21.02.2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user = User(firstName: "Никита", userPhoto: ["user-avatar", "nikita", "nikita-2"], age: 21, birthDay: Date.now, gender: .male, about: "Есть что-то во мне особенное...", isVerified: false, city: "Рязань", game: [.apexLegends, .backrooms, .dota, .minecraft], purpose: .fun)
    
    @Published var completed: [String: Bool] = [:]
    
    @Published var showPhoto: Bool = false
    @Published var showBio: Bool = false
    @Published var showStatus: Bool = false
    @Published var showInfo: Bool = false
    
    @Published var valueOfSection: [String: Int] = [:]
    @Published var fillCompleteValue: CGFloat = .zero
    
    init() {
        fillCompleted()
        calculateCircleProcent()
    }
    
    func fillCompleted() {
        completed = [
            "Верификация": user.isVerified ? false : true,
            "Больше фото": user.userPhoto.count < 5 ? true : false,
            "Личное био": user.about.isEmpty ? true : false,
            "Твой статус": user.purpose == nil ? true : false,
            "Доп. инфо": user.city == nil ? true : false,
        ]
        
        valueOfSection = [
            "Верификация": user.isVerified ? 20 : 0,
            "Больше фото": user.userPhoto.count == 1 ? 24 : (user.userPhoto.count == 2 ? 18 : (user.userPhoto.count == 3 ? 12 : (user.userPhoto.count == 4 ? 6 : 0))),
            "Личное био": user.about.isEmpty ? 0 : 30,
            "Твой статус": user.purpose == nil ? 0 : 16,
            "Доп. инфо": user.city == nil ? 0 : 8,
        ]
    }
    
    func calculateCircleProcent() {
        fillCompleteValue = valueOfSection.compactMap { CGFloat($0.value) }.reduce(0, +).rounded()
        
        print(fillCompleteValue)
    }
}

