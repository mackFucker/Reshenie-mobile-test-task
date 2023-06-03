//
//  NetworkExtensions.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 02.06.2023.
//

import Foundation

extension URLSession: URLSessionProtocol {
    public typealias dataTaskProtocolType = URLSessionDataTask
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension NetworkManager: NetworkManagerProtocol {}
