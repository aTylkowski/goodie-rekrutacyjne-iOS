//
//  RootView.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI
/// A type of SwiftUI view which can be used as a root of a view controller. It defines an associated
/// observed object for use to communicate with code outside of the view.
///
/// An example of a view conforming to this protocol would look like this:
///
/// ```swift
/// public struct ExampleView: RootView {
///     @ObservedObject private var contract: ExampleContract
///
///     public init(contract: ExampleContract) {
///         self.contract = contract
///     }
///
///     public var body: some View {
///         // View implementation
///     }
/// }
/// ```

public protocol RootView: View {
    /// Describes all dynamic properties and events which can be modified and
    /// in turn change appearance or behavior of the view.
    associatedtype Contract: ViewContract

    /// Creates a view with the given contract.
    init(contract: Contract)
}
