//
//  Trigger.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation
import RxCocoa
import Foundation

/// Type used to send events from SwiftUI view which can then be observed as a `Driver`.
public struct Trigger<Value> {
    private let relay = PublishRelay<Value>()

    /// Returns events received by this trigger as an observable `Driver`.
    public func asDriver() -> Driver<Value> {
        return relay.asDriver(onErrorRecover: { _ in
            return Driver.empty()
        })
    }

    /// Called to emit a single event.
    func callAsFunction(_ value: Value) {
        relay.accept(value)
    }
}

extension Trigger where Value == Void {
    func callAsFunction() {
        relay.accept(())
    }
}
