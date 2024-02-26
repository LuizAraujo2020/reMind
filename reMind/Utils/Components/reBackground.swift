//
//  reBackground.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reBackground: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Palette.aquamarine.render,
                    Palette.lavender.render,
                    Palette.mauve.render
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Rectangle()
                .foregroundStyle(colorScheme == .light ?
                    .regularMaterial : .thickMaterial)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    reBackground()
}
