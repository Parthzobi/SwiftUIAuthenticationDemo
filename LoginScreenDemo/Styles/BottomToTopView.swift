//
//  BottomToTopView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 04/02/22.
//

import SwiftUI

struct BottomToTopView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //Spacer()
                content
                    //.padding(.bottom, geometry.safeAreaInsets.bottom)
                    //.background(Color.white)
                    .cornerRadius(20)
                //Spacer()
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .edgesIgnoringSafeArea(.all)
        }
        //.animation(.easeOut)
        .animation(.easeOut, value: true)
        .transition(.move(edge: .bottom))
    }
}
