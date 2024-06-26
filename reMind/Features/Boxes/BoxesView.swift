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
    @State private var searchText = ""

    private var filteredBoxes: [Box] {

        let boxes = viewModel.boxes.sorted { lhs, rhs in
            lhs.name < rhs.name
        }

        if searchText.isEmpty {
            return boxes
        } else {
            return boxes.filter { ($0.name).contains(searchText) }
        }
    }

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
                            BoxView(
                                box: box,
                                terms: $viewModel.terms,
                                termsToReview: viewModel.getPendingTerms(of: box),
                                createTerm: viewModel.createTerm
                            )
                            
                        } label: {
                            BoxCardView(box: box)
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
        .searchable(text: $searchText, prompt: "")
        .sheet(isPresented: $isCreatingNewBox) {
            BoxCreationView(create: viewModel.createNewBox)
        }
        .refreshable {
            viewModel.boxes = Box.all()
        }
    }
}

#Preview {
//    let boxes: [Box] = {
//        let box1 = Box(context: CoreDataStack.inMemory.managedContext)
//        box1.name = "Box 1"
//        box1.rawTheme = 0
//
//        let box2 = Box(context: CoreDataStack.inMemory.managedContext)
//        box2.name = "Box 2"
//        box2.rawTheme = 1
//
//        let box3 = Box(context: CoreDataStack.inMemory.managedContext)
//        box3.name = "Box 3"
//        box3.rawTheme = 2
//
//        return [box1, box2, box3]
//    }()

    return BoxesView(viewModel: BoxesViewModel())
}
