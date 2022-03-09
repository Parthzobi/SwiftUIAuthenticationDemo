//
//  FloatingTextField.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 01/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct FloatingTextField: View {
    
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var userName: String = ""
    @State private var isValiduserName: Bool = false
    
    @State private var isPasswordShow: Bool = false
    @State private var password: String = ""
    
    @State private var email: String = ""
    @State private var isValidEmail: Bool = false
    
    @State var title = ""
    @State var alert = false
        
    var isFromOnboading = false
    
    var body: some View {
        ZStack{
            Color("ViewBGColor").edgesIgnoringSafeArea(.all)
            VScrollView {
            Spacer()
            VStack{
                Spacer()
                Image("CompanyLogoURL").resizable().frame(width: 180.0, height: 200.0, alignment: .top)
                Spacer()
                VStack{
                    FloatingLabelTextField($userName, validtionChecker: $isValiduserName, placeholder: "Username", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addDisableEditingAction([.paste])
                    .isShowError(true)
                    .leftView({
                        Image.init(systemName: "person.fill")
                            .foregroundColor(.gray).padding()
                    })
                    .addValidations([.init(condition: userName.isValid(.userName), errorMessage: "Invalid Username"),
                                     .init(condition: userName.count >= 2, errorMessage: "Minimum two character long")
                                    ])
                    //.floatingStyle(ThemeTextFieldStyle2())
                    .modifier(ThemeTextField())
                    
                    FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addDisableEditingAction([.all])
                    .isShowError(true)
                    //.isRequiredField(true, with: "Password field is required")
                    .addValidations([.init(condition: password.isValid(.password), errorMessage: "Invalid Password")])
                    .leftView({
                        Image.init(systemName: "key.fill")
                            .foregroundColor(.gray).padding()
                    })
                    .rightView({
                        Button(action: {
                            withAnimation {
                                self.isPasswordShow.toggle()
                            }
                            
                        }) {
                            Image(systemName: self.isPasswordShow ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    })
                    .isSecureTextEntry(!self.isPasswordShow)
                    .modifier(ThemeTextField())
                    
                    FloatingLabelTextField($email, validtionChecker: $isValidEmail, placeholder: "Email", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addValidations([.init(condition: email.isValid(.email), errorMessage: "Invalid Email")])
                    .leftView({
                        Image.init(systemName: "at").foregroundColor(.gray).padding()
                    })
                    .isShowError(true)
                    .keyboardType(.emailAddress)
                    .modifier(ThemeTextField())
                }.padding(.horizontal, 40)
                HStack{
                    Spacer()
                    Button(action: {
                        //self.visible.toggle()
                    }) {
                        Text("Forget Password?")
                            .fontWeight(.medium)
                            .foregroundColor(Color("ThemColor"))
                    }
                }.padding(.horizontal, 40)
                Spacer()
            }
            
            Button(action: {
                // Do Action...
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                self.Verify()
            }) {
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("ThemColor"))
            .cornerRadius(10)
            .padding(.top, 15)
            .alert(isPresented: self.$alert){()->Alert in
                return Alert(title: Text("\(self.title)"), message: Text(""), dismissButton:
                                    .default(Text("OK").fontWeight(.semibold)))
            }
            
            HStack(spacing: 5){
                Text("Don't have an account?")
                if self.isFromOnboading{
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Sign up")
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemColor"))
                    }
                }else{
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Text("Sign up")
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemColor"))
                    }
                }
            }.padding(.top, 25)
            Spacer()
        }.navigationBarHidden(true)
        }
        //Spacer()
    }
    
    func Verify(){
        
        let isUsername:Bool = self.userName.isValid(.userName)
        
        let isPassword:Bool = self.password.isValid(.password)
        
        let isEmail:Bool = self.email.isValid(.email)
        
        if isUsername && isPassword && isEmail{
            //self.title = "Login success!"
            //self.alert = true
            LoginScreenDemoApp.userCredentials.token = "123"
            LoginScreenDemoApp.userCredentials.saveToUserDefaults()
            settings.loggedIn = true
            settings.navigateIn = "onboading"
        }else{
            self.title = "Login Error"
            self.alert = true
        }
    }
}

struct ThemeTextFieldStyle2: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(.gray).errorColor(.init(UIColor.red)).backgroundColor(.secondary)
    }
}

//MARK: ViewModifier
struct ThemeTextField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField()
    }
}

/// Custom vertical scroll view with centered content vertically
///
struct VScrollView<Content>: View where Content: View {
  @ViewBuilder let content: Content
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        content
          .frame(width: geometry.size.width)
          .frame(minHeight: geometry.size.height)
      }.scrollOnOverflow()
    }
  }
}
