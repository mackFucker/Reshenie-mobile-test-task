//
//  SimilarFilmsModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 07.06.2023.
//

import Foundation

struct SimilarFilms: Codable {
    let total: Int
    let items: [SimilarFilm]
}

// MARK: - Item
struct SimilarFilm: Codable {
    let filmId: Int
    let nameRu: String
    let posterUrl, posterUrlPreview: String
    let relationType: RelationType
}

enum RelationType: String, Codable {
    case similar = "SIMILAR"
}
