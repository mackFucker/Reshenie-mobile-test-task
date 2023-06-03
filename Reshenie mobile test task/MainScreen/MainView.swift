//
//  ContentView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
//            MoviesCollectionView(data: viewModel.searchIsActive ? self.$viewModel.filteredData : self.$viewModel.data)
//                .animation(.easeIn(duration: 0.2))
            
            MoviesCollectionView(data: self.$viewModel.data)
                .animation(.easeIn(duration: 0.2))
                .toolbar {
                    CustomNavigationBar(showSearchBar: $viewModel.searchIsActive,
                                        searchText: $viewModel.searchText,
                                        title: "Фильмы")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
