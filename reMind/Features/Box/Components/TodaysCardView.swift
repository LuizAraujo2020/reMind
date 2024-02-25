//
//  TodaysCardView.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct TodaysCardView: View {
    @State var numberOfPendingCards: Int
    @State var theme: reTheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(numberOfPendingCards) cards to review")
                .font(.title3)

            Button(action: {
                print("swippe time!")
            }, label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(reColorButtonStyle(.mauve))
            .padding(.top, 10)
        }
        .padding(.vertical, 16)
    }
}


#Preview {
    TodaysCardView(numberOfPendingCards: 10, theme: .mauve)
        .padding()
}
