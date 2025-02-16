import SwiftUI
import UIKit

@Observable
final class OrientationObserver {
    var orientation: UIDeviceOrientation = UIDevice.current.orientation

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func orientationChanged() {
        orientation = UIDevice.current.orientation
    }
}

struct ToolbarHeightModifier: ViewModifier {
    @Binding var height: CGFloat
    var orientationObserver = OrientationObserver()

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { _ in
                    Color.clear.onAppear {
                        updateHeight()
                    }
                    .onChange(of: orientationObserver.orientation) { _, _ in
                        updateHeight()
                    }
                }
            )
    }

    private func updateHeight() {
        let window = UIApplication.shared.windows.first
        let safeAreaBottom = window?.safeAreaInsets.bottom ?? 0
        let isLandscape = UIDevice.current.orientation.isLandscape

        let baseToolbarHeight: CGFloat = isLandscape ? 32 : 49

        let adjustedSafeArea: CGFloat = isLandscape ? min(safeAreaBottom, 21) : safeAreaBottom

        height = baseToolbarHeight + adjustedSafeArea
    }
}

extension View {
    func measureToolbarHeight(height: Binding<CGFloat>) -> some View {
        modifier(ToolbarHeightModifier(height: height))
    }
}
