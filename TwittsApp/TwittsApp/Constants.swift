//
//  Constants.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/12/22.
//

import Alamofire
import Foundation

struct Constants {
    struct Network {
        static let baseURL = "https://api.twitter.com/2/tweets/"
        static let bearerToken = ""
        static let commonHeader: HTTPHeaders = HTTPHeaders([
            "Content-type": "application/json",
            "Authorization": "Bearer \(bearerToken)"
        ])
    }

    struct StringLabels {
        static let retweetsLabel = "Retweets"
        static let likesLabel = "Likes"
        static let quotesLabel = "Quotes"
        static let twittLabel = "Twitt"
        static let twittsListLabel = "Twitts List"
        static let twittSearchLabel = "Twitt Search"
    }
}
