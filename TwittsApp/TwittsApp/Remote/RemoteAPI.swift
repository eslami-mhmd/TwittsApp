//
//  RemoteAPI.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Alamofire
import Foundation

class RemoteAPI: RemoteAPIProtocol {
  // MARK: - Properties
    enum TwittFields: String, Encodable {
        case created_at
        case public_metrics
    }
    enum TwittExpansions: String, Encodable {
        case author_id
    }
    enum UserFields: String, Encodable {
        case profile_image_url
    }
    struct TwittParams: Encodable {
        let tweetFields: String?
        let expansions: String?
        let userFields: String?

        enum CodingKeys: String, CodingKey {
            case tweetFields = "tweet.fields"
            case expansions
            case userFields = "user.fields"
        }
    }

    @Published private(set) var twitt: TwittResponse?
    var twittPublished: Published<TwittResponse?> { _twitt }
    var twittPublisher: Published<TwittResponse?>.Publisher { $twitt }

  // MARK: - Methods
    private func joinParamValues<T: RawRepresentable>(values: [T]) -> String where T.RawValue == String {
        return values.map({ $0.rawValue }).joined(separator: ",")
    }

    func fetchTwitts() async throws {
        if let streamURL = URL(string: Constants.Network.baseURL.appending("search/stream")) {
            let params = TwittParams(tweetFields: joinParamValues(values: [
                TwittFields.created_at,
                TwittFields.public_metrics]),
                                     expansions: TwittExpansions.author_id.rawValue,
                                     userFields: UserFields.profile_image_url.rawValue)
            let streamTask = AF.streamRequest(streamURL,
                                              method: .get,
                                              parameters: params,
                                              headers: Constants.Network.commonHeader)
                .streamTask()
            for await result in streamTask.streamingDecodables(TwittResponse.self) {
                twitt = result.value
            }
        }
    }

    func addRule(ruleText: String) async throws {
        let rule = AddRule(add: [AddRuleValue(value: ruleText)])
        let jsonData = try JSONEncoder().encode(rule)
        if let url = URL(string: Constants.Network.baseURL.appending("search/stream/rules")) {
            var urlRequest = try URLRequest(url: url, method: .post, headers: Constants.Network.commonHeader)
            urlRequest.httpBody = jsonData

            let result = try await AF.request(urlRequest)
                .serializingDecodable(RuleResponse.self).value
            if let errors = result.errors, let error = errors.first {
                throw error
            }
        }
    }

    func deleteRule(identifier: String) async throws {
        let rule = DeleteRule(delete: DeleteRuleValue(ids: [identifier]))
        let jsonData = try JSONEncoder().encode(rule)

        if let url = URL(string: Constants.Network.baseURL.appending("search/stream/rules")) {
            var urlRequest = try URLRequest(url: url, method: .post, headers: Constants.Network.commonHeader)
            urlRequest.httpBody = jsonData

            let result = try await AF.request(urlRequest)
                .serializingDecodable(RuleDeleteReponse.self).value
            if let errors = result.errors, let error = errors.first {
                throw error
            }
        }
    }

    func getRule() async throws -> String? {
        if let getURL = URL(string: Constants.Network.baseURL.appending("search/stream/rules")) {
            let urlRequest = try URLRequest(url: getURL, method: .get, headers: Constants.Network.commonHeader)

            let result = try await AF.request(urlRequest)
                .serializingDecodable(RuleResponse.self).value
            if let errors = result.errors, let error = errors.first {
                throw error
            }
            return result.data?.first?.identifier
        }
        return nil
    }
}
