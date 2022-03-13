//
//  Collection+Extension.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
