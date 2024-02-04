//
//  ImageModel.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct ImageModel: Codable, Identifiable {
    var id: String
    var download_url: String
    var onHover: Bool? // optional not for JSON...
}
