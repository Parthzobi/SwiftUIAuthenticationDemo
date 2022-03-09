//
//  OnboardingStepView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 03/02/22.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel
    
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                .padding(.bottom, 50)
            
            Text(data.heading)
                .font(.system(size: 25, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
            
            Text(data.text)
                .foregroundColor(.gray)
                .font(.system(size: 17, design: .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
        }
        .padding()
        .contentShape(Rectangle())
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var data = OnboardingDataModel.data[0]
    static var previews: some View {
        OnboardingStepView(data: data)
    }
}
