//
//  URLSessionProtocol.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 02.06.2023.
//

import Foundation

public protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
    func dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for: URL) -> URLSession.DataTaskPublisher
}
