//
//  reColorButtonStyle.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct reColorButtonStyle: ButtonStyle {
    @State var theme: reTheme
    
    init(_ theme: reTheme) {
        self.theme = theme
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(Palette.reBlack.render)
            .frame(height: 48)
            .background {
                Rectangle()
                    .fill(theme.render)
                    .cornerRadius(10)
            }
    }
}
