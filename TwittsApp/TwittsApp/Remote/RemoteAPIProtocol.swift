//
//  RemoteAPIProtocol.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

protocol RemoteAPIProtocol {
    // Wrapped value
    var twitt: TwittResponse? { get }
    // (Published property wrapper)
    var twittPublished: Published<TwittResponse?> { get }
    // Publisher
    var twittPublisher: Published<TwittResponse?>.Publisher { get }
    
    func fetchTwitts() async throws
    func addRule(ruleText: String) async throws
    func deleteRule(id: String) async throws
    func getRule() async throws -> String?
}
