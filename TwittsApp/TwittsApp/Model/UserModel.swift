//
//  UserModel.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct UserModel: Decodable, Hashable {
    let identifier: String
    let username: String
    let name: String
    let profileImageUrl: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case username, name
        case profileImageUrl = "profile_image_url"
    }
}
