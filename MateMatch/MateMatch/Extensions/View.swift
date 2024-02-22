//
//  View.swift
//  MateMatch
//
//  Created by Никита Котов on 01.02.2024.
//

import SwiftUI

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _, _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
