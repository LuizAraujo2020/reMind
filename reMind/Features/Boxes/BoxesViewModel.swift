//
//  BoxesViewModel.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation
import CoreData

final class BoxesViewModel: ObservableObject {
    @Published var boxes = [Box]()

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
        boxes = Box.all().sorted(by: { l, r in
            l.name < r.name
        })
    }

    func getNumberOfPendingTerms(of box: Box) -> Int? {
        let today = Date()
        let term = box.terms as? Set<Term> ?? []
        let filteredTerms = term.filter { term in
            let srs = Int(term.rawSRS)
            guard let nextReview = Calendar.current.date(byAdding: .day, value: srs, to: term.lastReview)
            else { return false }

            return nextReview <= today
        }
        return filteredTerms.count <= 0 ? nil : filteredTerms.count
    }

    // MARK: - Box
    func createNewBox(_ boxAux: BoxAux) {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.identifier = boxAux.id
        box.name = boxAux.name
        box.rawTheme = Int16(boxAux.rawTheme)
        box.descriptions = boxAux.descriptions
        box.keywords = boxAux.keywords

        boxes = Box.all()
    }


    // MARK: - Term
    func createTerm(_ termAux: TermAux) {
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.value = termAux.value
        term.meaning = termAux.meaning

        boxes.forEach { box in
            if box.identifier == termAux.boxID {
                term.boxID = box
//                box.addToTerms(term)
            }
        }
    }
}
