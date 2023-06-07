//
//  InDetailCollectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import SwiftUI 

struct SimilarsFilmsCollectionView: View {
    let gridItem = GridItem(.flexible())
    var data : [SimilarFilm]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [gridItem]) {
                ForEach(0..<data.count, id: \.self) { i in
                    NavigationLink(destination: InDetailView(viewModel: InDetailViewModel(id: data[i].filmId))) {
                        SimilarsFilmsCard(data: data[i])
                    }
                }
            }
            .padding()
        }
    }
}
