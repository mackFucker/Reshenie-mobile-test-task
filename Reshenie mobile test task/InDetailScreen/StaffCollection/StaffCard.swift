//
//  StaffCard.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 06.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct StaffCard: View {
    
    var data: StaffModelElement
    
    @Environment (\.colorScheme) var colorScheme
    var backgroundColor: Color{
        if colorScheme == .dark {
            return Color(UIColor.darkText)
        }
        else {
            return .white
        }
    }
    private let mainBoundsWidht = UIScreen.main.bounds.width
        
    var body: some View {
        VStack(alignment: .leading){
            WebImage(url: URL(string: data.posterUrl))
                .resizable()
                .placeholder {
                    ActivityIndicatorView(size: 35, lineWidth: 3)
                }
                .scaledToFit()
            
                .aspectRatio(contentMode: .fill)
                .frame(width: mainBoundsWidht / 2.5, height: mainBoundsWidht / 2)
                .clipped()
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(data.nameRu)
                    .lineLimit(2)
                    .foregroundColor(Color(UIColor.label))
                    .font(.callout)

                Text(data.professionText)
                    .foregroundColor(.gray)
                    .font(.callout)
            }
            .padding(.leading)
            
            Spacer()
            
        }
        .frame(width: mainBoundsWidht / 2.5)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct StaffCard_Previews: PreviewProvider {
    static var previews: some View {
        StaffCard(data: StaffModelElement(staffId: 1,
                                          nameRu: "ddddd",
                                          posterUrl: "dddd",
                                          professionText: "ddddd"))
    }
}
