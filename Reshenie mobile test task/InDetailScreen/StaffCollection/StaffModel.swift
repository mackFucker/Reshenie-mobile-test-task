//
//  StaffModel.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import Foundation


struct StaffModelElement: Codable {
    let staffId: Int
    let nameRu: String
    let posterUrl: String
    let professionText: String
}

typealias StaffModel = [StaffModelElement]
