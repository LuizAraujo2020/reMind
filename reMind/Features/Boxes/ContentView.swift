//
//  ContentView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            BoxCardView(boxName: "Box Name", numberOfTerms: 100, theme: .aquamarine)
            BoxCardView(boxName: "Box Name", numberOfTerms: 1, theme: .lavander)
        }
    }
}

#Preview {
    ContentView()
}
