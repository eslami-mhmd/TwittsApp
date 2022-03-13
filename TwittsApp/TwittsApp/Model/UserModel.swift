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
    let profile_image_url: String
}
