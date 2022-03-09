//
//  AppRootView.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import SwiftUI

class UserSettings: ObservableObject{
    
    @Published var loggedIn : Bool = LoginScreenDemoApp.userCredentials.isLogin()
    @Published var navigateIn : String = "onboading"
}

