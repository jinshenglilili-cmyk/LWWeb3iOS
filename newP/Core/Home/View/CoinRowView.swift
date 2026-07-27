//
//  CoinRowView.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI
import Foundation

struct CoinRowView: View {
    var coin : CoinModel
    var isShowHoldingColum : Bool

    var body: some View {
        HStack (spacing: 0){
            leftColum
            Spacer()
            if isShowHoldingColum {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        
    }
}

#Preview {
    CoinRowView(coin: DeveloperPreview.instance.coin,isShowHoldingColum: true)
}

extension CoinRowView {
    private var leftColum : some View {
        HStack (spacing: 0){
            Text("\(coin.rank)")
                .font(Font.caption2)
                .foregroundStyle(Color.theme.accent)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol)
                .font(Font.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        VStack (alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrentcyWith2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text((coin.currentHoldings ?? 0).asNumberString())
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
    }
    
    private var rightColumn : some View {
        VStack(alignment:.trailing){
            Text("\(coin.currentPrice.asCurrentcyWith2Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)

        }
        .frame(width: UIScreen.main.bounds.width / 3.5 ,alignment: .trailing)
    }
}
