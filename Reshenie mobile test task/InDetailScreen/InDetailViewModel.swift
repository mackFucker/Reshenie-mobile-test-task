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
    @Published var appState: AppState = .normal
    @Published var id: Int
    
    private let urlFilm: String
    private let urlStaff: String
    private let urlSimilar: String
    private var cancellables = Set<AnyCancellable>()
    
    private var token = "0fd0e482-e585-4c4a-bd33-26986a07b728"

    var request: AnyCancellable?
    var networkManager = AnyNetworkManager<URLSession>(manager: NetworkManager(session: URLSession.shared))
    
    init(id: Int) {
        self.id = id
        urlFilm = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)"
        urlStaff = "https://kinopoiskapiunofficial.tech/api/v1/staff?filmId=\(id)"
        urlSimilar = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)/similars"
        
        self.getData()
    }
    
    func getData() {
        appState = .loading
        networkManager.NetworkManagerGetData(url: urlFilm) { (result: Result<InDetailModel,
                                                                         Error>) in
            switch result {
            case .success(let data):
                self.movie = data
                self.getStaffData()
            case .failure(_):
                self.appState = .noConnection
                break
            }
        }
    }
    
    private func getStaffData() {
        networkManager.NetworkManagerGetData(url: urlStaff){ (result: Result<StaffModel,
                                                                         Error>) in
            switch result {
            case .success(let data):
                self.staffData = data
                self.getSimilarData()
            case .failure(_):
                self.appState = .noConnection
                break
            }
        }
    }
    
    private func getSimilarData() {
        networkManager.NetworkManagerGetData(url: urlSimilar){ (result: Result<SimilarFilms,
                                                                           Error>) in
            switch result {
            case .success(let data):
                self.similarsFilms = data.items
                self.appState = .normal
            case .failure(_):
                self.appState = .noConnection
                break
            }
        }
    }
}
