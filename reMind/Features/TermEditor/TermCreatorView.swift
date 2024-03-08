//
//  TermCreatorView.swift
//  reMind
//
//  Created by Luiz Araujo on 27/02/24.
// 

import SwiftUI

struct TermCreatorView: View {
    @Environment(\.dismiss) var dismiss

    @State var term: String
    @State var meaning: String

    @State private var errorMessage: String?
    @State private var termField = false
    @State private var meaningField = false

    var boxID: UUID

    let createTerm: (TermAux) -> Void

    var validation = TextValidation()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(text: $term, title: "Term")
                    .modifier(ErrorHighlightModifier(show: $termField))

                reTextField(text: $meaning, title: "Meaning")
                    .modifier(ErrorHighlightModifier(show: $meaningField))

                Spacer()

                if let errorMessage {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundStyle(Palette.selectionColor.render)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.accentColor.opacity(0.5))
                        )
                }

                Spacer()

                Button {
                    guard validateFields() else { return }
                    print("Save and Add New")

                    DispatchQueue.global().async {
                        createTerm(TermAux(boxID: boxID, meaning: meaning, term: term))

                        term = ""
                        meaning = ""
                    }

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
                        guard validateFields() else { return }
                        createTerm(TermAux(boxID: boxID, meaning: meaning, term: term))
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }

    private func validateFields() -> Bool {

        do {
            termField = true
            try validation.isntEmpty(term)
            try validation.maxSize(term, 50)
            termField = false
            meaningField = true
            try validation.maxSize(meaning, 150)
            meaningField = false

            errorMessage = nil

            return true
        } catch let error as TextValidationError {
            errorMessage = """
                            Error:
                            \(error.localizedDescription)
                            """
            return false

        } catch {
            print("asdasd")
            return false
        }
    }
}

#Preview {
    TermCreatorView(term: "", meaning: "", boxID: UUID()) { _ in }
}
