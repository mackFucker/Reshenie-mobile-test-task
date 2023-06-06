//
//  Reshenie_mobile_test_taskApp.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 31.05.2023.
//

import SwiftUI

@main
struct Reshenie_mobile_test_taskApp: App {
    var body: some Scene {
        WindowGroup {
            InDetailView(id: 435, viewModel: InDetailViewModel())
        }
    }
}
