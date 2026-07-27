//
//  HomeViewModel.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
//    @Published var statistics: [StatisticModel] = []// 搜索框上面的数据部分
//    @Published var allCoins : [CoinModel] = []
//    @Published var portfolioCoins : [CoinModel] = []
//    @Published var searchText : String = ""
//    @Published var sortOption :sortOption = .holding
//    private let coinDataService = CoinDataService()
//    private let marketDataService = MarketDataService()
//    private let portfolioDataService = PortfolioDataService()
//    private var cancalables = Set<AnyCancellable>()
//    
//    enum sortOption {
//        case rank, rankReversed,holding, holdingReversed,price,priceReversed
//    }
//    
//    init() {
//        self.addSubsCribers()
//    }
//    
//    func addSubsCribers () {
//        // 所有的数据
//        coinDataService.$allCoins
//            .sink { [weak self](resultValue) in
//                self?.allCoins = resultValue
//            }
//            .store(in: &cancalables)
//        //搜索的数据
//        $searchText
//            .combineLatest(self.$allCoins, $sortOption )
//            .debounce(for:.seconds(0.5), scheduler: DispatchQueue.main)
//            .map (filterAndSortCoin)
//            .sink { coins in
//                self.allCoins = coins
//            }
//            .store(in: &cancalables)
//        // 搜索框头部的数据
//        marketDataService.$marketData
//            .map{(marketDataModel)->[StatisticModel] in
//                var stat:[StatisticModel] = []
//                guard let data = marketDataModel else {
//                    return stat
//                }
//                let marketCap = StatisticModel(title: "market cap", value: data.marketCap,percentAgeChange: data.marketCapChangePercentage24HUsd)
//                let volume = StatisticModel(title: "24H market cap", value: data.volume)
//                let btcDominance = StatisticModel(title: "btcDominance market cap", value: data.btcDominance)
//                let portfolio = StatisticModel(title: "portfolio market cap", value: "0.00$", percentAgeChange: 0)
//                stat.append(contentsOf: [
//                    marketCap,
//                    volume,
//                    btcDominance,
//                    portfolio
//                ])
//                return stat
//            }
//            .sink { [weak self] (reslutStatisticModel) in
//                self?.statistics = reslutStatisticModel
//            }
//            .store(in: &cancalables)
//        
//        // 自定义选择的投资组合
//        $allCoins
//            .combineLatest(portfolioDataService.$savedEntities)
//            .map { (CoinModels, PortfolioEntities)->[CoinModel] in
//                CoinModels.compactMap { coin->CoinModel? in
//                    guard let entity = PortfolioEntities.first(where: {$0.coinID == coin.id})else{
//                        return nil
//                    }
//                    return coin.updateHoldings(amount: entity.amount)
//                }
//            }
//            .sink { [weak self] (result) in
//                self?.portfolioCoins = result
//            }
//            .store(in: &cancalables)
//    }
//    
//    func updatePortfolio(coin: CoinModel, amount: Double) {
//        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
//    }
//    
//    func filterAndSortCoin(text: String, coins : [CoinModel], sort:sortOption) -> [CoinModel] {
//        var coins1 = filterCoin(text: text, coins: coins)
//        sortCoin(sort: sort, coins: &coins1)
//        return coins1
//    }
//    
//    func filterCoin(text: String, coins : [CoinModel]) -> [CoinModel] {
//        guard !text.isEmpty else {
//            return coins
//        }
//        let lowercaseText = text.lowercased()
//        return coins.filter { coin in
//            return coin.name.lowercased().contains(lowercaseText)||coin.symbol.lowercased().contains(lowercaseText)||coin.id.lowercased().contains(lowercaseText)
//        }
//    }
//    
//    func sortCoin(sort: sortOption, coins : inout [CoinModel]) {
//        switch self.sortOption {
//        case .rank, .holding:
//            coins.sort(by: {$0.rank < $1.rank})
//        case .rankReversed,.holdingReversed:
//            coins.sort(by: {$0.rank > $1.rank})
//        case .price:
//            coins.sort(by: {$0.currentPrice > $1.currentPrice})
//
//        case .priceReversed:
//            coins.sort(by: {$0.currentPrice > $1.currentPrice})
//        }
//    }
}
