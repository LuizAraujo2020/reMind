//
//  BoxView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxView: View {
    @ObservedObject var box: Box

    @State private var isEditingBox = false
    @State private var isCreatingTerm = false
    @State private var searchText: String = ""


    var termsToReview: [Term]
    let createTerm: (_ termAux: TermAux) -> Void

    private var filteredTerms: [Term] {
        let termsSet = box.terms as? Set<Term> ?? []
        let terms = Array(termsSet).sorted { lhs, rhs in
            (lhs.value) < (rhs.value)
        }

        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { ($0.value).contains(searchText) }
        }
    }

    var body: some View {
        List {
            TodaysCardView(numberOfPendingCards: termsToReview.count,
                           theme: reTheme(rawValue: box.rawTheme) ?? .aquamarine)
            Section {
                ForEach(filteredTerms, id: \.self) { term in
                    NavigationLink {
                        SwipperView(
                            review: SwipeReview(termsToReview: termsToReview, termsReviewed: [])
                        )

                    } label: {
                        Text("\(term.isPending ? "->" : "") \(term.value)")
                            .padding(.vertical, 8)
                            .fontWeight(.bold)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    print("delete")
                                    term.destroy()
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }

                }
            } header: {
                Text("All Cards")
                    .textCase(.none)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Palette.label.render)
                    .padding(.leading, -16)
                    .padding(.bottom, 16)
            }

        }
        .scrollContentBackground(.hidden)
        .background(reBackground())
        .navigationTitle(box.name)
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    print("edit")
                    isEditingBox = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }

                Button {
                    print("add")
                    isCreatingTerm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isEditingBox) {
            BoxEditorView(box: box)
        }
        .sheet(isPresented: $isCreatingTerm) {
            TermEditorView(
                term: "",
                meaning: "",
                boxID: box.identifier,
                createTerm: createTerm
            )
        }
    }
}

struct BoxView_Previews: PreviewProvider {
    static let box: Box = {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.name = "Box 1"
        box.rawTheme = 0
        BoxView_Previews.terms.forEach { term in
            box.addToTerms(term)
        }
        return box
    }()

    static let terms: [Term] = {
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Term 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"

        return [term1, term2, term3]
    }()

    static var previews: some View {
        NavigationStack {
            BoxView(
                box: BoxView_Previews.box,
                termsToReview: [],
                createTerm: { _ in })
        }
    }
}
