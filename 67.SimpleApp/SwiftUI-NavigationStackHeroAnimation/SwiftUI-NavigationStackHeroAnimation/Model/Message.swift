//
//  Message.swift
//  SwiftUI-NavigationStackHeroAnimation
//
//  Created by Cain on 2024/11/25.
//

import SwiftUI

struct Message: Identifiable {
    var id: UUID = .init()
    var message: String
    var isReply: Bool = false
}

let messages: [Message] = [
    .init(message: text1),
    .init(message: text2, isReply: true),
    .init(message: text3),
    .init(message: text4),
    .init(message: text5, isReply: true),
    .init(message: text6),
    .init(message: text7),
    .init(message: text3, isReply: true),
    .init(message: text1),
    .init(message: text2, isReply: true),
    .init(message: text5),
    .init(message: text7, isReply: true),
    .init(message: text6),
    .init(message: text1),
    .init(message: text2, isReply: true),
    .init(message: text3),
    .init(message: text4),
    .init(message: text5, isReply: true),
    .init(message: text6),
    .init(message: text7)
]

var text1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
var text2 = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
var text3 = "When an unknown printer took a galley of type and scrambled it to make a type specimen book."
var text4 = "It hassurvived not only five centuries, but also the leap into electronic typesetting."
var text5 = "Contraty to popular belief, Lorem Ipsum is not simply random text."
var text6 = "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 yers old."
var text7 = "It is a long established fact that a reader will be distracted by the readble content of a page when looking at its layout."

/// 1. The message model and data are used to create a dummy message scroll view in the detail view. The Profile model and profile data are used to create the Home Screen list view.
