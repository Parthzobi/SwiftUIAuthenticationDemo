//
//  LoginScreenDemoApp.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 28/01/22.
//

import SwiftUI

@main
struct LoginScreenDemoApp: App {
    
    static let userCredentials: AppModel = AppModel.restoreFromUserDefaults()
    @ObservedObject var settings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            //computedView()
            if settings.loggedIn{
                AppTabNavigation().environmentObject(settings)
            }else if settings.navigateIn == "createaccount" {
                CreateAccountView().environmentObject(settings)
            }else if settings.navigateIn == "login" {
                 FloatingTextField().environmentObject(settings)
            }else if settings.navigateIn == "phone" {
                PhoneVerifyView().environmentObject(settings)
            }else if settings.navigateIn == "otp" {
                OTPView().environmentObject(settings)
            }else{
                Onboading().environmentObject(settings).transition(.slide)
            }
        }
    }
    
    func computedView() -> some View {
        LoginScreenDemoApp.userCredentials.increment()
        if settings.loggedIn{
            return AnyView(AppTabNavigation().environmentObject(settings))
        }else if settings.navigateIn == "createaccount" {
            return AnyView(CreateAccountView().environmentObject(settings))
        }else if settings.navigateIn == "login" {
            return AnyView(FloatingTextField().environmentObject(settings))
        }else if settings.navigateIn == "phone" {
            return AnyView(PhoneVerifyView().environmentObject(settings))
        }else if settings.navigateIn == "otp" {
            return AnyView(OTPView().environmentObject(settings))
        }else{
            return AnyView(Onboading().environmentObject(settings))
        }
    }
}
