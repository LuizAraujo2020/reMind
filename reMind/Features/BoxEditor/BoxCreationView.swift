//
//  BoxCreationVIew.swift
//  reMind
//
//  Created by Luiz Araujo on 27/02/24.
//

import SwiftUI

struct BoxCreationView: View {
    @Environment(\.dismiss) var dismiss

    @State private var box = BoxAux()
    
    let create: (_ boxAux: BoxAux) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(
                    text: $box.name,
                    title: "Name"
                )

                reTextField(
                    text: $box.keywords,
                    title: "Keywords",
                    caption: "Separated by , (comma)"
                )

                reTextEditor(text: $box.descriptions, title: "Description")

                reRadionButtonGroup(currentSelection: $box.rawTheme, title: "Theme")

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
                        dismiss()
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Salve")
                        create(box)
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    BoxCreationView { _ in }
}
