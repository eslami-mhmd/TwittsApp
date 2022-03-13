//
//  UserModel.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct UserModel: Decodable, Hashable {
    let id: String
    let username: String
    let name: String
    let profile_image_url: String
}
