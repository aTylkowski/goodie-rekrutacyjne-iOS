//
//  BasketViewModel.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 20/03/2024.
//

import RxSwift
import RxCocoa

final class BasketViewModel: ViewModelProtocol {
    struct Input {
        let viewWillAppear: Driver<Void>
        let onDeleteItemTap: Driver<Int>
    }

    struct Output {
        let loadedProducts: Driver<[BasketProduct]>
        let fetchedCurrencies: Driver<USDCurrenciesResponse>
        let deletedItem: Driver<Void>
    }

    let coreDataManager: CoreDataManager
    let apiClient: MockedAPIClient

    init(coreDataManager: CoreDataManager = .shared,
         apiClient: MockedAPIClient = .init()) {
        self.coreDataManager = coreDataManager
        self.apiClient = apiClient
    }

    func transform(input: Input) -> BasketViewModel.Output {
        let loadedProducts = input.viewWillAppear
            .map {
                return self.coreDataManager.fetchEntities()
                    .compactMap { entity in
                        if let product = CatalogProduct(fromName: entity.name ?? "") {
                            return BasketProduct(product: product, currentPrice: nil)
                        }
                        return nil
                    }
            }

        let fetchedCurrencies = input.viewWillAppear
            .flatMapLatest {
                self.apiClient.fetchUSDCurrencies().asDriver(onErrorJustReturn: .empty)
            }

        let deletedItem = input.onDeleteItemTap
            .map { index -> Void in
                self.coreDataManager.deleteEntity(index: index)
                return ()
            }

        return Output(loadedProducts: loadedProducts,
                      fetchedCurrencies: fetchedCurrencies,
                      deletedItem: deletedItem)
    }
}
