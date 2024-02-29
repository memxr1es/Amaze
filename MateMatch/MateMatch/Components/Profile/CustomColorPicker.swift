//
//  CustomColorPicker.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import SwiftUI

struct CustomColorPicker: View {
    
    let backColor: Bool
    
    @EnvironmentObject private var chatVM: ChatAppearanceViewModel
    
    @Binding var tempBGColor: Color
    @Binding var tempPhotoColor: Color
    
    var body: some View {
        if backColor {
            tempBGColor
                .frame(width: 25, height: 25, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 4)
                }
                .padding(10)
                .background {
                    AngularGradient(gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]), center: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                }
                .overlay {
                    ColorPicker("", selection: $tempBGColor)
                        .labelsHidden()
                        .opacity(0.015)
                }
                .shadow(radius: 5)
        }
        else {
            tempPhotoColor
                .frame(width: 25, height: 25, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 4)
                }
                .padding(10)
                .background {
                    AngularGradient(gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]), center: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                }
                .overlay {
                    ColorPicker("", selection: $tempPhotoColor)
                        .labelsHidden()
                        .opacity(0.015)
                }
                .shadow(radius: 5)
        }
    }
}

#Preview {
    CustomColorPicker(backColor: true, tempBGColor: .constant(.red), tempPhotoColor: .constant(.yellow))
        .environmentObject(ChatAppearanceViewModel())
}
