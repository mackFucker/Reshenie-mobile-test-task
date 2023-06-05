//
//  InDetailViewModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 05.06.2023.
//

import Foundation

final class MovieInDetailViewModel: ObservableObject {

    @Published var movie: MovieInDetail?
    @Published var appState: AppState = .loading

    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"
  
    func getFilm(id: Int) {
        
        movie = nil

        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("\(token)", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let decoded = try JSONDecoder().decode(MovieInDetail.self, from: data!)
                DispatchQueue.main.async {
                    self.movie = decoded
                    self.appState = .normal
                }
            } catch {
                print(error._code)
            }
        }.resume()
    }
}
