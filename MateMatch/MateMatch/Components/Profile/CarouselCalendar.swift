//
//  CarouselCalendar.swift
//  MateMatch
//
//  Created by Никита Котов on 19.02.2024.
//

import SwiftUI

struct CarouselCalendar: View {
    
    @State private var birthDate = Date.now
    @Binding var currentDate: String
    @Binding var currentDateUser: Date
    @Binding var showDatePicker: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Text("Отменить")
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                
                Text("Готово")
                    .onTapGesture {
                        currentDate = shortDate(birthDate)
                        currentDateUser = birthDate
                        showDatePicker = false
                    }
            }
            .font(.system(size: 17, weight: .light))
            .foregroundColor(Color.theme.mainColor)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .padding(.top, 5)
            
            Rectangle()
                .fill(.black.opacity(0.2))
                .frame(height: 0.5)
            
            DatePicker(selection: $birthDate, in: ...Date.now.addingTimeInterval(-567993600), displayedComponents: .date) {
            }
            .environment(\.colorScheme, .light)
            .tint(.black)
            .datePickerStyle(.wheel)
            .environment(\.locale, Locale(identifier: "ru_RU"))
            .labelsHidden()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.white)
    }
}

#Preview {
    CarouselCalendar(currentDate: .constant(""), currentDateUser: .constant(Date.now), showDatePicker: .constant(true))
}
