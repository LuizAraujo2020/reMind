//
//  BoxCardView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

enum BoxTheme: String {
    case aquamarine
    case mauve
    case lavander

    var render: Color {
        Color(self.rawValue)
    }
}

struct BoxCardView: View {
    @State private var boxName: String
    @State private var numberOfTerms: Int
    @State private var theme: BoxTheme

    init(boxName: String, numberOfTerms: Int, theme: BoxTheme) {
        self.boxName = boxName
        self.numberOfTerms = numberOfTerms
        self.theme = theme
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(boxName)
                .font(.title3)
                .bold()

            Label("\(numberOfTerms) term\(getPlural())", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Palette.reBlack.render.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundStyle(Palette.reBlack.render)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(theme.render)
        .cornerRadius(10)
    }

    private func getPlural() -> String {
        numberOfTerms == 1 ? "": "s"
    }
}

#Preview {
    BoxCardView(boxName: "Box Name", numberOfTerms: 100, theme: .aquamarine)
}
