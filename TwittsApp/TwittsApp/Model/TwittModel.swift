//
//  TwittModel.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Foundation

struct TwittModel: Hashable, Decodable {
    let identifier: String
    let text: String
    let createdAt: String?
    let publicMetrics: PublicMetric?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case text
        case createdAt = "created_at"
        case publicMetrics = "public_metrics"
    }
}

struct PublicMetric: Decodable, Hashable {
    let likeCount: Int
    let retweetCount: Int
    let quoteCount: Int
    let replyCount: Int

    enum CodingKeys: String, CodingKey {
        case likeCount = "like_count"
        case retweetCount = "retweet_count"
        case quoteCount = "quote_count"
        case replyCount = "reply_count"
    }
}
