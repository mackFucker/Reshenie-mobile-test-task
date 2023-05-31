//
//  Model.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import Foundation

struct Movie {
    var image: String
    
    var title: String
    var genres: [String]

    var genre: String{
        return self.genres[0]
    }
    
    var description: String
    var countries: [String]
    var year: String
}
