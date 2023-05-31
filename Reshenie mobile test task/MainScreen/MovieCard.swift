//
//  MovieCard.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct MovieCard: View {
    
    var data: Movie
    private let mainBounds = UIScreen.main.bounds.width
    
    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Image(systemName: "bell")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: mainBounds / 7 , height: mainBounds / 5)
                .clipped()
                .background(Color.green)
                .cornerRadius(10)
                .padding(10)

            
            VStack(alignment: .leading, spacing: 10){
                Text(data.title)
                    .foregroundColor(.black)
                Text(data.genre)
                    .foregroundColor(.gray)
                    .font(.caption)

            }
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(data: Movie(image: "", title: "SOSAT", genres: ["gay"], description: "ddddd", countries: ["gay land"], year: "2077"))
    }
}
