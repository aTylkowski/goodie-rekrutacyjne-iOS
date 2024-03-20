//
//  MockedAPIClient.swift
//  Goodie-Rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation
import RxSwift

final class MockedAPIClient {
    let jsonString = """
    {
        "success": true,
        "timestamp": 1430401802,
        "source": "USD",
        "quotes": {
            "USDAED": 3.672982,
            "USDAFN": 57.8936,
            "USDALL": 126.1652,
            "USDAMD": 475.306,
            "USDANG": 1.78952,
            "USDAOA": 109.216875,
            "USDARS": 8.901966,
            "USDAUD": 1.269072,
            "USDAWG": 1.792375,
            "USDAZN": 1.04945,
            "USDBAM": 1.757305
        }
    }
    """

    func fetchUSDCurrencies() -> Observable<USDCurrenciesResponse> {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return Observable.error(NetworkingError.invalidData)
        }
        do {
            let response = try JSONDecoder().decode(USDCurrenciesResponse.self, from: jsonData)
            return Observable.just(response)
                .observe(on: MainScheduler.asyncInstance)
        } catch {
            return Observable.error(error)
        }
    }
}
