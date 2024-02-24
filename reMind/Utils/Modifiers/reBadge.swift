//
//  reBadge.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reBadgeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    @State var value: Int?

    private var textColor: Color {
        colorScheme == .light ? Palette.reWhite.render : Palette.reBlack.render
    }

    private var backgroundColor: Color {
        colorScheme == .light ? Palette.reBlack.render : Palette.reWhite.render
    }

    func body(content: Content) -> some View {
        if let value {
            content
                .overlay(alignment: .topTrailing) {
                    GeometryReader { geo in
                        Text("\(value)")
                            .padding(6)
                            .font(.callout)
                            .foregroundStyle(textColor)
                            .fontWeight(.semibold)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(minWidth: 40)
                            }
                            .position(x: geo.size.width, y: 0)
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func reBadge(_ value: Int?) -> some View {
        modifier(reBadgeModifier(value: value))
    }
}
