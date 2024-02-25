//
//  reTextEditor.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reTextEditor: View {
    @Binding var text: String
    @State var title: String
    @State var maxSize: Int = 250

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body)
                .fontWeight(.bold)
            
            VStack {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) { _, newValue in
                        if text.count > maxSize {
                            self.text = String(text.prefix(maxSize))
                        }
                    }
                
                Divider()
                    .background(Palette.label.render.opacity(0.6))
                
                Text("\(maxSize)")
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(8)
            .frame(height: 200)
            .background(Palette.background.render)
            .cornerRadius(10)
        }
    }
}

#Preview {
    reTextEditor(text: .constant("text"), title: "Description", maxSize: 150)
        .padding()
}
