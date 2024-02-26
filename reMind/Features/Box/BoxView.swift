//
//  BoxView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxAux: Identifiable {
    internal init(id: UUID = UUID(), name: String, keywords: String, descriptions: String, rawTheme: Int16, terms: [TermAux]) {
        self.id = id
        self.name = name
        self.keywords = keywords
        self.descriptions = descriptions
        self.rawTheme = Int(rawTheme)
        self.terms = terms
    }

    internal init(box: Box) {
        self.id = box.identifier ?? UUID()
        self.name = box.name ?? ""
        self.keywords = box.keywords
        self.descriptions = box.descriptions
        self.rawTheme = Int(box.rawTheme)
        self.terms = []
    }

    var id = UUID()

    var name: String
    var keywords: String
    var descriptions: String
    var rawTheme: Int
    var terms: [TermAux]
}

struct BoxView: View {
    var box: BoxAux

    @State private var isEditingBox = false
    @State private var searchText: String = ""

    let updateBox: (_ boxAux: BoxAux) -> Void

    private var filteredTerms: [TermAux] {
//        let termsSet = box.terms as? Set<TermAux> ?? []
        let terms = box.terms.sorted { lhs, rhs in
            lhs.value < rhs.value
        }

        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { ($0.value).contains(searchText) }
        }
    }

    var body: some View {
        List {
            TodaysCardView(numberOfPendingCards: 0,
                            theme: .mauve)
            Section {
                ForEach(filteredTerms, id: \.self) { term in
                    Text(term.value)
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
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isEditingBox) {
            BoxEditorView(box: box, handle: updateBox)
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
            BoxView(box: BoxAux(box: BoxView_Previews.box), updateBox: { _ in })
        }
    }
}
