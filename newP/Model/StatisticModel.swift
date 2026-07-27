//
//  CoinModel.swift
//  CryptoApp
//
//  Created by 李玉凤 on 2023/12/1.
//

import SwiftUI

struct StatisticModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentAgeChange: Double?
    
    init(title: String, value: String, percentAgeChange: Double?=nil) {
        self.title = title
        self.value = value
        self.percentAgeChange = percentAgeChange
    }
}

