//
//  GenderChoice.swift
//  MateMatch
//
//  Created by Никита Котов on 06.02.2024.
//

import SwiftUI

struct GenderChoice: View {
    
    var genders: [String] = [
        "Мужчина", "Женщина", "Неважно"
    ]
    
    @State var selectedGender: String = "Мужчина"
    
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(genders, id: \.self) { gender in
                    Text(gender)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(selectedGender == gender ? .white : .gray)
                        .padding(.horizontal, 20)
                        .tag(gender)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedGender = gender
                            }
                        }
                        .padding(.vertical, 10)
                        .matchedGeometryEffect(id: gender, in: animation)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
                    .frame(width: 100, height: 40)
                    .offset(x: selectedGender == "Мужчина" ? -105 : selectedGender == "Неважно" ? 103 : 0)
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemGray).opacity(0.3))
        }
        .padding()
    }
}

#Preview {
    GenderChoice()
}
