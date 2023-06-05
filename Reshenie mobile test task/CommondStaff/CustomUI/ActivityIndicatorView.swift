//
//  ActivityIndicatorView.swift
//  Reshenie mobile test task
//
//  Created by дэвид Кихтенко on 05.06.2023.
//

import SwiftUI

struct ActivityIndicatorView: View {
    
    @State var animate = false
    @State var show = false
    
    var size: CGFloat
    var lineWidth: CGFloat
    
    var body: some View {
        VStack {
            if show {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.mainlPurple, lineWidth: lineWidth)
                    .frame(width: size, height: size)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
            }
        }
        .onAppear {
            withAnimation {
                self.show = true
            }
            withAnimation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false)) {
                self.animate.toggle()
            }
        }
    }
}
