//
//  ChoicePurpose.swift
//  MateMatch
//
//  Created by Никита Котов on 12.02.2024.
//

import SwiftUI

struct ChoicePurpose: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedPurpose: Purpose? = nil
    
    var body: some View {
        VStack {
            Text("Расскажи, для чего ты здесь")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
            
            InfoChoice(selectedPurpose: $selectedPurpose)
            
            acceptButton
            dismissButton
        }
        .frame(maxHeight: .infinity)
        .background(.white)
    }
    
    var acceptButton: some View {
        Button {}
        label: {
            Text("Сохранить")
                .font(.system(size: 18, design: .rounded))
        }
        .buttonStyle(DisabledButtonStyle(disabled: selectedPurpose == nil ? true : false))
    }
    
    var dismissButton: some View {
        Button {
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .frame(height: 55)
                .onTapGesture {
                    dismiss()
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .overlay(content: {
            Text("Не указывать")
                .font(.system(size: 18, design: .rounded))
                .foregroundStyle(.gray)
        })
        .buttonStyle(DragButtonStyle())
    }
}

struct DragButtonStyle: ButtonStyle {
    
    @State private var longPressed: Bool = false
    @GestureState var press = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .simultaneousGesture (
                LongPressGesture(minimumDuration: 100)
                    .updating($press) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
            )
            .onChange(of: press, { oldValue, newValue in
                withAnimation(.easeInOut) { longPressed.toggle() }
            })
            .shadow(color: longPressed ? .black.opacity(0.3) : .clear, radius: longPressed ? 5 : 0, y: longPressed ? 5 : 0)
    }
}

struct DisabledButtonStyle: ButtonStyle {
    
    let disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(disabled ? .gray : .white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 30).foregroundStyle(disabled ? .black.opacity(0.2) : .black))
            .padding(.horizontal)
            .padding(.top, 15)
            
    }
}

#Preview {
    ChoicePurpose()
}
