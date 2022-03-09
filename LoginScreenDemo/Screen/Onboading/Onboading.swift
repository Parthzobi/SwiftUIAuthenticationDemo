//
//  Onboading.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 03/02/22.
//

import SwiftUI

struct Onboading: View {
    
    @EnvironmentObject var settings: UserSettings
    var data = OnboardingDataModel.data
    
    var body: some View {
        NavigationView{
            VScrollView {
                OnboardingViewPure(data: data) {
                    print("done onboarding")
                }
            }.background(Color("ViewBGColor"))
                .frame(maxWidth: .infinity)
                .navigationBarHidden(true)
                .navigationBarTitle("")
        }
    }
}

struct Onboading_Previews: PreviewProvider {
    static var previews: some View {
        Onboading()
    }
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
