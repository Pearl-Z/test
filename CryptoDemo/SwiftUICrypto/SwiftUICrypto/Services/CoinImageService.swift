//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var coinImageSubscription: AnyCancellable?
    var coin: CoinModel
    
    private let imageName: String
    private let folderName = "coin_images"
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    
    private func getCoinImage() {
        if let savedImage = LocalFileManager.instance.getImage(imageName: imageName, folderName: folderName) {
            self.image = savedImage
        }else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        coinImageSubscription = NetworkManager.download(url: url)
            .tryMap({ data in
                UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadImage = returnedImage else { return }
                
                self.image = downloadImage
                LocalFileManager.instance.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
                self.coinImageSubscription?.cancel()
            })
        
    }
    
}
