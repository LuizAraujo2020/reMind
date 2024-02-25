//
//  TermEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct TermEditorView: View {
    @State var term: String
    @State var meaning: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(text: $term, title: "Term")

                reTextField(text: $meaning, title: "Meaning")

                Spacer()

                Button {
                    print("Save and Add New")

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
    TermEditorView(term: "", meaning: "")
}
