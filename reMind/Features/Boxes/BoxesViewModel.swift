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
            guard let lasReview = term.lastReview,
                  let nextReview = Calendar.current.date(byAdding: .day, value: srs, to: lasReview)
            else { return false }

            return nextReview <= today
        }
        return filteredTerms.count <= 0 ? nil : filteredTerms.count
    }
}
