//
//  BoxesViewModel.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation

final class BoxesViewModel: ObservableObject {
    @Published var boxes = [Box]()

    init() {
        boxes = Box.all()
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

    func createNewBox(_ boxAux: BoxAux) {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.identifier = boxAux.id
        box.name = boxAux.name
        box.rawTheme = Int16(boxAux.rawTheme)
        box.descriptions = boxAux.descriptions
        box.keywords = boxAux.keywords

        boxes = Box.all()
    }

    // MARK: - Box
    func updateBox(_ boxAux: BoxAux) {
        boxes.indices.forEach { index in
            if boxes[index].identifier == boxAux.id {
                boxes[index].name = boxAux.name
                boxes[index].descriptions = boxAux.descriptions
                boxes[index].rawTheme = Int16(boxAux.rawTheme)
                boxes[index].keywords = boxAux.keywords
            }
        }

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
            }
        }

//        box.identifier = boxAux.id
//        box.name = boxAux.name
//        box.rawTheme = Int16(boxAux.rawTheme)
//        box.descriptions = boxAux.descriptions
//        box.keywords = boxAux.keywords

//        boxes = Box.all()
    }
}
