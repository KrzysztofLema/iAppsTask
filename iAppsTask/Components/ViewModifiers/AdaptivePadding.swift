//
//  AdaptivePadding.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 16/02/2025.
//

import SwiftUI

extension View {
    public func adaptivePadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(AdaptivePadding(configuration: .edges(edges, length: length)))
    }

    public func adaptivePadding(_ edgeInsets: EdgeInsets) -> some View {
        modifier(AdaptivePadding(configuration: .edgeInsets(edgeInsets)))
    }
}

private struct AdaptivePadding: ViewModifier {
    enum Configuration {
        case edgeInsets(EdgeInsets)
        case edges(Edge.Set, length: CGFloat?)
    }

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    let configuration: Configuration

    private var adjustedPadding: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            horizontalSizeClass == .compact ? 20 : 40
        } else {
            16
        }
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        switch configuration {
            case let .edgeInsets(edgeInsets):
                content.padding(edgeInsets.apply(adjustedPadding))
            case let .edges(edges, .some(length)):
                content.padding(edges, length + adjustedPadding)
            case let .edges(edges, .none):
                content.padding(edges).padding(edges, adjustedPadding)
        }
    }
}

extension EdgeInsets {
    fileprivate func apply(_ adaptivePadding: CGFloat) -> EdgeInsets {
        EdgeInsets(
            top: top == 0 ? 0 : top + adaptivePadding,
            leading: leading == 0 ? 0 : leading + adaptivePadding,
            bottom: bottom == 0 ? 0 : bottom + adaptivePadding,
            trailing: trailing == 0 ? 0 : trailing + adaptivePadding
        )
    }
}
