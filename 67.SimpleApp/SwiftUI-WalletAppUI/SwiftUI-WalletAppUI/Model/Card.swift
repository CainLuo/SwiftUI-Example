//
//  Card.swift
//  SwiftUI-WalletAppUI
//
//  Created by Cain on 2024/12/6.
//

import SwiftUI

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var number: String
    var expires: String
    var color: Color
    
    /// Custom Matched Geometry IDs
    var visaGeometryID: String {
        "VISA_\(id)"
    }
}

var cards: [Card] = [
    .init(number: "**** **** **** 1234", expires: "02/27", color: .blue),
    .init(number: "**** **** **** 5678", expires: "06/24", color: .indigo),
    .init(number: "**** **** **** 9648", expires: "06/24", color: .pink),
    .init(number: "**** **** **** 9876", expires: "01/29", color: .black)
]
