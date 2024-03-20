//
//  ShoppingListViewController.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import Foundation

final class ShoppingListViewController: SwiftUIViewController<ShoppingListView> {
    let viewModel: ShoppingListViewModel

    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindViewModel() {
        let input = makeInput()
        let output = viewModel.transform(input: input)
        bind(output.addItemToBasket)
    }

    private func makeInput() -> ShoppingListViewModel.Input {
        return .init(onItemTap: contract.onItemTap.asDriver())
    }
}
