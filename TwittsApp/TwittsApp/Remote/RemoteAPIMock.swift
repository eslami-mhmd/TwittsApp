//
//  RemoteAPIMock.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/12/22.
//

import Foundation

class RemoteAPIMock: RemoteAPIProtocol {
  // MARK: - Properties

    @Published private(set) var twitt: TwittResponse?
    var twittPublished: Published<TwittResponse?> { _twitt }
    var twittPublisher: Published<TwittResponse?>.Publisher { $twitt }

  // MARK: - Methods
    func fetchTwitts() async throws {
        for index in 0..<10 {
            let mockTwitt = TwittModel(identifier: String(index),
                                       text: "Text \(index)",
                                       created_at: String(Date().timeIntervalSince1970),
                                       public_metrics: PublicMetric(likeCount: 12,
                                                                    retweetCount: 1,
                                                                    quoteCount: 0,
                                                                    replyCount: 0))
            let twittResponse = TwittResponse(data: mockTwitt,
                                              errors: nil,
                                              includes: User(users:
                                                                [UserModel(identifier: "",
                                                                           username: "mohammad",
                                                                           name: "eslami",
                                                                           profile_image_url: "")]))
            self.twitt = twittResponse
        }
    }

    func addRule(ruleText: String) async throws {
    }

    func deleteRule(identifier: String) async throws {
    }

    func getRule() async throws -> String? {
        return nil
    }
}
