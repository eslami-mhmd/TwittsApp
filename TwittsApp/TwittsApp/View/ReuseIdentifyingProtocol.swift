//
//  ReuseIdentifyingProtocol.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/12/22.
//

import Foundation

protocol ReuseIdentifyingProtocol {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifyingProtocol {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
