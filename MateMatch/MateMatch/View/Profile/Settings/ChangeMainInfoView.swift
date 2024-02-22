//
//  ChangeMainInfoView.swift
//  MateMatch
//
//  Created by Никита Котов on 19.02.2024.
//

import SwiftUI

struct ChangeMainInfoView: View {
    @State private var newValue: String = ""
    @State private var newValueDate: Date = Date.now
    @State private var selectedGender: Genders = .female
    @State private var showClearButton: Bool = true
    @State private var showDatePicker: Bool = false
    
    @FocusState private var isFocused: Bool
    @State private var isFocus: Bool = false
    
    @State private var isToggled: Bool = false
    
    @Binding var path: [String]
    
    @EnvironmentObject var sections: SectionsViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        ZStack {
            VStack {
                switch sections.selectedSection {
                    case .name:
                        sectionName
                    case .birthday:
                        sectionBirthday
                    case .gender:
                        sectionGender
                }
                
                PayAttention(section: sections.selectedSection)
                
                Spacer()
                
                confirmCheckBox
                confirmationButton
            }
            .padding(.top, 60)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.theme.bgColor)
            .overlay(header)
            .onChange(of: newValue) { oldValue, newValue in
                showClearButton = !newValue.isEmpty
            }
            .disabled(showDatePicker)
            .overlay {
                Rectangle()
                    .fill(showDatePicker ? .black.opacity(0.5) : .clear)
                    .ignoresSafeArea()
            }
            .onTapGesture {
                withAnimation { showDatePicker = false }
            }
            .sheet(isPresented: $showDatePicker) {
                CarouselCalendar(currentDate: $newValue, currentDateUser: $newValueDate, showDatePicker: $showDatePicker)
                    .padding(.top, 40)
                    .presentationDetents([.fraction(0.3)])
            }
        }
        .onAppear {
            newValue = sections.selectedSection == .name ? userVM.user.firstName : (sections.selectedSection == .birthday ? shortDate(userVM.user.birthDay) : userVM.user.gender.rawValue)
            selectedGender = userVM.user.gender
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    path.removeAll(where: { $0 == "Main Section" })
                }
            
            Spacer()

            
            Text(sections.selectedSection.rawValue)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.leading, -20)
            
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
    
    var sectionName: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(sections.selectedSection.rawValue)
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(.black.opacity(0.65))
            
            TextField(text: $newValue, prompt: Text(sections.selectedSection.rawValue).font(.system(size: 18))) {
                EmptyView()
            }
            .foregroundStyle(.black)
            .focused($isFocused)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isFocus ? .black : .gray, lineWidth: 1)
            }
            .tint(.black)
            .overlay {
                clearButton
            }
        }
        .onChange(of: isFocused, { oldValue, newValue in
            withAnimation(.linear(duration: 0.1)) {
                isFocus.toggle()
            }
        })
        .padding()
    }
    
    var sectionBirthday: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(sections.selectedSection.rawValue)
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(.black.opacity(0.65))
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .overlay {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 1)
                        
                        Text(newValue)
                            .font(.system(size: 17))
                            .foregroundStyle(.black)
                            .padding(.leading)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring) { showDatePicker.toggle() }
                }
        }
        .padding()
    }
    
    var sectionGender: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(sections.selectedSection.rawValue)
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(.black.opacity(0.65))
            
            HStack {
                ForEach(Genders.allCases, id: \.self) { gender in
                    Text(gender.rawValue)
                        .font(.system(size: 18, design: .rounded))
                        .foregroundStyle(selectedGender == gender ? .white : .black.opacity(0.5))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(selectedGender == gender ? .black : .gray.opacity(0.2))
                        }
                        .onTapGesture {
                            selectedGender = gender
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var clearButton: some View {
        Image(systemName: "xmark")
            .font(.system(size: 12))
            .foregroundColor(.gray.opacity(0.7))
            .padding(5)
            .background {
                Circle()
                    .fill(.gray.opacity(0.15))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            .onTapGesture {
                newValue = ""
            }
            .opacity(showClearButton ? 1 : 0)
    }
    
    var confirmCheckBox: some View {
        HStack(alignment: .center, spacing: 0) {
            customCheckBox
                .frame(width: 45, height: 35, alignment: .top)
            
            Text("Я понимаю, что больше не смогу \nизменить этот параметр")
                .font(.system(size: 16))
                .foregroundStyle(.black.opacity(0.8))
        }
        .onTapGesture {
            isToggled.toggle()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
    
    var customCheckBox: some View {
        ZStack {
            if isToggled {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.theme.mainColor)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 21.5, height: 21.5)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.7), lineWidth: 2)
                    .frame(width: 20, height: 20)
            }
        }
    }
    
    var confirmationButton: some View {
        Button {
            switch sections.selectedSection {
                case .name:
                    userVM.user.firstName = newValue
                    print("ready#1")
                case .birthday: 
                    userVM.user.birthDay = newValueDate
                    print("ready#2")
                case .gender: 
                    userVM.user.gender = selectedGender
                    print("ready#3")
            }
        } label: {
            Text("Подтвердить")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding()
        }
        .buttonStyle(ConfirmButton(isDisabled: .constant(!(isToggled && !newValue.isEmpty))))
    }
}

struct ConfirmButton: PrimitiveButtonStyle {
    
    @Binding var isDisabled: Bool
    
    @State private var longPressed: Bool = false
    
    @GestureState var press = false
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(isDisabled ? .black.opacity(0.5) : .black)
            }
            .padding(.horizontal)
            .padding(.top)
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 100)
                    .updating($press, body: { currentState, gestureState, transaction in
                        gestureState = currentState
                    })
            )
            .onChange(of: press, { oldValue, newValue in
                withAnimation(.easeInOut) { longPressed.toggle() }
            })
            .shadow(color: longPressed ? .black.opacity(0.5) : .clear, radius: longPressed ? 8 : 0, y: longPressed ? 5 : 0)
            .simultaneousGesture(
                TapGesture().onEnded {
                    if !isDisabled {
                        configuration.trigger()
                    }
                }
            )
    }
}

#Preview {
    ChangeMainInfoView(path: .constant([]))
        .environmentObject(SectionsViewModel())
}
