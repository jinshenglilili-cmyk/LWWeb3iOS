//
//  HomeViewModel.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    @Published var statistics: [StatisticModel] = []// 搜索框上面的数据部分
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var sortOption :sortOption = .holding
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancalables = Set<AnyCancellable>()
    // 保存原始的全部数据，每次搜索基于原始数据过滤
    @Published private var allCoinsFromService: [CoinModel] = []

    enum sortOption {
        case rank, rankReversed,holding, holdingReversed,price,priceReversed
    }

    init() {
        self.addSubsCribers()
    }

    func addSubsCribers () {
        // 所有的数据 - 保存原始完整数据
        coinDataService.$allCoins
            .sink { [weak self](resultValue) in
                self?.allCoinsFromService = resultValue
            }
            .store(in: &cancalables)
        //搜索的数据 - 基于原始完整数据进行过滤，保证清空搜索后能恢复所有数据
        $searchText
            .combineLatest(self.$allCoinsFromService, $sortOption )
            .debounce(for:.seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterAndSortCoin)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancalables)
        // 搜索框头部的数据
        // Always 3 statistics:
        // Live Prices: Market Cap / 24h Volume / BTC Dominance
        // Portfolio: Market Cap / 24h Volume / Portfolio Value (same as reference project)
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map { (marketDataModel, portfolioCoins)->[StatisticModel] in
                var stat:[StatisticModel] = []
                guard let data = marketDataModel else {
                    return stat
                }
                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentAgeChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

                let portfolioValue =
                    portfolioCoins
                        .map({ $0.currentHoldingsValue })
                        .reduce(0, +)

                // Calculate percentage change for portfolio
                var percentageChange: Double? = nil
                if portfolioValue > 0 {
                    let previousValue =
                        portfolioCoins
                            .map { (coin) -> Double in
                                let currentValue = coin.currentHoldingsValue
                                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                                let previousValue = currentValue / (1 + percentChange)
                                return previousValue
                            }
                            .reduce(0, +)
                    if previousValue > 0 {
                        percentageChange = ((portfolioValue - previousValue) / previousValue)
                    }
                }

                let portfolio = StatisticModel(
                    title: "Portfolio Value",
                    value: portfolioValue.asCurrentcyWith2Decimals(),
                    percentAgeChange: percentageChange
                )

                if portfolioCoins.isEmpty {
                    // Even when empty, still follow reference project pattern
                    stat.append(contentsOf: [
                        marketCap,
                        volume,
                        portfolio
                    ])
                } else {
                    // When we have portfolio coins, always show Market Cap + 24h Volume + Portfolio Value
                    stat.append(contentsOf: [
                        marketCap,
                        volume,
                        portfolio
                    ])
                }
                return stat
            }
            .sink { [weak self] (reslutStatisticModel) in
                self?.statistics = reslutStatisticModel
            }
            .store(in: &cancalables)
        
        // 自定义选择的投资组合
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (CoinModels, PortfolioEntities)->[CoinModel] in
                CoinModels.compactMap { coin->CoinModel? in
                    guard let entity = PortfolioEntities.first(where: {$0.coinID == coin.id})else{
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] (result) in
                self?.portfolioCoins = result
            }
            .store(in: &cancalables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func filterAndSortCoin(text: String, coins : [CoinModel], sort:sortOption) -> [CoinModel] {
        var coins1 = filterCoin(text: text, coins: coins)
        sortCoin(sort: sort, coins: &coins1)
        return coins1
    }
    
    func filterCoin(text: String, coins : [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercaseText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercaseText)||coin.symbol.lowercased().contains(lowercaseText)||coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    func sortCoin(sort: sortOption, coins : inout [CoinModel]) {
        switch self.sortOption {
        case .rank, .holding:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed,.holdingReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})

        case .priceReversed:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
}
