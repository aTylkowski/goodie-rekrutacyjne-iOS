//
//  DisposeBagOwner.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol DisposeBagOwner: AnyObject {
    var disposeBag: DisposeBag { get }
}

extension DisposeBagOwner {
    func bind(_ driver: Driver<Void>) {
        driver.drive().disposed(by: disposeBag)
    }

    func bind(_ drivers: Driver<Void>...) {
        drivers.forEach { driver in
            bind(driver)
        }
    }

    func bind(_ driver: Driver<Void>, perform bindingAction: @escaping () -> Void) {
        driver.drive(onNext: {
            bindingAction()
        }).disposed(by: disposeBag)
    }

    func bind<Value>(_ driver: Driver<Value>, perform bindingAction: @escaping (Value) -> Void) {
        driver.drive(onNext: {
            bindingAction($0)
        }).disposed(by: disposeBag)
    }
}
