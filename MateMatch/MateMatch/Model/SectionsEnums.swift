//
//  SectionsModel.swift
//  MateMatch
//
//  Created by Никита Котов on 21.02.2024.
//

import Foundation

enum SocialNetwork: String, CaseIterable {
    case email = "Email"
    case vk = "Вконтакте"
    case apple = "Apple"
    case google = "Google"
    
    var icon: String {
        switch self {
        case .email: return "email"
        case .vk: return "vk"
        case .apple: return "apple"
        case .google: return "google"
        }
    }
}

enum PushNotifications: String, CaseIterable {
    case newRequests = "Новые заявки"
    case newMatch = "Новый Match"
    case newMessage = "Сообщения в чате"
    case inviteLink = "Действия с Invite ссылкой"
    case appUpdate = "Обновления Amaze"
    
    var description: String {
        switch self {
            case .newRequests: return "Тебе поставили лайк"
            case .newMatch: return "Найден напарник"
            case .newMessage: return "Пришло новое сообщение"
            case .inviteLink: return "Переход по твоей ссылке"
            case .appUpdate: return "Доступна новая версия \nприложения"
        }
    }
}

enum AppLanguage: String, CaseIterable {
    case russian = "Русский"
    case english = "English"
    
    var icon: String {
        switch self {
            case .russian: return "russian-flag"
            case .english: return "usa-flag"
        }
    }
}

enum FAQ: String, CaseIterable {
    case manual = "Руководство по использованию"
    case logSignUP = "Регистрация и учетная запись"
    case meeting = "Знакомства"
}

enum MainSections: String, CaseIterable {
    case name = "Имя"
    case birthday = "Дата рождения"
    case gender = "Пол"
    
    var icon: String {
        switch self {
            case .name: return "person.2"
            case .birthday: return "gift"
            case .gender: return "figure.2"
        }
    }
}

enum ApplicationSections: String, CaseIterable {
    case loginMethods = "Способы входа"
    case notifications = "Уведомления"
    case chats = "Чаты"
    case language = "Язык"
    case blackList = "Черный список"
    case FAQ = "FAQ"
    case feedbackOfError = "Сообщить о проблеме"
    case exit = "Выйти"
    
    var icon: String {
        switch self {
            case .loginMethods: return "person.2"
            case .notifications: return "bell"
            case .chats: return "ellipsis.message"
            case .language: return "network"
            case .blackList: return "lock"
            case .FAQ: return "questionmark.circle"
            case .feedbackOfError: return "exclamationmark.bubble"
            case .exit: return "rectangle.portrait.and.arrow.right"
        }
    }
}
