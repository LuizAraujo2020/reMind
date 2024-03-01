//
//  BoxView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxView: View {
    @ObservedObject var box: Box
    @Binding var terms: [Term]

    @State private var isEditingBox = false
    @State private var isEditingTerm = false
    @State private var isCreatingTerm = false
    @State private var searchText: String = ""
    @State private var termIndex = 0

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
        VStack {
            TodaysCardView(
                terms: $terms,
//                numberOfPendingCards: termsToReview.count,
                theme: reTheme(rawValue: box.rawTheme) ?? .aquamarine)
            .onAppear {
                let termsSet = box.terms as? Set<Term> ?? []
                let aux = Array(termsSet).sorted { lhs, rhs in
                    (lhs.value) < (rhs.value)
                }

                terms = aux
            }
            .padding(.horizontal)

            List {
                Section {
                    ForEach(terms.indices, id: \.self) { index in
                        NavigationLink {
                            SwipperView(review: SwipeReview(termsToReview: [terms[index]], termsReviewed: []))

                        } label: {
                            Text("\(terms[index].value)")
                                .padding(.vertical, 8)
                                .fontWeight(terms[index].isPending ? .bold : .regular)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        print("delete")
                                        terms[index].destroy()
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        print("edit term")
                                        isEditingTerm = true
                                        termIndex = index
                                    } label: {
                                        //                                    ZStack {
                                        //                                        Rectangle()
                                        Image(systemName: "square.and.pencil")
                                        //                                    }
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
        }
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
            TermCreatorView(
                term: "",
                meaning: "",
                boxID: box.identifier,
                createTerm: createTerm
            )
        }
        .sheet(isPresented: $isEditingTerm) {
            TermEditorView(
                term: terms[termIndex],
////            TermEditorView(
                value: terms[termIndex].value,
                meaning: terms[termIndex].meaning
////                boxID: box.identifier,
////                editTerm: viewModel.editTerm
            )
//                term: filteredTerms[termIndex],
//                value: terms[termIndex].value,
//                meaning: terms[termIndex].meaning
//            ) { value, meaning in
//                terms[termIndex].setValue(value, forKey: "value")
//                terms[termIndex].setValue(meaning, forKey: "meaning")
//            }
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
                terms: .constant([]),
                termsToReview: [],
                createTerm: { _ in })
        }
    }
}
