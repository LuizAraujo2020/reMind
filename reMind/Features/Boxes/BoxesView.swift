//
//  BoxesView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

struct BoxesView: View {
    @State var boxes: [Box]

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(boxes) { box in
                        BoxCardView(
                            boxName: box.name,
                            numberOfTerms: box.numberOfTerms,
                            theme: box.theme
                        )
                        .reBadge( box.numberOfTerms)
                    }
                }
                .padding(40)
            }
            .padding(-20)
            .navigationTitle("Boxes")
            .background(reBackground())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("plus button tapped!")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    let boxes: [Box] = [
        Box(name: "Box 1", numberOfTerms: 10, theme: .mauve),
        Box(name: "Box 2", numberOfTerms: 20, theme: .aquamarine),
        Box(name: "Box 3", numberOfTerms: 30, theme: .lavander)
    ]

    return BoxesView(boxes: boxes)
}
