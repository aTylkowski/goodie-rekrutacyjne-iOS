//
//  BasketViewContract.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 20/03/2024.
//

import SwiftUI

public final class BasketViewContract: ViewContract {
    @Published public var items = [BasketProduct]()
    @Published public var currency: USDCurrenciesResponse = .empty
    @Published public var onItemDeletion = Trigger<Int>()

    public init() {}

    func updateItemsWithCurrency(_ currency: String, exchangeRate: Double) {
        items = items.map { item in
            let updatedPrice = item.product.initialPrice * exchangeRate
            return BasketProduct(product: item.product, currentPrice: updatedPrice)
        }
    }
}
