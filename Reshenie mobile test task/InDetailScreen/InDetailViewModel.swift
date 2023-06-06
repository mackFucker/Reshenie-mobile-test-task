//
//  InDetailViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 05.06.2023.
//

import Foundation
import Combine


final class InDetailViewModel: ObservableObject {
    
    @Published var movie: InDetailModel?
    @Published var staffData: StaffModel?
    @Published var similarsFilms: [SimilarFilm]?
    @Published var appState: AppState = .loading

    private var cancellables = Set<AnyCancellable>()
    private var networkManager: AnyNetworkManager<URLSession>?
    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"
    
    var request: AnyCancellable?

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
                self.getStaffData(id: id)
                break
            }
        }, receiveValue: { value in
            let decode = JSONDecoder()
            let decoded = try? decode.decode(InDetailModel.self, from: value)
            
            self.movie = decoded
        })
        
    }
    
    func getStaffData(id: Int) {

        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        request = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v1/staff?filmId=\(id)")!,
                                           method: .get,
                                           headers: ["accept": "application/json",
                                                     "X-API-KEY": "\(token)"])
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.appState = .noConnection
            case .finished:
                self.getSimilarsData(id: id)
                break
            }
        }, receiveValue: { value in
            let decode = JSONDecoder()
            let decoded = try? decode.decode(StaffModel.self, from: value)
            
            self.staffData = decoded!
        })
    }
    
    func getSimilarsData(id: Int) {

        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        request = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)/similars")!,
                                           method: .get,
                                           headers: ["accept": "application/json",
                                                     "X-API-KEY": "\(token)"])
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.appState = .noConnection
            case .finished:
                self.appState = .normal
                break
            }
        }, receiveValue: { value in
            let decode = JSONDecoder()
            let decoded = try? decode.decode(SimilarFilms.self, from: value)

            self.similarsFilms = decoded?.items
        })
    }
}
