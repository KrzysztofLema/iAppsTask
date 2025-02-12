//
//  View+Extensions.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

extension View {
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
}
