//
//  CreateAccountView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 03/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var isPushed = false
    
    @State private var fName: String = ""
    @State private var isValidfName: Bool = false
    @State private var lName: String = ""
    @State private var isValidlName: Bool = false
    
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
                    
                    FloatingLabelTextField($fName, validtionChecker: $isValidfName, placeholder: "First name", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addDisableEditingAction([.paste])
                    .isShowError(true)
                    .leftView({
                        Image.init(systemName: "person.fill")
                            .foregroundColor(.gray).padding()
                    })
                    .addValidations([.init(condition: fName.isValid(.name), errorMessage: "Invalid First name"),
                                     .init(condition: fName.count >= 2, errorMessage: "Minimum two character long")
                                    ])
                    //.floatingStyle(ThemeTextFieldStyle2())
                    .modifier(ThemeTextField())
                    
                    FloatingLabelTextField($lName, validtionChecker: $isValidlName, placeholder: "Last name", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addDisableEditingAction([.paste])
                    .isShowError(true)
                    .leftView({
                        Image.init(systemName: "person.fill")
                            .foregroundColor(.gray).padding()
                    })
                    .addValidations([.init(condition: lName.isValid(.name), errorMessage: "Invalid Last name"),
                                     .init(condition: lName.count >= 2, errorMessage: "Minimum two character long")
                                    ])
                    //.floatingStyle(ThemeTextFieldStyle2())
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
                    
                }.padding(.horizontal, 40)
                
                Spacer()
            }
            
            Button(action: {
                // Do Action...
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                self.Verify()
            }) {
                Text("Create Account")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                      ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                          NavigationLink(destination: LazyDestination { PhoneVerifyView() },
                                                       isActive: self.$isPushed) { EmptyView() }
                      }
                    )
            }
            .background(Color("ThemColor"))
            .cornerRadius(10)
            .padding(.top, 15)
            .alert(isPresented: self.$alert){()->Alert in
                return Alert(title: Text("\(self.title)"), message: Text(""), dismissButton:
                                    .default(Text("OK").fontWeight(.semibold)))
            }
            
            HStack(spacing: 5){
                Text("Already have an account")
                if self.isFromOnboading{
                    NavigationLink(destination: FloatingTextField()) {
                        Text("Login")
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemColor"))
                    }
                }else{
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Text("Login")
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemColor"))
                    }
                }
            }.padding(.top, 25)
            Spacer()
        }.navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
    
    func Verify(){
        
        let isFname:Bool = self.fName.isValid(.name)
        
        let isLname:Bool = self.lName.isValid(.name)
        
        let isEmail:Bool = self.email.isValid(.email)
        
        let isPassword:Bool = self.password.isValid(.password)
        
        if isFname && isLname && isEmail && isPassword{
            //self.title = "Login success!"
            //self.alert = true
            //settings.loggedIn = false
            //settings.navigateIn = "phone"
            self.isPushed.toggle()
        }else{
            self.title = "Login Error"
            self.alert = true
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        self.destination()
    }
}
