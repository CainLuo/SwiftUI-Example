//
//  Profile.swift
//  SwiftUI-NavigationStackHeroAnimation
//
//  Created by Cain on 2024/11/25.
//

import SwiftUI

struct Profile: Identifiable, Hashable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
}

/// Smaple Profile Data
var profiles = [
    Profile(userName: "iJustine", profilePicture: "square.and.arrow.up.circle.fill", lastMsg: "Hi Kavsoft !!!"),
    Profile(userName: "Jenna Ezarik", profilePicture: "pencil.circle.fill", lastMsg: "Nothing!"),
    Profile(userName: "Emily", profilePicture: "eraser.fill", lastMsg: "Binge Watching 😄"),
    Profile(userName: "Julie", profilePicture: "folder.fill", lastMsg: "404 Page not Found 😭"),
    Profile(userName: "Kaviya", profilePicture: "waveform.path.ecg.text.page.fill", lastMsg: "Do not Disturb."),
]
