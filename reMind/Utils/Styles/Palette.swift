//
//  Palette.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

enum Palette: String, CaseIterable {
    case label = "label2"
    case background
    case lavander
    case aquamarine
    case mauve
    case error
    case success
    case reBlack
    case reWhite

    var render: Color {
        return Color(self.rawValue)
    }
}
