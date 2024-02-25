//
//  reButtonStyle.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .fontWeight(.bold)
            .foregroundStyle(Palette.selectionColor.render)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor)
            )
    }
}

#Preview {
    Button("Save And Destroy") { }
        .frame(maxWidth: .infinity)
    .buttonStyle(reButtonStyle())
}
