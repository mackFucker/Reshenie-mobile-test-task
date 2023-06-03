//
//  MovieCard.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
    
    var data: Film
    private let mainBounds = UIScreen.main.bounds.width
    
    @Environment (\.colorScheme) var colorScheme
    var backgroundColor: Color{
        if colorScheme == .dark {
            return Color(UIColor.darkText)
        }
        else {
            return .white
        }
    }
    
    private let mainBoundsHeight = UIScreen.main.bounds.height
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: data.posterURLPreview))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
            
                .aspectRatio(contentMode: .fill)
                .frame(width: mainBounds / 7 , height: mainBounds / 5)
                .clipped()
                .background(Color.gray)
                .cornerRadius(10)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(data.nameRu)
                    .foregroundColor(Color(UIColor.label))
                Text("\(data.genres[0].genre) (\(data.year))")
                    .foregroundColor(.gray)
                    .font(.caption)
                
            }
            
            Spacer()
            
        }
        .frame(height: mainBoundsHeight / 8)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

