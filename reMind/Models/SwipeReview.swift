//
//  SwipeReview.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation

struct SwipeReview {
    var termsToReview: [Term] = []
    var termsReviewed: [Term] = []

    internal init(termsToReview: [Term] = [], termsReviewed: [Term] = []) {
        self.termsToReview = termsToReview
        self.termsReviewed = termsReviewed
    }

    static func getTermsToReview(terms: [Term]) -> Self {
        Self.init(
            termsToReview: terms.filter { $0.isPending },
            termsReviewed: terms.filter { !$0.isPending }
        )
    }
}
