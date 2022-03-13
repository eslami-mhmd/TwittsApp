//
//  DeleteRuleRequest.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation

struct DeleteRule: Encodable {
    let delete: DeleteRuleValue
}
struct DeleteRuleValue: Encodable {
    let ids: [String]
}
