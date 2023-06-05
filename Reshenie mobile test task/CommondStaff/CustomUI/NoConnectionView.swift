//
//  NoConnectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//
import SwiftUI

struct NoConnectionView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "icloud.slash")
                .resizable()
                .frame(width: 94, height: 81)
                .foregroundColor(.mainlPurple)
            Button("Повторить", action: {
                print("Повторить")
            }).font(.system(size: 16, weight: .bold, design: .default))

                .frame(width: 124, height: 45)
                .background(Color.mainlPurple)
                .foregroundColor(.white)
                .cornerRadius(25)
        }
    }
}

