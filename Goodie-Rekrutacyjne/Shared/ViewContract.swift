//
//  ViewContract.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI

/// Type of an object which is used as a bridging layer between screen logic
/// defined in view controller/view model and view hierarchy defined via SwiftUI.
///
/// An example of a type conforming to this protocol would look like this:
///
/// ```swift
/// public final class ExampleContract: ViewContract {
///     @Published public var isBlikEnabled = false
///
///     public let sourceProductTapped = Trigger()
///
///     public init() {}
/// }
/// ```
public protocol ViewContract: ObservableObject {
    init()
}
