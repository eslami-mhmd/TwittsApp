//
//  Collection+Extension.swift
//  Gap
//
//  Created by eslami on 4/8/20.
//  Copyright © 2020 TSIT. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
