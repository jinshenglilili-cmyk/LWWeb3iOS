//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by 李玉凤 on 2023/12/4.
//

import SwiftUI
import Combine
import CoreData
class PortfolioDataService {
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    private let entityName : String = "PortfolioEntity"

    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                updata(entity: entity, amount: amount)
            }else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    func updata(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChange()
    }
    
    func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    func applyChange() {
        save()
        getPortfolio()
    }
    
    func save()  {
        do {
            try container.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
}
