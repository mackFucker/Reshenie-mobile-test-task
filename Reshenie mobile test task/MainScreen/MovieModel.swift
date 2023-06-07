//
//  Model.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import Foundation

struct Movie: Codable {
    let pagesCount: Int
    let films: [Film]
}

struct Film: Codable {
    let filmID: Int
    let nameRu: String
    let nameEn: String?
    let year, filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterURL, posterURLPreview: String

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, year, filmLength, countries, genres, rating, ratingVoteCount
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
}

struct Country: Codable {
    let country: String
}

struct Genre: Codable {
    let genre: String
}

