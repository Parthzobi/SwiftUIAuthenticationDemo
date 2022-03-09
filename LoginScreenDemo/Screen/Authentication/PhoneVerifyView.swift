//
//  PhoneVerifyView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 03/02/22.
//

import SwiftUI
import PhoneNumberKit

struct PhoneVerifyView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @State private var isPushed = false
    
    @State var text: String = ""
    
    @State var title = ""
    @State var alert = false
    
    var body: some View {
        
        ZStack {
            Color("ViewBGColor").edgesIgnoringSafeArea(.all)
            VScrollView{
                
                VStack{
                    Image("CompanyLogoURL").resizable().frame(width: 180.0, height: 180.0, alignment: .top).padding()
                    Text("Registration")
                        .font(.system(size: 30, design: .rounded))
                        .fontWeight(.medium)
                        .padding([.bottom, .top], 20)
                        .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    
                    Text("Enter your mobile number, we will send you \n OTP to verify later")
                        .foregroundColor(.gray)
                        .font(.system(size: 17, design: .rounded))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    
                    VStack{
                        iPhoneNumberField(nil, text: $text)
                            .flagHidden(false)
                            .prefixHidden(false)
                            .autofillPrefix(true)
                            .flagSelectable(true)
                            .font(UIFont(size: 22, weight: .light, design: .monospaced))
                            .maximumDigits(10)
                            .foregroundColor(Color.black)
                            .clearButtonMode(.whileEditing)
                            .accentColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding([.top, .leading, .trailing], 15)
                        
                        Button(action: {
                            // Do Action...
                            if isValidNumber{
                                isPushed.toggle()
                            }else{
                                self.title = "Login Error"
                                self.alert = true
                            }
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(minWidth: 100, maxWidth: UIScreen.main.bounds.width - 50, alignment: .center)
                                .background(
                                  ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                                      NavigationLink(destination: LazyDestination { OTPView() },
                                                                   isActive: self.$isPushed) { EmptyView() }
                                  }
                                )
                        }
                        .background(Color("ThemColor"))
                        .cornerRadius(40)
                        .padding()
                        .padding([.bottom, .leading, .trailing], 15)
                        .alert(isPresented: self.$alert){()->Alert in
                            return Alert(title: Text("\(self.title)"), message: Text(""), dismissButton:
                                                .default(Text("OK").fontWeight(.semibold)))
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .padding(.all, 30)
                    Spacer()
                }
                Spacer()
            }
        }.navigationBarTitle("")
    }
    
    public var isValidNumber: Bool {
        let rawNumber = self.text
        let defaultCode = PhoneNumberKit.defaultRegionCode()
        let phoneNumberKit = PhoneNumberKit()
        do {
            _ = try phoneNumberKit.parse(rawNumber, withRegion: defaultCode)
            return true
        } catch {
            return false
        }
    }
}

struct PhoneVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerifyView()
    }
}
