//
//  TermEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct TermEditorView: View {
    @Environment(\.dismiss) var dismiss

    @State var term: String
    @State var meaning: String
    var boxID: UUID

    let createTerm: (TermAux) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(text: $term, title: "Term")

                reTextField(text: $meaning, title: "Meaning")

                Spacer()

                Button {
                    print("Save and Add New")

                    DispatchQueue.global().async {
                        createTerm(TermAux(boxID: boxID, meaning: meaning, term: term))
//                        createTerm(TermAux(boxID: <#T##UUID#>, meaning: <#T##String#>, term: <#T##String#>)
                    }

                    term = ""
                    meaning = ""

                } label: {
                    Text("Save and Add New")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                        print("Cancel")
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        createTerm(TermAux(boxID: boxID, meaning: meaning, term: term))
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    TermEditorView(term: "", meaning: "", boxID: UUID()) { _ in }
}
