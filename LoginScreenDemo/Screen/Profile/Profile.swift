//
//  Profile.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import SwiftUI

struct Profile: View {
    
    @State var selectedOption: String? = nil
    
    var arrOption:[(Image, String)] = [(Image(systemName: "location.fill"), "My Address"), (Image(systemName: "person.fill"), "Account"), (Image(systemName: "bell.fill"), "Notification"), (Image(systemName: "iphone.homebutton"), "Devices"), (Image(systemName: "key.fill"), "Password"), (Image(systemName: "ellipsis.bubble.fill"), "Language"), (Image(systemName: "filemenu.and.cursorarrow"), "Logout")]
    
    
    var profileImage: some View {
        Image("CompanyLogoURL")
            .frame(width: 110, height: 110, alignment: .center)
            .scaledToFit()
            .clipShape(Circle())
            .shadow(radius: 5)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
            .padding(.leading, 10)
    }
    
    var body: some View {
        
        VStack{
            HStack{
                profileImage
                Spacer()
            }.padding()
            HStack{
                Text("Name")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                Spacer()
            }.padding(.leading, 30).padding(.bottom, 2)
            
            HStack{
                Text("Email address")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.leading, 30)
            
            NavigationView {
                
                List(1..<self.arrOption.count) { index in
                    profileOptionRow.init(selectedOption: self.$selectedOption, rowData: self.arrOption[index]).listRowSeparator(.visible)
                }.environment(\.defaultMinListRowHeight, 70).listStyle(PlainListStyle())
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
            
            Spacer()
        }
    }
}

struct profileOptionRow: View {
    
    @EnvironmentObject var settings: UserSettings
    @Binding var selectedOption: String?
    @State private var showingAlert = false
    var rowData:(Image, String)
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                rowData.0
                    .frame(width: 30, height: 30, alignment: .center).foregroundColor(.gray)
                Text(rowData.1).font(.system(size: 20, weight: .regular, design: .default))
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding()
            }
            //Rectangle().frame(height: 0.5, alignment: .bottom).foregroundColor(Color.gray)
        }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Are you sure you want to logout?"),
                message: Text(""),
                primaryButton: .destructive(Text("Logout")) {
                    LoginScreenDemoApp.userCredentials.token = ""
                    LoginScreenDemoApp.userCredentials.saveToUserDefaults()
                    withAnimation(.easeOut) {
                        settings.loggedIn = false
                        settings.navigateIn = "onboading"
                    }
                    //withAnimation(.easeInOut(duration: 2)) {
                        
                    //}
                },
                secondaryButton: .cancel()
            )
        }
        .onTapGesture {
            self.selectedOption = self.rowData.1
            if self.rowData.1 == "Logout"{
                self.showingAlert.toggle()
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
