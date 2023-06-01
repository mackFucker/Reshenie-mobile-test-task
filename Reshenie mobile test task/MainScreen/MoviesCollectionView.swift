//
//  MoviesCollectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct MoviesCollectionView : View {
        
    @Binding var data : [Movie]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            if self.data.count != 0 {
                
                ForEach(0..<data.count, id: \.self) { i in
                    NavigationLink(destination: InDetailView(data: data[i])) {
                        MovieCard(data: data[i])
                            .padding(.horizontal)
                    } 
                }
            }
        }
    }
}

