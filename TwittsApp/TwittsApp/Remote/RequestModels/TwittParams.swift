//
//  TwittParams.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/13/22.
//

import Foundation

struct TwittParams: Encodable {
    let tweetFields: String?
    let expansions: String?
    let userFields: String?

    enum CodingKeys: String, CodingKey {
        case tweetFields = "tweet.fields"
        case expansions
        case userFields = "user.fields"
    }
}

enum TwittFields: String, Encodable {
    case createdAt
    case publicMetrics

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case publicMetrics = "public_metrics"
    }
}
enum TwittExpansions: String, Encodable {
    case authorId

    enum CodingKeys: String, CodingKey {
        case authorId = "author_id"
    }
}
enum UserFields: String, Encodable {
    case profileImageUrl

    enum CodingKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
    }
}
