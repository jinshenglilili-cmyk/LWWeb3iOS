//
//  StatisticView.swift
//  newP
//
//  Created by Liwei on 2026/1/4.
//

import SwiftUI

struct StatisticView: View {
    let stat : StatisticModel
    var body: some View {
        VStack {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.accent)
            Text(stat.value)
                .font(.caption)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentAgeChange ?? 0) >= 0 ? 0:180 )
                    )
                Text(stat.percentAgeChange?.asPercentString() ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.theme.accent)
                    .bold()
            }
            .foregroundStyle((stat.percentAgeChange ?? 0) >= 0 ? Color.red:Color.green)
            .opacity(stat.percentAgeChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat1)
    StatisticView(stat: DeveloperPreview.instance.stat2)
    StatisticView(stat: DeveloperPreview.instance.stat3)

}
