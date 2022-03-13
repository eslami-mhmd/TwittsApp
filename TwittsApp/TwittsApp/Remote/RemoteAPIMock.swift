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
        for i in 0..<10 {
            let mockTwitt = TwittModel(id: String(i),
                                       text: "Text \(i)",
                                       created_at: String(Date().timeIntervalSince1970),
                                       public_metrics: PublicMetric(like_count: 12,
                                                                    retweet_count: 1,
                                                                    quote_count: 0,
                                                                    reply_count: 0))
            let twittResponse = TwittResponse(data: mockTwitt,
                                              errors: nil,
                                              includes: User(users:
                                                                [UserModel(id: "",
                                                                           username: "mohammad",
                                                                           name: "eslami",
                                                                           profile_image_url: "")]))
            self.twitt = twittResponse
        }
    }
    
    func addRule(ruleText: String) async throws {
    }

    func deleteRule(id: String) async throws {
    }

    func getRule() async throws -> String? {
        return nil
    }
}
