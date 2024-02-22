//
//  InfoChoice.swift
//  MateMatch
//
//  Created by Никита Котов on 12.02.2024.
//

import SwiftUI

struct InfoChoice: View {
    
    let columns = [GridItem(.fixed(50), alignment: .top), GridItem(.flexible(), alignment: .leading)]
    
    @Binding var selectedPurpose: Purpose?
    
    var body: some View {
        ForEach(Purpose.allCases, id: \.self) { purpose in
            LazyVGrid(columns: columns) {
                Image(systemName: purpose.icon)
                    .font(.system(size: 20))
                    .foregroundStyle(.gray.opacity(0.5))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(purpose.rawValue)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Text(purpose.description)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(.gray.opacity(0.6))
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .stroke(selectedPurpose == purpose ? .black : .clear, lineWidth: 1.5)
                    .shadow(color: Color.theme.bgColor, radius: 10)
                    .shadow(color: Color.theme.bgColor.opacity(0.6), radius: 10)
                    .shadow(color: Color.theme.bgColor.opacity(0.3), radius: 10)
            }
            .padding(.horizontal)
            .padding(.top, 5)
            .onTapGesture {
                selectedPurpose = purpose
            }
        }
    }
}

#Preview {
    ChoicePurpose()
}

enum Purpose: String, CaseIterable {
    case fun = "Друг"
    case mate = "Напарник"
    case stream = "Стримы"
    
    var description: String {
        switch self {
            case .fun: return "Поиск человека, с которым можно лампово провести вечер"
            case .mate: return "Когда ищешь того самого тащера, с которым можно покорить высоты"
            case .stream: return "Общаться, делиться мыслями и идеями без ограничений"
        }
    }
    
    var icon: String {
        switch self {
            case .fun: return "person.2"
            case .mate: return "gamecontroller"
            case .stream: return "tv"
        }
    }
}
