//
//  CoinImageView.swift
//  newP
//
//  Created by Liwei on 2026/1/2.
//

import SwiftUI
import Combine

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 核心：加 wrappedValue
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XmarkButton()
}
