//
//  StatisticView.swift
//  newP
//
//  Created by Liwei on 2026/1/4.
//

import SwiftUI

struct HomeStateView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortFolio : Bool
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width/3, alignment: .leading)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortFolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStateView(showPortFolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
