//
//  SwipperReportView.swift
//  reMind
//
//  Created by Luiz Araujo on 08/03/24.
//

import SwiftUI

struct SwipperReportView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var review = SwipeReview()

    let terms: [Term]
//    var toReview = 0
//    var reviewed = 0

    internal init(terms: [Term]) {
        self.terms = terms
        self.review = SwipeReview.getTermsToReview(terms: terms)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("\(review.termsReviewed.count)/\(review.termsToReview.count) terms were reviewed")
                    .font(.body)
                    .bold()

                /// Expandable list items
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(terms, id: \.self) { term in

                            SwipperReportListItem(term: term)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .shadow(color: .black.opacity(0.25), radius: 10)
                .scrollContentBackground(.hidden)
                .background(reBackground())


                Spacer()

                /// Close button
                Button {
                    print("Close Report")
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Text("Close Report")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("Swipper Report")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SwipperReportView(terms: BoxView_Previews.terms)
}
