//
//  RuleResponse.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct RuleResponse: Decodable, APIResponseProtocol {
    let data: [RuleValuesResponse]?
    let errors: [APIError]?
}
struct RuleValuesResponse: Decodable {
    let id: String
    let value: String
}
