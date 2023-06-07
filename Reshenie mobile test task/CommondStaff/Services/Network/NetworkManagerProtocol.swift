//
//  NetworkManagerProtocol.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 02.06.2023.
//

import Combine
import Foundation

public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }

    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?) -> AnyPublisher<Data, NetworkError>
}

extension NetworkManagerProtocol {
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String?, data: [String: Any]?) -> AnyPublisher<Data, NetworkError> {
        return fetch(url: url, method: method, headers: headers, token: token, data: data)
    }
}
