//
//  OnFirstTaskViewModifier.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

struct OnFirstTaskViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    let action: () async -> Void

    func body(content: Content) -> some View {
        content
            .task {
                guard !didAppear else { return }
                didAppear = true
                await action()
            }
    }
}

extension View {
    func onFirstTask(action: @escaping () async -> Void) -> some View {
        modifier(OnFirstTaskViewModifier(action: action))
    }
}
