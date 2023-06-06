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
    @StateObject var viewModel = InDetailViewModel()
    
    private let mainBoundsWidht = UIScreen.main.bounds.width
    private let mainBoundsHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            switch viewModel.appState {
            case .loading:
                ActivityIndicatorView(size: 40, lineWidth: 5)
                
            case .normal:
                InDetailMainView(data: viewModel.movie!,
                                 staffData: viewModel.staffData!,
                                 similarFilms: viewModel.similarsFilms!)
                
            case .noConnection:
                NoConnectionView(inDetailReload: viewModel.getFilm,
                                 id: id)
                
            case .notFound:
                NotFoundView()
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.mainlPurple)
            }
            .position(x: 25, y: 50)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getFilm(id: id)
        }
    }
}

struct InDetailMainView: View {
    
    var data: InDetailModel
    var staffData: StaffModel
    var similarFilms: [SimilarFilm]?
    
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
                .font(.title)
                .bold()
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                Text(data.description ?? "" )
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("жанр: ").foregroundColor(.gray).font(.callout).bold() + Text(data.genres[0].genre)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Страны: ").foregroundColor(.gray).font(.callout).bold() + Text(data.countries[0].country)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("год: ").foregroundColor(.gray).font(.callout).bold() + Text(String(data.year))
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
                
            }
            .padding(.trailing)
            .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading){
                
                Text("Команда съемки:")
                    .bold()
                    .padding(.leading, 10)
                
                StaffCollectionView(data: staffData)
                
                Spacer()
                
                if !similarFilms!.isEmpty {
                    Text("Похожие фильмы:")
                        .bold()
                        .padding(.leading, 10)
                    
                    SimilarsFilmsCollectionView(data: similarFilms!)
                        .padding(.leading, 10)
                }
            }
        }
    }
}
