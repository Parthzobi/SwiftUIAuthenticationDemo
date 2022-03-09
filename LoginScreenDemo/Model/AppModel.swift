//
//  AppModel.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import Foundation

class AppModel: Codable {
    static let StorageKey = "AppOpenCount"
    static let Zobitoken = "Zobitoken"
    
    var count: Int = 0
    var token: String = ""
    
    init(count: Int, token: String) {
        self.count = count
        self.token = token
    }
    func increment() {
        count += 1
    }
    func isEven() -> Bool  {
        count % 2 == 0
    }
    func isLogin() -> Bool  {
        token != ""
    }
    static func restoreFromUserDefaults() -> AppModel {
        let defaults = UserDefaults.standard
        let count = defaults.integer(forKey: AppModel.StorageKey)
        let token = defaults.string(forKey: AppModel.Zobitoken) ?? ""
        return AppModel(count: count, token: token)
    }
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(self.count, forKey: AppModel.StorageKey)
        defaults.set(self.token, forKey: AppModel.Zobitoken)
    }
}
