//
//  BoxesView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

struct BoxesView: View {
    @ObservedObject var viewModel: BoxesViewModel

    @State var isCreatingNewBox = false

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.boxes) { box in
                        NavigationLink {
                            BoxView(box: BoxAux(box: box), updateBox: viewModel.updateBox)
                        } label: {
                            BoxCardView(
                                boxName: box.name ?? "Name",
                                numberOfTerms: box.numberOfTerms,
                                theme: box.theme
                            )
                            .reBadge(viewModel.getNumberOfPendingTerms(of: box))
                        }
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
                        isCreatingNewBox = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isCreatingNewBox) {
            BoxEditorView(
                box: BoxAux(
                    id: UUID(),
                    name: "",
                    keywords: "",
                    descriptions: "",
                    rawTheme: 0,
                    terms: []
                ), handle: viewModel.createNewBox)
        }
    }
}

#Preview {
    let boxes: [Box] = {
        let box1 = Box(context: CoreDataStack.inMemory.managedContext)
        box1.name = "Box 1"
        box1.rawTheme = 0

        let box2 = Box(context: CoreDataStack.inMemory.managedContext)
        box2.name = "Box 2"
        box2.rawTheme = 1

        let box3 = Box(context: CoreDataStack.inMemory.managedContext)
        box3.name = "Box 3"
        box3.rawTheme = 2

        return [box1, box2, box3]
    }()

    return BoxesView(viewModel: BoxesViewModel())
}
