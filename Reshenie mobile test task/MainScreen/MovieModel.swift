//
//  ModelMovie.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 03.06.2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let kinopoiskId: Int
    let imdbId, nameRu: String
    let nameEn, nameOriginal: JSONNull?
    let posterURL, posterURLPreview: String
    let coverURL, logoURL: String
    let reviewsCount: Int
    let ratingGoodReview: Double
    let ratingGoodReviewVoteCount: Int
    let ratingKinopoisk: Double
    let ratingKinopoiskVoteCount: Int
    let ratingImdb: Double
    let ratingImdbVoteCount: Int
    let ratingFilmCritics: JSONNull?
    let ratingFilmCriticsVoteCount: Int
    let ratingAwait: JSONNull?
    let ratingAwaitCount: Int
    let ratingRFCritics: JSONNull?
    let ratingRFCriticsVoteCount: Int
    let webURL: String
    let year, filmLength: Int
    let slogan: JSONNull?
    let description, shortDescription: String
    let editorAnnotation: JSONNull?
    let isTicketsAvailable: Bool
    let productionStatus: JSONNull?
    let type: String
    let ratingMPAA: JSONNull?
    let ratingAgeLimits: String
    let countries: [Country]
    let genres: [Genre]
    let startYear, endYear: JSONNull?
    let serial, shortFilm, completed, hasImax: Bool
    let has3D: Bool
    let lastSync: String

    enum CodingKeys: String, CodingKey {
        case kinopoiskId
        case imdbId
        case nameRu, nameEn, nameOriginal
        case posterURL
        case posterURLPreview
        case coverURL
        case logoURL
        case reviewsCount, ratingGoodReview, ratingGoodReviewVoteCount, ratingKinopoisk, ratingKinopoiskVoteCount, ratingImdb, ratingImdbVoteCount, ratingFilmCritics, ratingFilmCriticsVoteCount, ratingAwait, ratingAwaitCount
        case ratingRFCritics
        case ratingRFCriticsVoteCount
        case webURL
        case year, filmLength, slogan, description, shortDescription, editorAnnotation, isTicketsAvailable, productionStatus, type
        case ratingMPAA
        case ratingAgeLimits, countries, genres, startYear, endYear, serial, shortFilm, completed, hasImax, has3D, lastSync
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
