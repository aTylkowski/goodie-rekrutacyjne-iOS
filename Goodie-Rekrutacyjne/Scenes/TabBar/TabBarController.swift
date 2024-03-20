//
//  TabBarController.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let shoppingListViewController = makeShoppingListViewController()
        let basketViewController = makeBasketViewController()

        shoppingListViewController.tabBarItem = UITabBarItem(title: nil, image: Images.list, selectedImage: nil)
        basketViewController.tabBarItem = UITabBarItem(title: nil, image: Images.basket, selectedImage: nil)

        tabBar.backgroundColor = Colors.barTintColor
        viewControllers = [shoppingListViewController, basketViewController]
    }

    private func makeShoppingListViewController() -> CatalogViewController {
        let viewModel = ShoppingListViewModel()
        return CatalogViewController(viewModel: viewModel)
    }

    private func makeBasketViewController() -> BasketViewController {
        let viewModel = BasketViewModel()
        return BasketViewController(viewModel: viewModel)
    }
}
