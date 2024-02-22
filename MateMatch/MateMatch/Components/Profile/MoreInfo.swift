//
//  MoreInfo.swift
//  MateMatch
//
//  Created by Никита Котов on 15.02.2024.
//

import SwiftUI

struct MoreInfo: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(Category.allCases, id: \.self) { category in
                    VStack(alignment: .leading, spacing: 10) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(category.rawValue)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundStyle(.black)
                            
                            Text(category.description)
                                .font(.system(size: 12, weight: .light, design: .rounded))
                                .foregroundStyle(.black)
                        }
                        .padding(.top, 35)
                        
                        Button {}
                        label: {
                            HStack {
                                Text("Добавить")
                                    .font(.system(size: 12, design: .rounded))
                                    .foregroundStyle(.black)
                                    
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.white)
                            }
                        .padding(.top, 10)
                        }
                        .padding(.trailing, -20)
                    }
                    .frame(width: 110, height: 150, alignment: .topLeading)
                    .padding(.top)
                    .padding(.horizontal, 10)
                    .padding(.trailing, 20)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.theme.mainColor.opacity(0.1))
                    }
                    .padding()
                    .overlay {
                        ZStack {
                            Image(systemName: category.icon)
                                .font(.system(size: 24))
                                .foregroundStyle(Color.theme.mainColor)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(30)
                            
                            Text("+\(category.percentageForEach)%")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundStyle(.gray)
                                .frame(width: 55, height: 25)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(30)
                        }
                    }
                    .padding(.horizontal, -10)
                }
            }
        }
    }
}

#Preview {
    MoreInfo()
}

enum Category: String, CaseIterable {
    case verification = "Верификация"
    case morePhoto = "Больше фото"
    case bio = "Личное био"
    case status = "Твой статус"
    case addInformation = "Доп. инфо"
    
    var icon: String {
        switch self {
            case .verification: return "checkmark.seal.fill"
            case .morePhoto: return "camera.fill"
            case .bio: return "person.fill"
            case .status: return "heart.text.square.fill"
            case .addInformation: return "list.bullet.rectangle.fill"
        }
    }
    
    var percentageForEach: Int {
        switch self {
            case .verification: return 8
            case .morePhoto: return 30
            case .bio: return 50
            case .status: return 8
            case .addInformation: return 4
        }
    }
    
    var description: String {
        switch self {
            case .verification: return "Открой больше функций"
            case .morePhoto: return "Покажи себя людишкам :)"
            case .bio: return "Расскажи о своих лучших сторонах"
            case .status: return "Расскрой карты, кого ты ищешь?"
            case .addInformation: return "Вдруг тебя захотят найти...?)"
        }
    }
}
