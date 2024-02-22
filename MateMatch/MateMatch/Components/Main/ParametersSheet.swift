//
//  ParametersSheet.swift
//  MateMatch
//
//  Created by Никита Котов on 04.02.2024.
//

import SwiftUI

struct ParametersSheet: View {
    
    @Binding var showParametersSheet: Bool
    
    // For Double Slider
    @State var width: CGFloat = 0
    @State var widthTow: CGFloat = 20
    
    let offsetValue: CGFloat = 30
    
    @State var totalScreen: CGFloat = 0
    
    let maxValue: CGFloat = 62
    
    @State var isDraggingLeft: Bool = false
    @State var isDraggingRight: Bool = false
    
    @State var showSheet: Bool = false
    
    @State var selectedTags: [Tags] = []
    
    var lowerValue: Int {
        Int(map(value: width, from: 0...totalScreen, to: 0...maxValue)) + 18
    }
    
    var upperValue: Int {
        Int(map(value: widthTow, from: 0...totalScreen, to: 0...maxValue)) + 18
    }
    
    var tracGradient: LinearGradient = LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.7045553327, blue: 0.6918279529, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6746062636, blue: 0.6556300521, alpha: 1))], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Фильтры")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
            
            GenderChoice()
                .padding(.horizontal, -5)
            
            tagChoice
            
            age
            
            buttonAccept
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .fullScreenCover(isPresented: $showSheet) {
            TagList(selectedTags: $selectedTags)
        }
        .background(.white)
    }
    
    var tagChoice: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Игр выбрано:")
                
                Spacer()
                
                Text("\(selectedTags.count)")
                    .underline(color: .gray.opacity(0.5))
            }
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
            .onTapGesture {
                showSheet.toggle()
            }

        }
        .padding()
    }
    
    var customSlider: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.gray)
                    .frame(height: 2)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(tracGradient)
                    .frame(width: widthTow - width, height: 2)
                    .offset(x: width + 20)
                
                HStack(spacing: 0) {
                    DraggableCircle(isLeft: true, isDragging: $isDraggingLeft, position: $width, otherPosition: $widthTow, limit: totalScreen)
                    DraggableCircle(isLeft: false, isDragging: $isDraggingRight, position: $widthTow, otherPosition: $width, limit: totalScreen)
                }
            }
            .onAppear {
                totalScreen = geometry.size.width - offsetValue
            }
        }
        .frame(height: 50)
    }
    
    var age: some View {
        VStack {
            HStack {
                Text("Возраст:")
                
                Spacer()
                
                Text("\(lowerValue) - \(upperValue) лет")
            }
            .font(.system(size: 16))
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))
            
            customSlider
                .padding(.horizontal, 40)
        }
    }
    
    var buttonAccept: some View {
        Button {
            showParametersSheet = false
        } label: {
            Text("Применить")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 170, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                }
        }
    }
    
    func map(value: CGFloat, from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let inputRange = from.upperBound - from.lowerBound
        guard inputRange != 0 else { return 0 }
        let outputRange = to.upperBound - to.lowerBound
        return (value - from.lowerBound) / inputRange * outputRange + to.lowerBound
    }
}

#Preview {
    ParametersSheet(showParametersSheet: .constant(true))
}

struct DraggableCircle: View {
    var isLeft: Bool
    @Binding var isDragging: Bool
    @Binding var position: CGFloat
    @Binding var otherPosition: CGFloat
    var limit: CGFloat
    var gradient: LinearGradient = LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.7045553327, blue: 0.6918279529, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    @State var tapped: Bool = false
    
    var body: some View {
        ZStack {
            Circle().frame(width: 20, height: 20).foregroundStyle(gradient).shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            Circle().frame(width: 12, height: 12).foregroundStyle(.white)
        }
        .scaleEffect(tapped ? 1.15 : 1)
        .offset(x: position + (isLeft ? 0 : -5))
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        isDragging = true
                        tapped = true
                    }
                    
                    if isLeft {
                        position = min(max(value.location.x, 0), otherPosition)
                    } else {
                        position = min(max(value.location.x, otherPosition), limit)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        isDragging = false
                        tapped = false
                    }
                }
        )
    }
}
