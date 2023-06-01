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
            //на начало редактирования филтр дата
            //афк дефолт дата
            MoviesCollectionView(data: self.$viewModel.filteredData)
                .toolbar {
                    CustomNavigationBar(searchText: $viewModel.searchText, title: "Фильмы")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
