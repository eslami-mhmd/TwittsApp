//
//  TwittsRepository.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Combine
import Foundation

class TwittsRepository: TwittsRepositoryProtocol {
  // MARK: - Properties
    let remoteAPI: RemoteAPIProtocol
    @Published private(set) var twitt: TwittResponse?
    var twittPublished: Published<TwittResponse?> { _twitt }
    var twittPublisher: Published<TwittResponse?>.Publisher { $twitt }
    var anyCancel: Set<AnyCancellable> = []

  // MARK: - Methods
    public init(remoteAPI: RemoteAPIProtocol) {
        self.remoteAPI = remoteAPI
    }

    func fetchTwitts() async throws {
        remoteAPI.twittPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] twitt in
                self?.twitt = twitt
            }.store(in: &anyCancel)
        return try await remoteAPI.fetchTwitts()
    }

    func updateRule(ruleText: String) async throws {
        if let identifier = try await remoteAPI.getRule() {
            try await remoteAPI.deleteRule(identifier: identifier)
            try await remoteAPI.addRule(ruleText: ruleText)
        } else {
            try await remoteAPI.addRule(ruleText: ruleText)
        }
    }

}
