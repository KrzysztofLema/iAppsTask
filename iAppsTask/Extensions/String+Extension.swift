//
//  String+Extension.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 16/02/2025.
//

extension String {
    static func loremIpsum(paragraphs: Int) -> String {
        // swiftlint:disable line_length
        let loremIpsumText = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        // swiftlint:enable line_length

        var result = ""
        for _ in 0..<paragraphs {
            result += loremIpsumText + "\n\n"
        }
        return result
    }
}
