//
//  InDetailViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 05.06.2023.
//

import Foundation
import Combine


final class MovieInDetailViewModel: ObservableObject {

    @Published var movie: MovieInDetail?

    private var cancellables = Set<AnyCancellable>()
    private var networkManager: AnyNetworkManager<URLSession>?
    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"
    
    var request: AnyCancellable?

    @Published var appState: AppState = .loading

    
    func getFilm(id: Int) {
        appState = .loading
        movie = nil

        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        request = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)")!,
                                           method: .get,
                                           headers: ["accept": "application/json",
                                                     "X-API-KEY": "\(token)"])
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.appState = .noConnection
            case .finished:
                break
            }
        }, receiveValue: { value in
            let decode = JSONDecoder()
            let decoded = try? decode.decode(MovieInDetail.self, from: value)
            
            let data = decoded
            self.movie = decoded
            self.appState = .normal
        })
    }
}
