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
        Rectangle()
        .fill(.clear)
        .background(reBackground())
    }
}

#Preview {
    ContentView()
}
