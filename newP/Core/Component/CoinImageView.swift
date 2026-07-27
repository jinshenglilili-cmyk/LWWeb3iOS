//
//  CoinImageView.swift
//  newP
//
//  Created by Liwei on 2026/1/2.
//

import SwiftUI
import Combine

struct CoinImageView: View {
    @StateObject var vm:CoinImageViewModel
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin:coin))
    }
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading == true {
                ProgressView()
            } else {
                
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
}
