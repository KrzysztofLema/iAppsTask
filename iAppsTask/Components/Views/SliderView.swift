//
//  SliderView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct SliderView: View {
    
    @Binding var progress: Float
    @State private var isDragging: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .foregroundStyle(.black.opacity(0.25))
                    .frame(maxWidth: .infinity)
                Rectangle()
                    .foregroundStyle(.blue)
                    .frame(width: proxy.size.width * CGFloat(self.progress / 100))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        isDragging = true
                        self.progress = min(max(0, Float(value.location.x / proxy.size.width * 100)), 100)
                    })
                    .onEnded({ value in
                        isDragging = false
                    })
            )
        }
        .frame(height: isDragging ? 16 : 8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SliderView(progress: .constant(50))
}
