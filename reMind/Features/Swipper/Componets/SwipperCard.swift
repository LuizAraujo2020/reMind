//
//  SwipperCard.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct SwipperCard<FrontContent: View, BackContent: View>: View {
    @Binding var direction: SwipperDirection

    let theme: reTheme

    @ViewBuilder let frontContent: () -> FrontContent
    @ViewBuilder let backContent: () -> BackContent

    // MARK:Tap States
    @State private var isFlipped = false
    @State private var frontAngle = Angle(degrees: 0)
    @State private var backAngle = Angle(degrees: 90)

    // MARK: Drag States
    @State private var dragAmount = CGSize.zero
    @State private var cardAngle = Angle.zero

    private let duration = 0.175
    private let screenSize = UIScreen.main.bounds.size
    private let axis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(theme.render)

                backContent()
            }
            .rotation3DEffect(backAngle, axis: axis)

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(theme.render)

                frontContent()
            }
            .rotation3DEffect(frontAngle, axis: axis)
        }
        .frame(width: screenSize.width - 60, height: 404)
        .offset(dragAmount)
        .rotationEffect(cardAngle)
        .onTapGesture(perform: flip)
        .gesture(
            DragGesture()
                .onChanged(dragDidChange)
                .onEnded(dragDidEnd)
        )
    }

    private func dragDidChange(_ gesture: DragGesture.Value) {
        dragAmount = gesture.translation
        cardAngle = Angle(degrees: gesture.translation.width * 0.05)

        if gesture.translation.width > 0 && direction != .right {
            withAnimation(.linear(duration: duration)) {
                direction = .right
            }
        } 

        if gesture.translation.width < 0 && direction != .left {
            withAnimation(.linear(duration: duration)) {
                direction = .left
            }
        }

        if gesture.translation == .zero && direction != .none {
            withAnimation(.linear(duration: duration)) {
                direction = .none
            }
        }
    }

    private func dragDidEnd(_ gesture: DragGesture.Value) {
        withAnimation(.linear(duration: duration)) {
            dragAmount = .zero
            cardAngle = .zero
            direction = .none
        }
    }

    private func flip() {
        isFlipped.toggle()

        if isFlipped {
            withAnimation(.linear(duration: duration)) {
                frontAngle = Angle(degrees: -90)
            }
            withAnimation(.linear(duration: duration).delay(duration)) {
                backAngle = Angle(degrees: 0)
            }

        } else {
            withAnimation(.linear(duration: duration)) {
                backAngle = Angle(degrees: 90)
            }
            withAnimation(.linear(duration: duration).delay(duration)) {
                frontAngle = Angle(degrees: 0)
            }
        }
    }
}

#Preview {
    SwipperCard(direction: .constant(.none), theme: .aquamarine) {
        Text("Term")

    } backContent: {
        Text("Meaning")
    }
}
