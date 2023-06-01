//
//  SearchBar.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 02.06.2023.
//

import SwiftUI

struct SearchBar: View {

    @Binding var text: String
    
    var body: some View {
        TextField("Поиск", text: $text)
            .accentColor(.gray)
    }
}
