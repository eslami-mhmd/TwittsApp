//
//  APIResponse.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

protocol APIResponseProtocol: Decodable {
    var errors: [APIError]? { get }
}
