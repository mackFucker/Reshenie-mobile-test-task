//
//  MoviesViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 01.06.2023.
//

import SwiftUI
import Combine

final class MovieViewModel: ObservableObject {
    
    @Published var dataID: [Int] = []
    @Published var data: [Movie] = []
    
    //    @Published var filteredData: [Movie] = []
    @Published var searchText = ""
    @Published var searchIsActive = false
    
    private var cancellables = Set<AnyCancellable>()
    private var networkManager: AnyNetworkManager<URLSession>?
    
    var requestIDs: AnyCancellable?
    var requestFilms: AnyCancellable?
    
    init() {
        //        addSubscriberSearch()
        addSubscriberNetworkManagerFilmsIDs()
    }
    
    //    private func addSubscriberSearch() {
    //        $searchText
    //            .combineLatest(self.$filteredData)
    //            .debounce(for: 0.4, scheduler: DispatchQueue.main)
    //            .map(filterFilms)
    //            .sink { [weak self] (returnedData) in
    //                self?.filteredData = returnedData
    //            }
    //            .store(in: &cancellables)
    //    }
    //
    //    private func filterFilms(text: String, films: [Film]) -> [Film] {
    //        guard !text.isEmpty else {
    //            return films
    //        }
    //
    //        let lowercaseText = text.lowercased()
    //
    //        return films[0].films.filter { (film) -> Bool in
    //            return data[0].films[0].nameRu.lowercased().contains(lowercaseText)
    //        }
    //
    //    }
    
    private func addSubscriberNetworkManagerFilmsIDs() {
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        requestIDs = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1")!,
                                        method: .get,
                                        headers: ["accept": "application/json",
                                                  "X-API-KEY": "0fd0e482-e585-4c4a-bd33-26986a07b728"])
                        
        .sink(receiveCompletion: {comp in
            print (comp)},
              receiveValue: {
            val in
            
            let decode = JSONDecoder()
            let decoded = try? decode.decode(MovieIDs.self, from: val)
            
            let data = decoded!.films
            
            for film in data {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.getFilm(id: film.filmID)
//                    self.addSubscriberNetworkManagerFilms(id: film.filmID)
                }
            }
        })
    }
    
    
//    private func addSubscriberNetworkManagerFilms(id: Int) {
//        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
//
//        requestFilms = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)")!,
//                                        method: .get,
//                                        headers: ["accept": "application/json",
//                                                  "X-API-KEY": "0fd0e482-e585-4c4a-bd33-26986a07b728"])
//        .sink(receiveCompletion: {comp in
//            print (comp)},
//              receiveValue: { data in
//                let decode = JSONDecoder()
//                do {
//                    let decoded = try decode.decode(Movie.self, from: data)
//                    self.data.append(decoded)
//                } catch DecodingError.dataCorrupted(let context) {
//                    print(context)
//                } catch DecodingError.keyNotFound(let key, let context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch DecodingError.valueNotFound(let value, let context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch DecodingError.typeMismatch(let type, let context) {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch {
//                    print(error.localizedDescription)
//                }
//        })
//    }

    
//    private func addSubscriberNetworkManagerFilms(id: Int) {
//        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
//
//        //FIXME: сделать запросс по ID для получения полной информации по фильмам
//        requestFilms = networkManager?.fetch(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)")!,
//                                        method: .get,
//                                        headers: ["accept": "application/json",
//                                                  "X-API-KEY": "0fd0e482-e585-4c4a-bd33-26986a07b728"])
//
//        .sink(receiveCompletion: {comp in
//            print (comp)},
//              receiveValue: {
//
//            val in
//
//            let decode = JSONDecoder()
//            let decoded = try? decode.decode(Movie.self, from: val)
//
//            self.data.append(decoded!)
//        })
//    }

    // мутки с моделью
    func getFilm(id: Int) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("0fd0e482-e585-4c4a-bd33-26986a07b728", forHTTPHeaderField: "X-API-KEY")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            let decode = JSONDecoder()
            do {
                let decoded = try decode.decode(Movie.self, from: data)
                self.data.append(decoded)
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
