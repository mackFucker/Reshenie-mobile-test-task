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
    @Published var appState: AppState = .normal

    private var cancellables = Set<AnyCancellable>()
    var networkManager = AnyNetworkManager<URLSession>(manager: NetworkManager(session: URLSession.shared))

    private let url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1"
    
    init() {
        addSubscriberSearch()
        getData()
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
    
    func getData() {
        appState = .loading
        networkManager.NetworkManagerGetData(url: url) { (result: Result<Movie,
                                                                     Error>) in
            switch result {
                case .success(let data):
                    self.appState = .normal
                    self.data = data.films
                    return
                case .failure(let error):
                    print(error)
                    self.appState = .noConnection
                    break
            }
        }
    }
}


