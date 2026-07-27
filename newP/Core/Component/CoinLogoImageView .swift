//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by 李玉凤 on 2023/12/4.
//

import SwiftUI

struct CoinLogoImageView : View {
    let coin : CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50, alignment: .center)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
    }
}

#Preview {
    CoinLogoImageView(coin: DeveloperPreview.instance.coin)
}

