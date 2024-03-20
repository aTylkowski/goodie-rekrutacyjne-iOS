//
//  CatalogView.swift
//  Goodie-rekrutacyjne-iOS
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import SwiftUI

struct CatalogView: RootView {
    private enum Constants {
        static let usdString = "$"
        static let xString = "x"
        static let itemSide: CGFloat = 170
        static let cornerRadius: CGFloat = 10
        static let spacing: CGFloat = 12
        static let shakeAnimationDuration: TimeInterval = 0.1
        static let shakeEndingAngle: Double = -5
        static let shakeStartingAngle: Double = 0
    }

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: Constants.itemSide))
    ]

    @State private var isShaking = false
    private let contract: CatalogViewContract

    public init(contract: CatalogViewContract) {
        self.contract = contract
    }

    var body: some View {
        LazyVGrid(columns: adaptiveColumns, spacing: Constants.spacing, pinnedViews: [], content: {
            ForEach(contract.items, id: \.self) { item in
                Button(action: {
                    withAnimation {
                        contract.onItemTap(item)
                        startShakeAnimation()
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: Constants.itemSide,
                                   height: Constants.itemSide)
                            .cornerRadius(Constants.cornerRadius)
                        VStack(spacing: Constants.spacing) {
                            Spacer()
                            item.image
                            Text(item.name)
                                .textStyle(.title)
                            HStack {
                                Text(item.initialPrice.formattedString() + Constants.usdString)
                                    .textStyle(.description)
                                Text(Constants.xString)
                                    .textStyle(.description)
                                Text(item.quantity)
                                    .textStyle(.description)
                            }
                            Spacer()
                        }
                    }
                    .foregroundStyle(Colors.element)
                    .rotationEffect(.degrees(isShaking ? Constants.shakeEndingAngle : Constants.shakeStartingAngle))
                }
                .frame(width: Constants.itemSide, height: Constants.itemSide)
            }
        })
        .padding(.horizontal, Constants.spacing)
        .padding(.vertical, Constants.spacing)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func startShakeAnimation() {
        isShaking = true
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.shakeAnimationDuration) {
            isShaking = false
        }
    }
}

#Preview {
    CatalogView(contract: CatalogViewContract())
}
