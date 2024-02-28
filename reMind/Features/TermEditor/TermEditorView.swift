//
//  TermEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct TermEditorView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var term: Term
    @State var value: String
    @State var meaning: String
//    var boxID: UUID
//
//    let editTerm: (TermAux) -> Void
//    let editTerm: (String, String) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(text: $value, title: "Term")

                reTextField(text: $meaning, title: "Meaning")

                Spacer()

                Button {
                    print("Save and Add New")

                    DispatchQueue.global().async {
//                        editTerm(value, meaning)
//                        createTerm(TermAux(boxID: <#T##UUID#>, meaning: <#T##String#>, term: <#T##String#>)
//                        term.value = value
//                        term.meaning = meaning
//
                        term.setValue(value, forKey: "value")
                        term.setValue(meaning, forKey: "meaning")
                    }

//                    term = ""
//                    meaning = ""

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
//                        editTerm(TermAux(boxID: boxID, meaning: meaning, term: term))
//                        term.mutableSetValue(forKey: "value").add(value)
//                        term.mutableSetValue(forKey: "meaning").add(meaning)
//                        term.value = value
//                        term.meaning = meaning
                        term.setValue(value, forKey: "value")
                        term.setValue(meaning, forKey: "meaning")

//                        editTerm(value, meaning)
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
//    TermEditorView(value: "", meaning: "") { _, _ in }
//    TermEditorView(term: BoxView_Previews.terms[0], value: "", meaning: "")
    TermEditorView(term: BoxView_Previews.terms[0], value: "", meaning: "")
}
