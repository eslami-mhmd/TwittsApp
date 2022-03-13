//
//  TwittModel.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Foundation

struct TwittModel: Hashable, Decodable {
    let id: String
    let text: String
    let created_at: String?
    let public_metrics: PublicMetric?
}

struct PublicMetric: Decodable, Hashable {
    let like_count: Int
    let retweet_count: Int
    let quote_count: Int
    let reply_count: Int
}
