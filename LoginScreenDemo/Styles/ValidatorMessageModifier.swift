//
//  ValidatorMessageModifier.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 31/01/22.
//

import SwiftUI

struct ValidatorMessageModifier: ViewModifier {
    
    var message:String? = ""
    
    var msg: some View {
        HStack() {
            Text( message ?? "" )
            .fontWeight(.light)
            .font(.footnote)
            .foregroundColor(Color.red)
            .isHidden(message == "" ? true : false, remove: message == "" ? true : false)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }

    func body(content: Content) -> some View {
        return content.overlay( msg, alignment: .bottom )
    }
}
