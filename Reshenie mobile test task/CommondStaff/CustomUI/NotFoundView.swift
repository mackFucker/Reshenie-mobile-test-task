//
//  NotFound.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import SwiftUI

struct NotFoundView: View {
    
    var body: some View {
       
        Text("Не найдено")
            .font(.system(size: 16, weight: .bold, design: .default))
            .frame(width: 127, height: 38)
            .background(Color.mainlPurple)
            .foregroundColor(.white)
            .cornerRadius(25)
    }
}

