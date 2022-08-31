//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/6.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolionCoins: [CoinModel] = []
    @Published var searchString = ""
    @Published var isLoading: Bool = false
    @Published var stats:[StatisticModel] = []
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortoflioDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchString
            .combineLatest(coinDataService.$allConins, $sortOption)
            .debounce(for: .seconds(0.05), scheduler: DispatchQueue.main)
            .map(filterCoinsAndSort)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellabels)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.portfolionCoins = self.sortPortfolioCoinsIfNeeded(coins: coins)
            }
            .store(in: &cancellabels)
        
        marketDataService.$marketData
            .combineLatest($portfolionCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.stats = stats
                self?.isLoading = false
            }
            .store(in: &cancellabels)
        
    }
    
    
    private func filterCoinsAndSort(text: String, coins: [CoinModel], sortOption: SortOption) -> [CoinModel] {
        var coins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &coins, sort: sortOption)
        return coins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        if text.isEmpty {
            return coins
        } else {
            let lowercasedText = text.lowercased()
            return coins.filter { coin in
                return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
            }
        }
    }
    
    private func sortCoins(coins: inout [CoinModel], sort: SortOption) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
        
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
        
    }
    
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities:[PortfolioEntity]) -> [CoinModel]{
        allCoins.compactMap { coin in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketDataModel?, portfolionCoins: [CoinModel]) -> [StatisticModel]{
        var stats:[StatisticModel] = []
        guard let data = marketData else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolionCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        let previousValue = portfolionCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }.reduce(0, +)
        let precntageChange = ((portfolioValue - previousValue) / previousValue)
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimas(), percentageChange: precntageChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notifacation(type: .success)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
}
