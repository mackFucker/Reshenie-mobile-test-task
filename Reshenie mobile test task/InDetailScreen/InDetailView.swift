//
//  InDetailView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct InDetailView: View {
    
    var data: Movie
    private let mainBounds = UIScreen.main.bounds.width

    var body: some View {
        ScrollView {
           
            Image("Banner")
                .background(Color.red)
            
            Text(data.title)
                .bold()
            
            VStack(alignment: .leading) {
                
                Text(data.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("жанр: ").foregroundColor(.gray).font(.caption).bold() + Text(data.genre)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Страны: ").foregroundColor(.gray).font(.caption).bold() + Text(data.countries[0])
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("год: ").foregroundColor(.gray).font(.caption).bold() + Text(data.year)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct InDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InDetailView(data: Movie(image: "", title: "SOSAT", genres: ["gay"], description: "ddddd", countries: ["gay land"], year: "2077"))
    }
}

