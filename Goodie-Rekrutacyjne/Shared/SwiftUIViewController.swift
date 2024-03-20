//
//  SwiftUIViewController.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI
import RxSwift
import RxCocoa

/// Base view controller to use when defining view hierarchy using SwiftUI. It is intended to be used
/// with SwiftUI views conforming to `RootView` protocol.
///
/// The view of provided generic type will be created automatically. To update it or react to its events use
/// `contract` property.

class SwiftUIViewController<Content: RootView>: UIViewController, DisposeBagOwner {
    let disposeBag = DisposeBag()

    private let hostingController: UIHostingController<Content>

    let contract = Content.Contract()

    init() {
        self.hostingController = UIHostingController(rootView: Content(contract: contract))
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        hostingController.didMove(toParent: self)

        bindViewModel()
    }

    func bindViewModel() {}
}

extension SwiftUIViewController {
    func bind<Value>(_ driver: Driver<Value>, to keyPath: ReferenceWritableKeyPath<Content.Contract, Value>) {
        bind(driver) { contract, value in
            contract[keyPath: keyPath] = value
        }
    }

    func bind<Value>(_ driver: Driver<Value>, to keyPath: ReferenceWritableKeyPath<Content.Contract, Value?>) {
        bind(driver) { contract, value in
            contract[keyPath: keyPath] = value
        }
    }

    func bind(_ driver: Driver<Void>, perform bindingAction: @escaping (Content.Contract) -> Void) {
        driver.drive(onNext: { [contract] in
            bindingAction(contract)
        }).disposed(by: disposeBag)
    }

    func bind<Value>(_ driver: Driver<Value>, perform bindingAction: @escaping (Content.Contract, Value) -> Void) {
        driver.drive(onNext: { [contract] value in
            bindingAction(contract, value)
        }).disposed(by: disposeBag)
    }
}
