//
//  MoviesViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 01.06.2023.
//

import SwiftUI
import Combine

final class MovieViewModel: ObservableObject {
    
    @Published var data: [Movie] = []
    
    @Published var filteredData: [Movie] = []
    @Published var searchText = ""
    @Published var searchIsActive = false
    
    private var cancellables = Set<AnyCancellable>()
    private var networkManager: AnyNetworkManager<URLSession>?

    var res: AnyCancellable?

    init() {
        addSubscriberSearch()
        addSubscriberNetworkManager()
    }
    
    private func addSubscriberSearch() {
        $searchText
            .combineLatest(self.$data)
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .map(filterFilms)
            .sink { [weak self] (returnedData) in
                self?.filteredData = returnedData
            }
            .store(in: &cancellables)
    }
    
    private func filterFilms(text: String, films: [Movie]) -> [Movie] {
        guard !text.isEmpty else {
            return [Movie]()
        }

        let lowercaseText = text.lowercased()

        return data.filter { (film) -> Bool in
            return film.films[0].nameRu.lowercased().contains(lowercaseText)
        }
        
    }
    
    private func addSubscriberNetworkManager() {
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        res = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1")!,
                                    method: .get,
                                    headers: ["accept": "application/json",
                                              "X-API-KEY": "0fd0e482-e585-4c4a-bd33-26986a07b728"])
        
            .sink(receiveCompletion: {comp in
                print (comp)},
                  receiveValue: {
                val in
                let decode = JSONDecoder()
                let decoded = try? decode.decode(Movie.self, from: val)
                print([decode])
                
                self.data = [decoded!]
                
                print(self.data)
            })

    }
}
