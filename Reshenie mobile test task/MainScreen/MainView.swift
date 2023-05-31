//
//  ContentView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI


struct MainView: View {
    
    @State var mocableDataFavorites: [Movie] = [Movie(image: "", title: "Это всё?", genres: ["gay"], description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики", countries: ["gay land"], year: "2077"),
                                                Movie(image: "", title: "SOSAT", genres: ["gay"], description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики", countries: ["gay land"], year: "2077"),
                                                Movie(image: "", title: "SOSAT2", genres: ["gay"], description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики", countries: ["gay land"], year: "2077")]
    
    @State var grid : [Int] = []
    
    var body: some View {
        NavigationStack {
            MoviesCollectionView(grid: self.$grid, data: self.$mocableDataFavorites)
                .navigationTitle("Фильмы")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.purple)
                        }
                    }
                }
                .onAppear {
                    grid = []
                    self.generateGrid()
                }
        }
    }
    
    func generateGrid() {
        for i in 0..<$mocableDataFavorites.count {
            
            grid.append(i)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
