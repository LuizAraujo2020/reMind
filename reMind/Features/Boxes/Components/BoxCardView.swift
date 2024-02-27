//
//  BoxCardView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxCardView: View {
    @ObservedObject var box: Box

    var body: some View {
        VStack(alignment: .leading) {
            Text(box.name)
                .font(.title3)
                .bold()

            Label("\(box.numberOfTerms) term\(getPlural())", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Palette.reBlack.render.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundStyle(Palette.reBlack.render)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(box.theme.render)
        .cornerRadius(10)
    }

    private func getPlural() -> String {
        box.numberOfTerms == 1 ? "": "s"
    }
}

#Preview {
    let box: Box = {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.name = "Box 1"
        box.rawTheme = 0
        BoxView_Previews.terms.forEach { term in
            box.addToTerms(term)
        }
        return box
    }()

    let terms: [Term] = {
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Term 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"

        return [term1, term2, term3]
    }()

    return BoxCardView(box: box)
}
