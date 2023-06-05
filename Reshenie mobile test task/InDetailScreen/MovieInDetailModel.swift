//
//  ModelMovie.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 03.06.2023.
//

import Foundation

struct MovieInDetail: Codable {
    let kinopoiskId: Int?
    let nameRu: String
    let posterUrl: String
    let posterUrlPreview: String
    let year: Int
    let filmLength: Int
    let slogan: String?
    let description: String?
    let shortDescription: String?
    let countries: [Country]
    let genres: [Genre]
}

