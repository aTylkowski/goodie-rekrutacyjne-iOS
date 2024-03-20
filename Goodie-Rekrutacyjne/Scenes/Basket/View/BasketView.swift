//
//  BasketView.swift
//  Goodie-rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI

struct BasketView: RootView {
    private enum Constants {
        static let label = "Delete"
        static let systemImage = "trash"
    }

    @ObservedObject private var contract: BasketViewContract

    public init(contract: BasketViewContract) {
        self.contract = contract
    }

    var body: some View {
        List {
            ForEach(contract.items.indices, id: \.self) { index in
                let product = contract.items[index]
                HStack {
                    Text(product.name)
                    Spacer()
                    Text(product.price.formattedString())
                        .textStyle(.price)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        contract.onItemDeletion(index)
                    } label: {
                        Label(Constants.label, systemImage: Constants.systemImage)
                    }
                }
            }
        }
    }
}

#Preview {
    BasketView(contract: BasketViewContract())
}
