//
//  RegisterSuccessPopupView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 04/02/22.
//

import SwiftUI

struct RegisterSuccessPopupView: View {
    
    @EnvironmentObject var settings: UserSettings
    @Binding var isPresented: Bool
    
    var body: some View {
        if self.isPresented{
            ZStack{
                VStack() {
                    Spacer()
                    Image("CompanyLogoURL").resizable().frame(width: 150.0, height: 150.0, alignment: .top).clipShape(Circle())
                        .shadow(radius: 5)
                    VStack(alignment: .center, spacing: 15) {
                        Text("Congratulations")
                        .foregroundColor(Color("ThemColor"))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    
                    Text("Now you are registered")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    
                    Text("Get ready with IndoAlliz wallet")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 20, weight: .regular, design: .default))
                        
                    }.padding()
                    Button(action: {
                        // Do Action...
                        LoginScreenDemoApp.userCredentials.token = "123"
                        LoginScreenDemoApp.userCredentials.saveToUserDefaults()
                        settings.loggedIn = true
                        settings.navigateIn = "onboading"
                    }) {
                        Text("Start Now")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(minWidth: 100, maxWidth: UIScreen.main.bounds.width - 50, alignment: .center)
                            //.frame(width: UIScreen.main.bounds.width - 50, height: 65)
                    }
                    .background(Color("ThemColor"))
                    .cornerRadius(32.5)
                    .shadow(radius: 5)
                    .padding()
                }
                .background(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: (UIScreen.main.bounds.width - 100) * 1.5)
                .cornerRadius(10)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(.black.opacity(0.5))
            .transition(AnyTransition.opacity.combined(with: .scale))
        }
    }
}

struct RegisterSuccessPopupView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSuccessPopupView(isPresented: .constant(true))
    }
}
