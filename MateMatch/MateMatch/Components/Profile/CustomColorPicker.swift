//
//  CustomColorPicker.swift
//  MateMatch
//
//  Created by Никита Котов on 29.02.2024.
//

import SwiftUI

struct CustomColorPicker: View {
    
    let typeColor: TypeOfColor
    
    @EnvironmentObject private var chatVM: ChatAppearanceViewModel
    
    @Binding var tempBGColor: Color
    @Binding var tempPhotoColor: Color
    @Binding var tempMessageColor: Color
    
    var body: some View {
        if typeColor == .backgroundClr {
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
        } else if typeColor == .photoClr {
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
        } else if typeColor == .messageClr {
            tempMessageColor
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
                    ColorPicker("", selection: $tempMessageColor)
                        .labelsHidden()
                        .opacity(0.015)
                }
                .shadow(radius: 5)
        }
    }
}

#Preview {
    CustomColorPicker(typeColor: .messageClr, tempBGColor: .constant(.red), tempPhotoColor: .constant(.yellow), tempMessageColor: .constant(.blue))
        .environmentObject(ChatAppearanceViewModel())
}

enum TypeOfColor {
    case backgroundClr
    case photoClr
    case messageClr
}
