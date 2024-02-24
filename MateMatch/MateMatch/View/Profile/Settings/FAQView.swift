//
//  FAQView.swift
//  MateMatch
//
//  Created by Никита Котов on 20.02.2024.
//

import SwiftUI

struct FAQView: View {
    @Binding var path: [String]
    
    @EnvironmentObject var sections: SectionsViewModel
    
    var body: some View {
        VStack {
            switch sections.selectedFAQSection {
                case .manual:
                    manual
                case .logSignUP:
                    signLogUp
                case .meeting:
                    meeting
            }
        }
        .padding(.top, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.bgColor)
        .overlay(header)
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    path.removeAll(where: { $0 == "FAQ" })
                }
            
            Spacer()
        }
        .padding(.top, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        }
    }
    
    var manual: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(sections.selectedFAQSection.rawValue)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                    .frame(width: 200)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(sections.manualSection) { section in
                        VStack(alignment: .leading, spacing: 5) {
                            Button {
                                withAnimation(.spring) {
                                    self.sections.manualSection[sectionIndex(section: section, dataModel: 1)].expanded.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(section.name)
                                        .font(.system(size: 16, weight: .light))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(width: 30, alignment: .center)
                                        .rotationEffect(.degrees(section.expanded ? -180 : 0))
                                }
                                .padding(.vertical, 10)
                            }
                            .foregroundStyle(.black)
                            
                            VStack {
                                Text(section.description)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .padding(.bottom, 10)
                                    .lineSpacing(5)
                                    .animation(section.expanded ? .none : .linear(duration: 60), value: section.expanded)
                            }
                            .frame(height: section.expanded ? nil : 0, alignment: .bottom)
                            .clipped()
                 
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .frame(height: 0.5)
                                .padding(.horizontal, -15)
                                .opacity(section.name.contains("Под") ? 0 : 1)
                        }
                        .onDisappear {
                            self.sections.manualSection[sectionIndex(section: section, dataModel: 1)].expanded = false
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    var signLogUp: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(sections.selectedFAQSection.rawValue)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                    .frame(width: 200, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(sections.signLogUp) { section in
                        VStack(alignment: .leading, spacing: 5) {
                            Button {
                                withAnimation(.spring) {
                                    self.sections.signLogUp[sectionIndex(section: section, dataModel: 2)].expanded.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(section.name)
                                        .font(.system(size: 16, weight: .light))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(width: 30, alignment: .center)
                                        .rotationEffect(.degrees(section.expanded ? -180 : 0))
                                }
                                .padding(.vertical, 10)
                            }
                            .foregroundStyle(.black)
                            
                            VStack {
                                Text(section.description)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .padding(.bottom, 10)
                                    .lineSpacing(5)
                                    .animation(section.expanded ? .none : .linear(duration: 60), value: section.expanded)
                            }
                            .frame(height: section.expanded ? nil : 0, alignment: .bottom)
                            .clipped()
                            
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .frame(height: 0.5)
                                .padding(.horizontal, -15)
                                .opacity(section.name.contains("ID") ? 0 : 1)
                        }
                        .onDisappear {
                            self.sections.signLogUp[sectionIndex(section: section, dataModel: 2)].expanded = false
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    var meeting: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(sections.selectedFAQSection.rawValue)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                    .frame(width: 200, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(sections.meeting) { section in
                        VStack(alignment: .leading, spacing: 5) {
                            Button {
                                withAnimation(.spring) {
                                    self.sections.meeting[sectionIndex(section: section, dataModel: 3)].expanded.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(section.name)
                                        .font(.system(size: 16, weight: .light))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(width: 30, alignment: .center)
                                        .rotationEffect(.degrees(section.expanded ? -180 : 0))
                                }
                                .padding(.vertical, 10)
                            }
                            .foregroundStyle(.black)
                            
                            VStack {
                                Text(section.description)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .padding(.bottom, 10)
                                    .lineSpacing(5)
                                    .animation(section.expanded ? .none : .linear(duration: 60), value: section.expanded)
                            }
                            .frame(height: section.expanded ? nil : 0, alignment: .bottom)
                            .clipped()
                 
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .frame(height: 0.5)
                                .padding(.horizontal, -15)
                                .opacity(section.name.contains("Отправка") ? 0 : 1)
                        }
                        .onDisappear {
                            self.sections.meeting[sectionIndex(section: section, dataModel: 3)].expanded = false
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    func sectionIndex(section: SectionDataModel, dataModel: Int) -> Int {
        switch dataModel {
            case 1: return sections.manualSection.firstIndex(where: { $0.name == section.name })!
            case 2: return sections.signLogUp.firstIndex(where: { $0.name == section.name })!
            case 3: return sections.meeting.firstIndex(where: { $0.name == section.name })!
            
            default:
                return 0
        }
    }
}

#Preview {
    FAQView(path: .constant([]))
}
