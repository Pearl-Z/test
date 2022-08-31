//
//  PortoflioDataService.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/15.
//

import Foundation
import CoreData
import UIKit

class PortoflioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data!\(error)")
            }
        }
        getPoertoflio()
    }
    
    
    // MARK: PUBLIC----------------------------
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    
    
    // MARK: PRIVATE---------------------------
    
    private func getPoertoflio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            try savedEntities = container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch Portoflio Entity!\(error)")
        }
        
    }
    
    private func add(coin: CoinModel, amount:Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data!\(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPoertoflio()
    }
    
}
