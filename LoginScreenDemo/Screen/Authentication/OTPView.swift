//
//  OTPView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 03/02/22.
//

import SwiftUI

struct OTPView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @State var text: String = ""
    @State var isEditing: Bool = false
    @State var isActive = false
    @State var isPresented = false
    
    var body: some View {
        
        ZStack {
            
            Color("ViewBGColor").edgesIgnoringSafeArea(.all)
            
            VScrollView{
                
                VStack{
                    Image("CompanyLogoURL").resizable().frame(width: 180.0, height: 180.0, alignment: .top).padding()
                    Text("Verification")
                        .font(.system(size: 30, design: .rounded))
                        .fontWeight(.medium)
                        .padding([.bottom, .top], 20)
                        .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    
                    Text("Enter 4 digit number, that sent to \n +91 8140470249")
                        .foregroundColor(.gray)
                        .font(.system(size: 17, design: .rounded))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    
                    VStack{
                        
                        PincodeView(isActive: self.$isActive) { str in
                            print(str)
                            self.text = str
                            self.isActive = str.count != 4
                        }.frame(minWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width, maxHeight: 80, alignment: .center)
                        
                        Button(action: {
                            // Do Action...
                            //self.createAccountFunction()
                            if self.text.count == 4{
                                //settings.loggedIn = true
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.isPresented.toggle()
                                }
                            }
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(minWidth: 100, maxWidth: UIScreen.main.bounds.width - 50, alignment: .center)
                        }
                        .background(Color("ThemColor"))
                        .cornerRadius(40)
                        .padding()
                        .padding([.bottom, .leading, .trailing], 15)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .padding(.all, 30)
                    Spacer()
                }.onAppear {
                    self.isActive.toggle()
                }
                Spacer()
            }
            RegisterSuccessPopupView(isPresented: $isPresented).offset(y: -30)
            
        }.navigationBarTitle("")
            .navigationBarBackButtonHidden(isPresented)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

struct PincodeView: UIViewRepresentable {
    
    @Binding var isActive: Bool
    var changeTextHandler: (String) -> ()
    
    func makeUIView(context: Context) -> PinCodeInputView<UnderlineItemView> {
        let pinCodeInputView: PinCodeInputView<UnderlineItemView> = .init(
            digit: 4,
            itemSpacing: 10,
            itemFactory: {
                return UnderlineItemView()
            })
        return pinCodeInputView
    }
    
    func updateUIView(_ uiView: PinCodeInputView<UnderlineItemView>, context: Context) {
        if isActive{
            uiView.becomeFirstResponder()
        }else{
            uiView.resignFirstResponder()
        }
        uiView.set(changeTextHandler: self.changeTextHandler)
        uiView.set(
            appearance: .init(
                itemSize: CGSize(width: 44, height: 68),
                font: .systemFont(ofSize: 28, weight: .bold),
                textColor: .black,
                backgroundColor: UIColor.red,
                cursorColor: UIColor.blue,
                cornerRadius: 8,
                borderColor: UIColor.red
            )
        )
    }
}
