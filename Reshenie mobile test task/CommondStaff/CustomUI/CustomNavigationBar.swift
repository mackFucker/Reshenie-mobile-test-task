//
//  CustomNavigationBar.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 01.06.2023.
//

import SwiftUI

struct CustomNavigationBar: View {
    private let mainBounds = UIScreen.main.bounds.width

    @Binding var showSearchBar: Bool
    @Binding var searchText: String
    
    var title: String
    
    var body: some View {
        HStack {
            if showSearchBar {
                searchBarView
            } else {
                titleView
            }
        }
    }
    
    var searchBarView: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.showSearchBar.toggle()
                    self.searchText = ""
                }
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.mainlPurple)
            })
            
            SearchBar(text: $searchText)
                .padding(.leading)
            
            Spacer()
        }
    }
    
    var titleView: some View {
        HStack {
            Text(title)
                .padding(.trailing, mainBounds-190)
                .font(.system(size: 25, weight: .bold))
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    self.showSearchBar.toggle()
                }
            }, label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.mainlPurple)
            })
        }
    }
}
