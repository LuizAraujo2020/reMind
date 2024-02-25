//
//  reTextField.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reTextField: View {
    @Binding var text: String

    @State var title: String?
    @State var caption: String?

    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
            }

            TextField("Text", text: $text)
                .textFieldStyle(reTextFieldStyle())

            if let caption {
                Text(caption)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.leading, 8)
            }
        }
        .foregroundColor(Palette.label.render)
    }
}

#Preview {
    reTextField(text: .constant("Text"), title: "Bla", caption: "Blabla")
        .padding()
}
