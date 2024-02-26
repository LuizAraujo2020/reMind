//
//  reRadionButtonGroup.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reRadionButtonGroup: View {
    @Binding var currentSelection: Int

    @State var title: String? = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let title {
                Text(title)
                    .font(.body)
                    .bold()
            }

            HStack(spacing: 20) {
                ForEach(reTheme.allCases, id: \.self) { theme in
                    reRadioButton(
                        currentSelection: $currentSelection,
                        tag: theme.rawValue,
                        color: theme.render
                    )
                }
//                reRadioButton(
//                    currentSelection: $currentSelection,
//                    tag: 0,
//                    color: Palette.mauve.render
//                )
//                reRadioButton(
//                    currentSelection: $currentSelection,
//                    tag: 1,
//                    color: Palette.lavender.render
//                )
//                reRadioButton(
//                    currentSelection: $currentSelection,
//                    tag: 2,
//                    color: Palette.aquamarine.render
//                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    reRadionButtonGroup(currentSelection: .constant(0), title: "Theme")
}
