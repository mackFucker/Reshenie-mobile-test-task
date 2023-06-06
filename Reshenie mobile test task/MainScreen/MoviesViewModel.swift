//
//  MoviesViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 01.06.2023.
//

import Foundation
import Combine

enum AppState {
    case loading
    case notFound
    case noConnection
    case normal
}

final class MovieViewModel: ObservableObject {
    
    @Published var data: [Film] = []
    @Published var filteredData: [Film] = []
    @Published var searchText = ""
    @Published var searchIsActive = false
    
    private var cancellables = Set<AnyCancellable>()
    private var networkManager: AnyNetworkManager<URLSession>?
    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"
    
    var request: AnyCancellable?
    
    @Published var appState: AppState = .normal
    
    init() {
        addSubscriberSearch()
        addSubscriberNetworkManagerFilms()
    }
    
    private func addSubscriberSearch() {
        $searchText
            .combineLatest(self.$data)
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .map(filterFilms)
            .sink { [weak self] (returnedData) in
                
                if returnedData.isEmpty && !self!.searchText.isEmpty && self!.appState != .noConnection {
                    self!.appState = .notFound
                }
                if  returnedData.isEmpty && self!.searchText.isEmpty && self!.appState != .noConnection{
                    self!.appState = .normal
                }
                
                self?.filteredData = returnedData
            }
            .store(in: &cancellables)
    }
    
    private func filterFilms(text: String, films: [Film]) -> [Film] {
        guard !text.isEmpty else {
            return [Film]()
        }
        
        let lowercaseText = text.lowercased()
        
        return films.filter { (film) -> Bool in
            return film.nameRu.lowercased().contains(lowercaseText)
        }
    }
    
    func addSubscriberNetworkManagerFilms() {
        appState = .loading
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        request = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1")!,
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
            let decoded = try? decode.decode(Movie.self, from: value)
            
            let data = decoded!.films
            self.data = data
            self.appState = .normal
        })
    }
}


