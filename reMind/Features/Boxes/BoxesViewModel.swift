//
//  BoxesViewModel.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation
import CoreData

@MainActor
final class BoxesViewModel: ObservableObject {
    @Published var boxes = [Box]()
    @Published var terms = [Term]()

    init() {
        mockInit()

        fetch()
    }

    private func mockInit() {
//        let terms: [Term] = {
//            let term1 = Term(context: CoreDataStack.inMemory.managedContext)
//            term1.value = "Term 1"
//            term1.rawSRS = 0
//
//            let term2 = Term(context: CoreDataStack.inMemory.managedContext)
//            term2.value = "Term 2"
//            term2.rawSRS = 0
//
//            let term3 = Term(context: CoreDataStack.inMemory.managedContext)
//            term3.value = "Term 3"
//            term3.rawSRS = 0
//
//            return [term1, term2, term3]
//        }()

        [1, 2, 3, 4, 5].forEach { val in
            let box = Box(context: CoreDataStack.inMemory.managedContext)
            box.name = "Box \(val)"
            box.identifier = UUID()
            box.rawTheme = 0
        }
    }

    func fetch() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.boxes = Box.all().sorted(by: { l, r in
                l.name < r.name
            })

            self.objectWillChange.send()
        }
    }

    func getNumberOfPendingTerms(of box: Box) -> Int? {
        let today = Date()
        let term = box.terms as? Set<Term> ?? []

        let filteredTerms = term.filter { $0.isPending }

        fetch()

        return filteredTerms.count <= 0 ? nil : filteredTerms.count
    }

    /// Gets the pendings terms
    func getPendingTerms(of box: Box) -> [Term] {
        let today = Date()
        let term = box.terms as? Set<Term> ?? []

        let filteredTerms = term.filter { $0.isPending }

        fetch()

        return Array(filteredTerms)
    }

    // MARK: - Box
    func createNewBox(_ boxAux: BoxAux) {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.identifier = boxAux.id
        box.name = boxAux.name
        box.rawTheme = Int16(boxAux.rawTheme)
        box.descriptions = boxAux.descriptions
        box.keywords = boxAux.keywords

        fetch()
    }


    // MARK: - Term
    func createTerm(_ termAux: TermAux) {
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.value = termAux.value
        term.meaning = termAux.meaning

        term.creationDate = Date()
        term.identifier = termAux.id
        term.lastReview = /*Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? */Date()

        term.rawSRS = 0

        boxes.forEach { box in
            if box.identifier == termAux.boxID {
                term.boxID = box
                box.addToTerms(term)
                term.rawTheme = box.rawTheme
            }
        }

        DispatchQueue.main.async { [weak self] in
            self?.fetch()
            self?.terms.append(term)
        }
    }
}

