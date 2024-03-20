//
//  BasketViewController.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 20/03/2024.
//

import Foundation
import RxCocoa
import RxSwift

final class BasketViewController: SwiftUIViewController<BasketView> {
    let viewModel: BasketViewModel

    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindViewModel() {
        let input = makeInput()
        let output = viewModel.transform(input: input)
        bind(output.loadedProducts, to: \.items)
        bind(output.deletedItem, to: \.items)
        bind(output.fetchedCurrencies, to: \.currency)
    }

    private func makeInput() -> BasketViewModel.Input {
        return .init(viewWillAppear: rx.viewWillAppear.asDriver(),
                     onDeleteItemTap: contract.onItemDeletion.asDriver())
    }
}
