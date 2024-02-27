//
//  NotificationView.swift
//  MateMatch
//
//  Created by Никита Котов on 27.02.2024.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    
    @State private var tempToggle: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack {
            if userVM.userPermissionsDenied {
                notificationMessage
            }
            placeholder
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.bgColor)
        .safeAreaInset(edge: .top) {
            Rectangle()
                .fill(.clear)
                .frame(height: 50)
                .ignoresSafeArea()
        }
        .onAppear {
            checkNotifications()
        }
        .overlay(header)
        .onChange(of: tempToggle) { oldValue, newValue in
            if userVM.userPermissionsDenied {
                if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings)
                }
            }
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            switch scenePhase {
                case .active: checkNotifications()
                default: break
            }
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding(.leading)
                .onTapGesture {
                    dismiss()
                }
            
            Spacer()

            
            Text("Уведомления")
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
    
    var placeholder: some View {
        VStack(spacing: 20) {
            Image(systemName: "bell.and.waves.left.and.right")
                .font(.system(size: 22))
                .foregroundStyle(.black.opacity(0.2))
                .background {
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .frame(width: 60, height: 60)
                }
                .padding()
                .padding(.bottom, 10)
            
            Text("Нет уведомлений")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.black)
            
            Text("Здесь будут появляться\nуведомления")
                .font(.system(size: 18))
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    var notificationMessage: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Уведомления выключены")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text("Включи уведомления на устройстве,\nчтобы не пропустить ничего важного")
                    .font(.system(size: 14))
                    .foregroundStyle(.black.opacity(0.5))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            
            Spacer()
            
            Toggle(isOn: $tempToggle) {
                
            }
            .tint(Color.green)
            .frame(width: 50)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
        .background(.white)
    }
    
    func checkNotifications() {
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if !success {
                    self.userVM.userPermissionsDenied = true
                    self.tempToggle = false
                } else if let error {
                    print(error.localizedDescription)
                } else if success {
                    self.userVM.userPermissionsDenied = false
                    self.tempToggle = false
                }
            }
        }
    }
}

#Preview {
    NotificationView()
}
