//
//  HomeViewModel.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//
import SwiftUI
import Combine
import UIKit
class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool =  false
    let coin : CoinModel
    private var dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        self.addScriber()
    }

    private func addScriber (){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
                print("这是基础日志")
            } receiveValue: { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            .store(in: &cancellables)
    }
}

