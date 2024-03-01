//
//  TodaysCardView.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct TodaysCardView: View {
    internal init(terms: Binding<[Term]>/*, numberOfPendingCards: Int*/, theme: reTheme) {
        self._terms = terms
//        self.numberOfPendingCards = numberOfPendingCards
        self.theme = theme

//        self.review = SwipeReview.getTermsToReview(terms: self.terms)
    }
    
//    internal init(numberOfPendingCards: Int, theme: reTheme) {
//        self.numberOfPendingCards = numberOfPendingCards
//        self.theme = theme
//    }
//    
    @Binding var terms: [Term]
    @State var theme: reTheme

    private var review: SwipeReview {
        SwipeReview.getTermsToReview(terms: self.terms)
    }

    var numberOfPendingCards: Int {
        SwipeReview.getTermsToReview(terms: self.terms).termsToReview.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(numberOfPendingCards) card\(numberOfPendingCards == 1 ? "": "s") to review")
                .font(.title3)

            NavigationLink {
                SwipperView(review: review)

            } label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .font(.body)
//                    .fontWeight(.bold)
//                    .foregroundColor(Palette.reBlack.render)
//                    .frame(height: 48)
//                    .background {
//                        Rectangle()
//                            .fill(theme.render)
//                            .cornerRadius(10)
//                    }
            }
            .buttonStyle(reColorButtonStyle(theme))
            .padding(.top, 10)
            .disabled(numberOfPendingCards <= 0)
            .opacity(numberOfPendingCards <= 0 ? 0.5 : 1.0)
        }
        .padding(.vertical, 16)
    }
}


#Preview {
//    TodaysCardView(
//        review: SwipeReview(termsToReview: BoxView_Previews.terms, termsReviewed: []),
//        numberOfPendingCards: 10,
//        theme: .mauve
//    )
    TodaysCardView(
        terms: .constant(BoxView_Previews.terms),
//        numberOfPendingCards: 10,
        theme: .mauve
    )
        .padding()
}
