//
//  NoConnectionView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//
import SwiftUI

struct NoConnectionView: View {
    
    let mainReload: () -> Void
    let inDetailReload: (Int) -> Void
    let id: Int?
    
    init(mainReload: @escaping () -> Void) {
        self.mainReload = mainReload
        self.inDetailReload = { _ in }
        self.id = nil
    }
    
    init(inDetailReload: @escaping (Int) -> Void,
         id: Int?) {
        self.mainReload = {}
        self.inDetailReload = inDetailReload
        self.id = id
    }
    
    var body: some View {
        VStack {
            Image(systemName: "icloud.slash")
                .resizable()
                .frame(width: 94, height: 81)
                .foregroundColor(.mainlPurple)
            Button("Повторить", action: {
                guard id != nil else {
                    mainReload()
                    return
                }
                inDetailReload(id!)
                
            }).font(.system(size: 16, weight: .bold, design: .default))
            
                .frame(width: 124, height: 45)
                .background(Color.mainlPurple)
                .foregroundColor(.white)
                .cornerRadius(25)
        }
    }
}

