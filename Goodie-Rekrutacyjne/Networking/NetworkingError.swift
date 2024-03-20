//
//  NetworkingError.swift
//  Goodie-Rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation

enum NetworkingError: Error {
    case invalidData

    var description: String {
        switch self {
        case .invalidData:
            "Data is invalid"
        }
    }
}
