//
//  AdaptiveFont.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 16/02/2025.
//

import SwiftUI

extension View {
    func adaptiveFont(
        _ textStyle: Font.TextStyle,
        configure: @escaping (Font) -> Font = { $0 }
    ) -> some View {
        self.modifier(AdaptiveFont(textStyle: textStyle, configure: configure))
    }
}

private struct AdaptiveFont: ViewModifier {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let textStyle: Font.TextStyle
    let configure: (Font) -> Font

    private var adaptiveSize: CGFloat {
        let baseScaling: CGFloat = {
            switch dynamicTypeSize {
            case .xSmall, .small, .medium:
                return 0
            case .large:
                return 1
            case .xLarge:
                return 2
            case .xxLarge:
                return 4
            case .xxxLarge:
                return 6
            case .accessibility1:
                return 8
            case .accessibility2:
                return 10
            case .accessibility3:
                return 12
            case .accessibility4:
                return 14
            case .accessibility5:
                return 16
            @unknown default:
                return 2
            }
        }()

        let deviceScaling: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 2 : 0

        return baseScaling + deviceScaling
    }

    func body(content: Content) -> some View {
        content.font(self.configure(.system(textStyle, design: .default)))
            .padding(adaptiveSize / 2) 
    }
}
