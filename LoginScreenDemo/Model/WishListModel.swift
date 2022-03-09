//
//  WishListModel.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import Foundation

class WishListModel: Codable, Identifiable{
    
    let id: Int
    let name: String
    let image: String
    let price: String
    let age: Int
    
    init(id: Int, name: String, image: String, price: String, age: Int){
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.age = age
    }
}
