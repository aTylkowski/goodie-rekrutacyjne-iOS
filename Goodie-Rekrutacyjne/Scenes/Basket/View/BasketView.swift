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
        static let buttonLabel = "USD"
        static let currencyChoiceTitle = "Choose currency you desire"
        static let cornerRadius: CGFloat = 10
    }

    @ObservedObject private var contract: BasketViewContract
    @State private var isDropdownVisible = false

    public init(contract: BasketViewContract) {
        self.contract = contract
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isDropdownVisible.toggle()
                }) {
                    Text(Constants.buttonLabel)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(Constants.cornerRadius)
                }
            }
            .padding()

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
        .actionSheet(isPresented: $isDropdownVisible) {
            ActionSheet(title: Text(Constants.currencyChoiceTitle),
                        buttons: makeButtons())
        }
    }

    private func makeButtons() -> [ActionSheet.Button] {
        guard !contract.currency.quotes.isEmpty else {
            return [.cancel()]
        }

        var buttons: [ActionSheet.Button] = []
        for (currency, value) in contract.currency.quotes {
            let button = ActionSheet.Button.default(Text(currency)) {
                print(value)
            }
            buttons.append(button)
        }

        buttons.append(.cancel())

        return buttons
    }
}

#Preview {
    BasketView(contract: BasketViewContract())
}
