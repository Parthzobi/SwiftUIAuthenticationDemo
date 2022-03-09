//
//  CategoryModel.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import Foundation

class CategoryModel: Codable{
    
    let id: Int
    let name: String
    let image: String
    
    init(id: Int, name: String, image: String){
        self.id = id
        self.name = name
        self.image = image
    }
}
