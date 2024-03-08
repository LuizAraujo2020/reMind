//
//  SwipperReportListItem.swift
//  reMind
//
//  Created by Luiz Araujo on 08/03/24.
//

import SwiftUI

struct SwipperReportListItem: View {
    @State private var expanded = false

    let term: Term

    private var isPending: Bool {
        term.isPending
    }

    private var symbol: String {
        "\(isPending ? "xmark" : "checkmark").circle"
    }

    private var backgroundColor: Color {
        isPending ? Palette.error.render : Palette.success.render
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: symbol)

                Text(term.value)
                    .padding(.vertical, 8)
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(expanded ? 90 : 0))
                    .animation(.linear(duration: 0.15), value: expanded)
            }

            if expanded {
                VStack {
                    Divider()
                    Text("A asdpamdlasnd adsa d asd a sd ad a")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .frame(minHeight: 100)
            }

            Divider()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(backgroundColor)
        .onTapGesture {
            expanded.toggle()
        }
    }
}

#Preview {
    SwipperReportListItem(term: BoxView_Previews.terms[0])
}
