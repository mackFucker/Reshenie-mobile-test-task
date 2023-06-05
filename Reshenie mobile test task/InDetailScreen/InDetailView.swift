//
//  InDetailView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct InDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var id: Int
    @StateObject var viewModel = MovieInDetailViewModel()
    
    private let mainBoundsWidht = UIScreen.main.bounds.width
    private let mainBoundsHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            switch viewModel.appState {
                case .loading:
                ActivityIndicatorView(size: 40, lineWidth: 5)
                case .normal:
                    InDetailMainView(data: viewModel.movie!)
                case .noConnection:
                    Image(systemName: "icloud.slash")
                    Button("Повторить", action: {
                        print("Повторить")
                    })
                    .foregroundColor(.mainlPurple)
                    .cornerRadius(10)
                case .notFound:
                    Text("Не найдено")
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.mainlPurple)
            }
            .position(x: 25, y: 60)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getFilm(id: id)
        }
    }
}

struct InDetailMainView: View {
    
    var data: MovieInDetail
    private let mainBoundsWidht = UIScreen.main.bounds.width
    private let mainBoundsHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WebImage(url: URL(string: data.posterUrl))
                .resizable()
                .placeholder {
                    ActivityIndicatorView(size: 35, lineWidth: 3)
                }
                .scaledToFit()
            
                .aspectRatio(contentMode: .fill)
                .frame(width: mainBoundsWidht, height: mainBoundsWidht * 1.5)
                .clipped()
            
            Spacer()
            
            Text(data.nameRu)
                .bold()
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                Text(data.description ?? "" )
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("жанр: ").foregroundColor(.gray).font(.caption).bold() + Text(data.genres[0].genre)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Страны: ").foregroundColor(.gray).font(.caption).bold() + Text(data.countries[0].country)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("год: ").foregroundColor(.gray).font(.caption).bold() + Text(String(data.year))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
            }
            .padding(.trailing)
            .padding(.leading)
        }
    }
}
