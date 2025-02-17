//
//  View+Dividers.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

public enum DividerSide {
    case top, bottom, all
}

extension View {
    public func withDividersAround(
        sides: DividerSide = .all,
        dividerColor: Color = .black,
        padding: CGFloat = 5
    ) -> some View {
        VStack(spacing: .zero) {
            if sides == .top || sides == .all {
                Divider()
                    .overlay(dividerColor)
                    .adaptivePadding(.vertical, padding)
            }
            self
            if sides == .bottom || sides == .all {
                Divider()
                    .overlay(dividerColor)
                    .adaptivePadding(.vertical, padding)
            }
        }
    }
}
