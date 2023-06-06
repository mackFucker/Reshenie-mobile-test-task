//
//  SimilarsFilmsCard.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SimilarsFilmsCard: View {
    
    private let mainBoundsWidht = UIScreen.main.bounds.width
    var data: SimilarFilm

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
        VStack {
            WebImage(url: URL(string: data.posterUrl))
                .resizable()
                .placeholder {
                    ActivityIndicatorView(size: 35, lineWidth: 3)
                }
                .scaledToFit()
            
                .aspectRatio(contentMode: .fill)
                .frame(width: mainBoundsWidht / 2.5, height: mainBoundsWidht / 2)
                .clipped()
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(data.nameRu)
                    .foregroundColor(Color(UIColor.label))
                    .font(.callout)

            }
            Spacer()
            
        }
        .frame(width: mainBoundsWidht / 2.5)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

