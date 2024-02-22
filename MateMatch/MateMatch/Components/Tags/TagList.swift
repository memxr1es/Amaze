//
//  TagList.swift
//  MateMatch
//
//  Created by Никита Котов on 05.02.2024.
//

import SwiftUI

struct TagList: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedTags: [Tags]
    
    // Matched Geometry Effect
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            
            selectedTagView
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .overlay {
                    if selectedTags.isEmpty {
                        Text("Выберите более 2х тегов")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    }
                }
                .background(.white)
                .zIndex(1)
            
            tagListView
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .background(.black.opacity(0.05))
                .zIndex(0)
            
            acceptButton
        }
        .overlay {
            closeButton
        }
    }
    
    var selectedTagView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(selectedTags, id: \.self) { tag in
                    listTag(tag.rawValue, Color(#colorLiteral(red: 0, green: 0.7045553327, blue: 0.6918279529, alpha: 1)), "checkmark")
                        .matchedGeometryEffect(id: tag, in: animation)
                    // Removing from Selected List
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedTags.removeAll(where: {$0 == tag})
                            }
                        }
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 30)
            .padding(.top, 30)
            .padding(.bottom, 10)
            
        }
    }
    
    var tagListView: some View {
        ScrollView(.vertical) {
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(Tags.allCases.filter{ !selectedTags.contains($0)}, id: \.self) { tag in
                    listTag(tag.rawValue, Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)), "plus")
                        .matchedGeometryEffect(id: tag, in: animation)
                        .onTapGesture {
                            // Adding to Selected Tag List
                            withAnimation(.snappy) {
                                selectedTags.insert(tag, at: 0)
                            }
                        }
                }
            }
            .padding(15)
        }
        .background(Color.theme.bgColor)
    }
    
    var acceptButton: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                Text("Применить")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
            }
            .disabled(selectedTags.count <  2 ? true : false)
            .opacity(selectedTags.count < 2 ? 0.7 : 1)
            .padding()
        }
        .background(.white)
    }
    
    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 18))
                .foregroundStyle(Color(#colorLiteral(red: 0.3365147114, green: 0.3369267881, blue: 0.3494216204, alpha: 1)))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .buttonStyle(PressEffectButtonStyle_Close())
    }
    
    @ViewBuilder
    func listTag(_ tag: String, _ color: Color, _ icon: String) -> some View {
        HStack {
            Text(tag)
            
            Image(systemName: icon)
        }
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .fixedSize()
        .foregroundStyle(.white.opacity(1))
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(color.opacity(0.5))
        }
    }
}

struct PressEffectButtonStyle_Close: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)        
    }
}

#Preview {
    TagList(selectedTags: .constant([.apexLegends]))
}
