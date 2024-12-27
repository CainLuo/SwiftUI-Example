//
//  TabModel.swift
//  SwiftUI-MailTabBar
//
//  Created by Cain on 2024/11/21.
//

import SwiftUI

/// 1.Let's begin constructing the custom tab bar.

/// 2.This is an exact replica of the iOS 18.1 Mail app tab model.
enum TabModel: String, CaseIterable {
    case primary = "Primary"
    case transactions = "Transactions"
    case update = "Update"
    case promotions = "Promotions"
    case allMails = "All Mails"
    
    var color: Color {
        switch self {
        case .primary: .blue
        case .transactions: .green
        case .update: .indigo
        case .promotions: .pink
        case .allMails: Color.primary
        }
    }

    var symbolImage: String {
        switch self {
        case .primary: "person"
        case .transactions: "cart"
        case .update: "text.bubble"
        case .promotions: "megaphone"
        case .allMails: "tray"
        }
    }
}
