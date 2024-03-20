//
//  ShoppingListViewModel.swift
//  Goodie-Rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import RxSwift
import RxCocoa

final class ShoppingListViewModel: ViewModelProtocol {
    struct Input {
        let onItemTap: Driver<CatalogProduct>
    }
    
    struct Output {
        let addItemToBasket: Driver<Void>
    }

    let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }

    func transform(input: Input) -> ShoppingListViewModel.Output {
        let addItemToBasket = input.onItemTap
            .map { product -> Void in
                let context = self.coreDataManager.persistentContainer.viewContext
                let entity = ProductEntity(context: context)
                entity.name = product.name
                entity.currentPrice = product.initialPrice
                entity.initialPrice = product.initialPrice
                self.coreDataManager.saveContext()
                return ()
            }

        return Output(addItemToBasket: addItemToBasket)
    }
}
