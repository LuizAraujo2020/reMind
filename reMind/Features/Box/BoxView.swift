//
//  BoxView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxView: View {
    @State var boxName: String
    @State var terms: [String]
    @State var numberOfPendingTerms: Int
    
    @State var searchText = ""

    private var filteredTerms: [String] {
        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { $0.contains(searchText) }
        }
    }

    var body: some View {
        List {
            TodaysCardView(
                numberOfPendingCards: numberOfPendingTerms,
                theme: .mauve)

            Section {
                ForEach(filteredTerms, id: \.self) { term in
                    Text(term)
                        .padding(.vertical, 8)
                        .fontWeight(.bold)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                print("delete")
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            } header: {
                Text("All Cards")
                    .textCase(.none)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Palette.label.render)
                    .padding(.leading, -16)
                    .padding(.bottom, 16)
            }
        }
        .scrollContentBackground(.hidden)
        .background(reBackground())
        .navigationTitle(boxName)
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    print("edit")
                } label: {
                    Image(systemName: "square.and.pencil")
                }

                Button {
                    print("add")
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    let terms: [String] = (0...9).map { "Term \($0)" }
    return NavigationStack {
        BoxView(
            boxName: "Programming",
            terms: terms,
            numberOfPendingTerms: 10
        )
    }
}
