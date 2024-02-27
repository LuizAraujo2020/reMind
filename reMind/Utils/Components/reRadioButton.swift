//
//  reRadioButton.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reRadioButton: View {
    @Binding var currentSelection: Int16

    let tag: Int16
    let color: Color

    private let size = CGFloat(50)

    var body: some View {
        ZStack {
            Circle()
                .fill(color)

            if currentSelection == tag {
                Circle()
                    .fill(Palette.selectionColor.render)
                    .frame(maxWidth: 30)
            }
        }
        .frame(maxWidth: size)
        .onTapGesture {
            if currentSelection != tag {
                currentSelection = tag
            }
        }
    }
}

#Preview {
    reRadioButton(
        currentSelection: .constant(0),
        tag: 0,
        color: reTheme.mauve.render
    )
}
