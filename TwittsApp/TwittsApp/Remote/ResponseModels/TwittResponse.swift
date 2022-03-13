//
//  TwittResponse.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct TwittResponse: Decodable, APIResponseProtocol, Hashable {
    let data: TwittModel?
    let errors: [APIError]?
    let includes: User?
}

struct User: Decodable, Hashable {
    let users: [UserModel]
}
