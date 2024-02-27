//
//  TestView.swift
//  MateMatch
//
//  Created by Никита Котов on 26.02.2024.
//

import SwiftUI

struct TestView: View {
    
    @State private var mate = MOCK_MATE[0]
    
    @State private var currentPhoto: Int = 0
    @State private var fakedPhoto: [Photo] = []
    
    var body: some View {
        VStack {
            ZStack {
                
            }
            .onAppear {
                
                guard fakedPhoto.isEmpty else { return }
                
                fakedPhoto.append(contentsOf: mate.avatar)
                
                print(fakedPhoto)
            }
            
            TabView(selection: $currentPhoto) {
                ForEach(0...fakedPhoto.count, id: \.self) { index in
                    Image(mate.avatar[index].name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250)
                        .tag(index)
                        .clipShape(Rectangle())
                }
            }
            .tabViewStyle(.page)
            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250)
            
            Button {
                currentPhoto += 1
            } label: {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    }
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TestView()
}
