//
//  PayAttention.swift
//  MateMatch
//
//  Created by Никита Котов on 19.02.2024.
//

import SwiftUI

struct PayAttention: View {
    
    let section: MainSections
    
    var nameOfSection: String {
        switch section {
        case .name:
            return "Имя"
        case .birthday:
            return "Дату рождения"
        case .gender:
            return "Пол"
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 22, weight: .light))
                .padding(.bottom, 10)
            
            Text("Обрати внимание!")
            
            Text("\(nameOfSection) можно изменить только 1 раз")
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.black.opacity(0.5))
        .font(.system(size: 14))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.gray.opacity(0.1))
        }
        .padding(.horizontal)
    }
}

#Preview {
    PayAttention(section: .gender)
}
