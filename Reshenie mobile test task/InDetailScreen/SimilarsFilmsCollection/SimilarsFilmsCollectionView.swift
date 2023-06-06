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
                    SimilarsFilmsCard(data: data[i])

//                    NavigationLink(destination: InDetailView(id: data[i])) {
//                        StaffCard()
//                            .padding(.horizontal)
//                    }
                }
            }
            .padding()
        }
    }
}
