//
//  SwipperView.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct SwipperView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var review: SwipeReview
    @State private var direction: SwipperDirection = .none
    @State private var currentTerm = 0

    var body: some View {
        VStack {
            if !review.termsToReview.isEmpty {
                SwipperLabel(direction: $direction)
                    .padding()

                Spacer()

                SwipperCard(direction: $direction,
                            theme: review.termsToReview[currentTerm].theme,
                            frontContent: {
                    Text(review.termsToReview[currentTerm].value)

                },
                            backContent: {
                    Text(review.termsToReview[currentTerm].meaning)
                })
            }
            
            Spacer()

            Button(action: {
                print("finish review")
                presentationMode.wrappedValue.dismiss()

            }, label: {
                Text("Finish Review")
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reBackground())
        .navigationTitle("\(review.termsToReview.count) terms left")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: direction) { _, newValue in
            handleDirection(newValue)
        }
    }

    private func handleDirection(_ direction: SwipperDirection = .none) {
        guard direction != .none else { return }

        /// Remove from the list pending to review and put in the reviewed.
        let temp = review.termsToReview.remove(at: currentTerm)
        temp.lastReview = Date()

        review.termsReviewed.append(temp)

        switch direction {
        case .none: break
        case .right:
            temp.rawSRS = (SpacedRepetitionSystem(rawValue: temp.rawSRS)?.next ?? .first).rawValue

        case .left:
            temp.rawSRS = (SpacedRepetitionSystem(rawValue: temp.rawSRS)?.previous ?? .first).rawValue
        }
    }
}

struct SwipperView_Previews: PreviewProvider {
    static let term: Term = {
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.value = "Term"
        term.meaning = "Meaning"
        term.rawSRS = 0
        term.rawTheme = 0

        return term
    }()
    static var previews: some View {
        NavigationStack {
            SwipperView(review: SwipeReview(termsToReview: [
                Term(context: CoreDataStack.inMemory.managedContext)
            ]))
        }
    }
}
