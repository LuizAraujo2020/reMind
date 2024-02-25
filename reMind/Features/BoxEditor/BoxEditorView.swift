//
//  BoxEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxEditorView: View {
    @State var name: String
    @State var keywords: String
    @State var description: String
    @State var theme: Int

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(
                    text: $name,
                    title: "Name"
                )

                reTextField(
                    text: $keywords,
                    title: "Keywords",
                    caption: "Separated by , (comma)"

                )

                reTextEditor(text: $description, title: "Description")

                reRadionButtonGroup(currentSelection: $theme, title: "Theme")

                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        print("Cancel")
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Salve")
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    BoxEditorView(name: "Asdf", keywords: "asdads, asdasd", description: "Description", theme: 0)
}
