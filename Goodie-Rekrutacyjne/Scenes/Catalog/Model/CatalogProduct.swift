//
//  CatalogProduct.swift
//  Goodie-Rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI

public enum CatalogProduct {
    case potato
    case eggs
    case milk
    case banana

    init?(fromName name: String) {
        switch name {
        case CatalogProduct.potato.name:
            self = .potato
        case CatalogProduct.eggs.name:
            self = .eggs
        case CatalogProduct.milk.name:
            self = .milk
        case CatalogProduct.banana.name:
            self = .banana
        default:
            return nil
        }
    }

    var name: String {
        switch self {
        case .potato:
            "Potato"
        case .eggs:
            "Eggs"
        case .milk:
            "Milk"
        case .banana:
            "Banana"
        }
    }

    var quantity: String {
        switch self {
        case .potato:
            "Bag"
        case .eggs:
            "Dozen"
        case .milk:
            "Bottle"
        case .banana:
            "kg"
        }
    }

    var initialPrice: Double {
        switch self {
        case .potato:
            0.95
        case .eggs:
            2.10
        case .milk:
            1.30
        case .banana:
            0.73
        }
    }

    var image: Image {
        switch self {
        case .potato:
            Images.potato
        case .eggs:
            Images.eggs
        case .milk:
            Images.milk
        case .banana:
            Images.banana
        }
    }
}

