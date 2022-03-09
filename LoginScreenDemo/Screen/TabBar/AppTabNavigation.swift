//
//  AppTabNavigation.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 01/02/22.
//

import SwiftUI

struct AppTabNavigation: View {
    
    @EnvironmentObject var settings: UserSettings
    
    enum Tab {
        case home
        case list
        case profile
    }
    
    @State private var selection: Tab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                Dashboard()
                    .navigationTitle("BROWSE")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                print("User icon pressed...")
                            }) {
                                Image(systemName: "line.3.horizontal").imageScale(.large).foregroundColor(.black)
                            }
                        }
                    }
            }
            .tabItem {
                let homeText = Text("Home", comment: "Home menu tab title")
                Label {
                    homeText
                } icon: {
                    Image(systemName: "house.fill")
                }.accessibility(label: homeText)
            }
            .tag(Tab.home)
            
            NavigationView {
                WishList()
                    .navigationTitle("WISH LIST")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label {
                    Text("List",
                         comment: "List tab title")
                } icon: {
                    Image(systemName: "list.bullet.rectangle.fill")
                }
            }
            .tag(Tab.list)
            
            NavigationView {
                Profile()
                    .navigationBarTitle("")
                            .navigationBarHidden(true)
            }
            .tabItem {
                Label {
                    Text("Profile",
                         comment: "Profile tab title")
                } icon: {
                    Image(systemName: "person.fill")
                }
            }
            .tag(Tab.profile)
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}

