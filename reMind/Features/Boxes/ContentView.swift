//
//  ContentView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(Palette.allCases, id: \.self) { color in
                Rectangle()
                    .fill(color.render)
            }
        }
    }
}

#Preview {
    ContentView()
}
