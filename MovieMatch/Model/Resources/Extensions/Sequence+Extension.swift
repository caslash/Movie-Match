//
//  Sequence+Extension.swift
//  MovieMatch
//
//  Created by Cameron Slash on 16/2/22.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
