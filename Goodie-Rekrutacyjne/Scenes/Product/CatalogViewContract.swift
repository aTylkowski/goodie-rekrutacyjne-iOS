//
//  CatalogViewContract.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation

public final class CatalogViewContract: ViewContract {
    @Published public var onItemTap = Trigger<CatalogProduct>()

    let items: [CatalogProduct] = [.potato,
                                   .eggs,
                                   .milk,
                                   .banana]

    public init() {}
}
