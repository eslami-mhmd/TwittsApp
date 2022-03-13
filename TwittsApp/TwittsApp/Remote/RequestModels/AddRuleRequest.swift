//
//  AddRuleRequest.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct AddRule: Encodable {
    let add: [AddRuleValue]
}
struct AddRuleValue: Encodable {
    let value: String
}
