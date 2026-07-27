//
//  CoinDataService.swift
//  newP
//
//  Created by Liwei on 2025/12/31.
//

import Foundation
import Combine
import UIKit

class CoinImageService {
    @Published var image : UIImage? = nil
    var coin: CoinModel
    var coinImageSubscription : AnyCancellable?
    private let folderName: String = "coin_images"
    private let imageName: String
    private let fileManager = LocalFileManager.instance
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage()  {
        if let saveImage = LocalFileManager.instance.getImage(imageName: imageName, folderName: folderName){
            image = saveImage
            print("加载缓存图片")
        } else {
            downCoinImage()
        }
    }
    private func downCoinImage () {
        guard let url = URL(string: coin.image) else { return }
        print(coin.image)
        coinImageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data)-> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage 
                self.coinImageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, folderName: folderName, imageName: imageName)
            })
    }
    
}
