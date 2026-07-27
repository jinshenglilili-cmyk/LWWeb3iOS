//
//  CircularCustomButton.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName : String
    var body: some View {
        Image(systemName: iconName)
            .font(Font.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50, alignment: SwiftUI.Alignment.center)
            .background(
                Circle()
                    .fill(Color.theme.background)
            )
            .shadow(color: Color.theme.accent, radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview (traits: .sizeThatFitsLayout){
    Group {
        CircleButtonView(iconName: "info")
        CircleButtonView(iconName: "plus")
            .colorScheme(.dark)
    }
}
