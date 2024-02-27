//
//  BoxEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxEditorView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var box: Box

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
            .navigationTitle("Editing Box")
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
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    let box: Box = {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.name = "Box 1"
        box.rawTheme = 0
        BoxView_Previews.terms.forEach { term in
            box.addToTerms(term)
        }
        return box
    }()

    let terms: [Term] = {
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Term 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"

        return [term1, term2, term3]
    }()

    return BoxEditorView(box: BoxView_Previews.box)
}
