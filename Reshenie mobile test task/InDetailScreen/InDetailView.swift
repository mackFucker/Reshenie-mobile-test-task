//
//  InDetailView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct InDetailView: View {
    
    @Environment(\.dismiss) private var dismiss

    var data: Movie
    private let mainBoundsWidht = UIScreen.main.bounds.width
    private let mainBoundsHeight = UIScreen.main.bounds.height

    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                Image("Banner")
                    .resizable()
                    .background(Color.red)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                Spacer()
                
                Text(data.title)
                    .bold()
                
                Spacer()
                
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
                .padding(.trailing)
                .padding(.leading)
            }
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.purple)
            }
            .frame(width: mainBoundsWidht - 50, height: mainBoundsHeight - 150 , alignment: .topLeading)
          
        }
        .navigationBarHidden(true)
    }
}

struct InDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InDetailView(data: Movie(image: "", title: "SOSAT", genres: ["gay"], description: "ddddd", countries: ["gay land"], year: "2077"))
    }
}

