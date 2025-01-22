//
//  ArrayHelper.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/22/25.
//


public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
