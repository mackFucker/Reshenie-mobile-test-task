//
//  MoviesViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 01.06.2023.
//

import SwiftUI
import Combine

final class MovieViewModel: ObservableObject {
    
    @Published var data: [Movie] = [Movie(image: "",
                                          title: "Это всё?",
                                          genres: ["gay"],
                                          description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики",
                                          countries: ["gay land"], year: "2077"),
                                    Movie(image: "",
                                          title: "SOSAT",
                                          genres: ["gay"],
                                          description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики",
                                          countries: ["gay land"], year: "2077"),
                                    Movie(image: "",
                                          title: "SOSAT2",
                                          genres: ["gay"],
                                          description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики",
                                          countries: ["gay land"], year: "2077")]
    
    @Published var filteredData = [Movie]()
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(self.$data)
            .map(filterFilms)
            .sink { [weak self] (returnedData) in
                self?.filteredData = returnedData
            }
            .store(in: &cancellables)
    }
    
    private func filterFilms(text: String, films: [Movie]) -> [Movie] {
        guard !text.isEmpty else {
            return data
        }
        
        let lowercaseText = text.lowercased()
        
        return data.filter { (film) -> Bool in
            return film.title.lowercased().contains(lowercaseText)
        }
    }
    
    
}
