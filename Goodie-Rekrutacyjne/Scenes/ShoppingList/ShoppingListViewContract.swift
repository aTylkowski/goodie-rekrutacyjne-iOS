//
//  ShoppingListViewContract.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation

public final class ShoppingListViewContract: ViewContract {
    @Published public var onItemTap = Trigger<Product>()

    let items: [Product] = [.potato,
                            .eggs,
                            .milk,
                            .banana]

    public init() {}
}
