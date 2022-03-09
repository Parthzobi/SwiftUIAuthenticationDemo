//
//  Login.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 28/01/22.
//

import SwiftUI

struct Login: View {
    
    @State var userName = ""
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    
    @State var title = ""
    @State var alert = false
    @State var userNameError = ""
    @State var passwordError = ""
    @State var emailError = ""
    
    private var background: some View {
        let rectangle = RoundedRectangle(cornerRadius: 12)
        
        return rectangle
            .stroke(Color.secondary, lineWidth: 1)
            .background(rectangle.fill(Color.secondary).opacity(0.1))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Spacer()
                Image("CompanyLogoURL").resizable().frame(width: 180.0, height: 200.0, alignment: .top)
                Spacer()
                VStack{
                    
                    HStack {
                        Image.init(systemName: "person.fill")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        TextField("",text:self.$userName)
                            .autocapitalization(.none)
                            .padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(self.userNameError == "" ? Color.secondary : Color.red, lineWidth: 1)).padding(.bottom, 25)
                    //.background(background).padding(.bottom, 25)
                                .modifier(ValidatorMessageModifier.init(message: "\(self.userNameError)")).padding(.top, 10)
                                .overlay(Text("Username").foregroundColor(self.userNameError == "" ? Color.gray : Color.red).background(Color.white).padding(.leading, 15), alignment: .topLeading)
                    
                    HStack {
                        
                        Image.init(systemName: "key.fill").foregroundColor(.gray).padding(.leading, 10)
                        
                        if self.visible {
                            TextField("", text: self.$pass)
                                .autocapitalization(.none).padding()
                        } else {
                            SecureField("", text: self.$pass)
                                .autocapitalization(.none).padding()
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            //Text("Button")
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("ThemColor"))
                                .opacity(0.8)
                                .padding()
                        }
                        
                    }.overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(self.passwordError == "" ? Color.secondary : Color.red, lineWidth: 1))
                    //.background(background)
                        .padding(.bottom, 25)
                        .modifier(ValidatorMessageModifier.init(message: "\(self.passwordError)")).padding(.top, 10)
                        .overlay(Text("Password").foregroundColor(self.passwordError == "" ? Color.gray : Color.red).background(Color.white).padding(.leading, 15), alignment: .topLeading)
                    HStack {
                        
                        Image.init(systemName: "at").foregroundColor(.gray).padding(.leading, 10)
                        
                        TextField("",text:self.$email)
                            .autocapitalization(.none)
                            .padding()
                        
                    }.overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(self.emailError == "" ? Color.secondary : Color.red, lineWidth: 1))
                    //.background(background)
                        .padding(.bottom, 25)
                        .modifier(ValidatorMessageModifier.init(message: "\(self.emailError)")).padding(.top, 10)
                        .overlay(Text("Email address").background(Color.white).foregroundColor(self.emailError == "" ? Color.gray : Color.red).padding(.leading, 15), alignment: .topLeading)
                    HStack{
                        Spacer()
                        Button(action: {
                            //self.visible.toggle()
                        }) {
                            Text("Forget Password?")
                                .fontWeight(.medium)
                                .foregroundColor(Color("ThemColor"))
                        }
                    }
                    
                }.padding(.horizontal, 30)
                
                Spacer()
                
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
                    
                    NavigationLink(destination: Text("Sign up")){
                        Text("Sign up")
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemColor"))
                    }
                }.padding(.top, 25)
            }
        }
    }
    
    func Verify(){
        
        let isUsername:Bool = self.userName.isValid(.userName)
        
        let isPassword:Bool = self.pass.isValid(.password)
        
        let isEmail:Bool = self.email.isValid(.email)
        
        self.userNameError = self.userName == "" ? "Please fill in a username" : isUsername == true ? "" : "Enter valid username!"
        self.passwordError = self.pass == "" ? "Please fill in a password" : isPassword == true ? "" : "Enter valid password!"
        self.emailError = self.email == "" ? "Please fill in a email address" : isEmail == true ? "" : "Enter valid email!"
        
        if isUsername && isPassword && isEmail{
            self.title = "Login success!"
            self.alert = true
        }else{
            //            self.title = "Login Error"
            //            self.alert = true
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
