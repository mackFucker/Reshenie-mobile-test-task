//
//  MoviesCollectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct MoviesCollectionView : View {
    
    @Binding var grid : [Int]
    @Binding var data : [Movie]
    
    var body: some View {
        VStack {
            
            if !self.grid.isEmpty {
                
                ScrollView(.vertical, showsIndicators: false) {
                    self.gridContent()
                }
            }
        }
    }
    
    private func gridContent() -> some View {
        return VStack(spacing : 12) {
           
            ForEach(self.grid, id: \.self) { i in
                NavigationLink(destination: InDetailView(data: data[i])){
                    MovieCard(data: data[i])
                }
            }
        }
        .padding()
    }
}
