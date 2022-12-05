//
//  StringExtensions.swift
//  aoc2022
//
//  Created by Ben Liset on 12/5/22.
//

import Foundation

extension String {
    func splitLines() -> [String] {
        return self.split(whereSeparator: \.isNewline)
            .compactMap{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
