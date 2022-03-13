//
//  Repository.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Foundation

protocol TwittsRepositoryProtocol {
    // Wrapped value
    var twitt: TwittResponse? { get }
    // (Published property wrapper)
    var twittPublished: Published<TwittResponse?> { get }
    // Publisher
    var twittPublisher: Published<TwittResponse?>.Publisher { get }

    func fetchTwitts() async throws
    func updateRule(ruleText: String) async throws
}
