//
//  HomeView.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI

struct DetailView: View {

    let coin : CoinModel
    @EnvironmentObject private var vm : DetailViewModel
    var body: some View {
        
        Text("detail")
    }
}


#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
