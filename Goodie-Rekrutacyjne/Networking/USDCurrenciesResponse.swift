//
//  USDCurrenciesResponse.swift
//  Goodie-Rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation

public struct USDCurrenciesResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

extension USDCurrenciesResponse {
    static let empty = USDCurrenciesResponse(success: false,
                                             timestamp: 0,
                                             source: "",
                                             quotes: [:])
}
