//
//  Binding+Extension.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    init(ifNotNil value: Binding<(some Sendable)?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
