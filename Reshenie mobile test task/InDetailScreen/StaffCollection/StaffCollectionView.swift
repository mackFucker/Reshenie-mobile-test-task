//
//  StaffCollectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import SwiftUI

struct StaffCollectionView: View {
    let gridItem = GridItem(.flexible())
    var data : StaffModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [gridItem]) {
                ForEach(0..<data.count, id: \.self) { i in
                    StaffCard(data: data[i])
                }
            }
            .padding()
        }
    }
}
