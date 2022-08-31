//
//  CoinDataService.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/6.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allConins: [CoinModel] = []
    
    var coinsSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinsSubscription = NetworkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allConins = returnedCoins
                self?.coinsSubscription?.cancel()
            })
        
    }
    
}
