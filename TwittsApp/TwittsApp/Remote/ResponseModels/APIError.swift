//
//  APIError.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct APIError: Decodable, Error, Hashable {
    let title: String
    let type: String
    let detail: String?
}
