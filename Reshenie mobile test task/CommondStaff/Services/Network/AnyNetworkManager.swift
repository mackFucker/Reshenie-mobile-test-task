//
//  AnyNetworkManager.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 02.06.2023.
//

import Combine
import Foundation
import SwiftUI

public class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    
    public let session: U
    private var networkManager: AnyNetworkManager<URLSession>?
    private var request: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"

    let fetchClosure: (URL, HTTPMethod,
                       [String : String],
                       String?,
                       [String : Any]?) -> AnyPublisher<Data, NetworkError>
    
    public init<T: NetworkManagerProtocol>(manager: T) {
        fetchClosure = manager.fetch
        session = manager.session as! U
    }
        
    public func fetch(url: URL,
                      method: HTTPMethod,
                      headers: [String : String] = [:],
                      token: String? = nil,
                      data: [String: Any]? = nil) -> AnyPublisher<Data, NetworkError> {
        
        fetchClosure(url, method, headers, token, data)
    }
    
    func NetworkManagerGetData<T:Decodable>(url: String,
                                                       completion: @escaping (Result<T, Error>) -> Void) {
            request = fetch(url: URL(string: url)!,
                                               method: .get,
                                               headers: ["accept": "application/json",
                                                         "X-API-KEY": "\(token)"])
    
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                    
                case .finished:
                    break
                }
            }, receiveValue: { value in
                let decode = JSONDecoder()
                guard let decoded = try? decode.decode(T.self, from: value) else { return }

                completion(.success(decoded))
            })
        }
}
