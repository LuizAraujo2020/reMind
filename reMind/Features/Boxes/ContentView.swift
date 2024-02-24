//
//  ContentView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            BoxCardView(
                boxName: "Box Name",
                numberOfTerms: 10,
                theme: .lavander
            )
                .reBadge(100)
        }
    }
}

#Preview {
    ContentView()
}
