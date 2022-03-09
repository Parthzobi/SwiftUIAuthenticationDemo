//
//  WishList.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import SwiftUI

struct WishList: View {
    
    var arrWishList: [WishListModel] = [.init(id: 1, name: "Test", image: "person.fill", price: "100", age: 20), .init(id: 1, name: "Test", image: "person.fill", price: "100", age: 20), .init(id: 1, name: "Test", image: "person.fill", price: "100", age: 20), .init(id: 1, name: "Test", image: "person.fill", price: "100", age: 20)]
    
    var body: some View {
        
        List {
            ForEach(arrWishList) { wishlist in
                ListCell(wishList: wishlist)
            }
        }.listStyle(PlainListStyle())
        
    }
}

struct ListCell: View{
    
    var wishList: WishListModel
    
    var MoveToBag: some View{
        Button(action: {
            print("sign up bin tapped")
        }){
            HStack {
                Text("Move to Bag")
                    .foregroundColor(.black)
                    .font(.system(size: 15))
            }
            .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
            .padding()
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
            )
        }
    }
    
    var body: some View{
        HStack{
            Image("CompanyLogoURL")
                .resizable()
                .frame(width: 100.0, height: 100.0, alignment: .center)
            VStack(alignment: .leading){
                Text("Title").font(Font.title.weight(.medium)).foregroundColor(.black)
                Text("Description").font(Font.title3.weight(.light)).foregroundColor(.black)
                Text("Age").font(Font.title3.weight(.light)).foregroundColor(.gray)
                MoveToBag
            }
            .padding(.leading, 15.0)
            Spacer()
        }.padding(10.0)
    }
    
}

struct WishList_Previews: PreviewProvider {
    static var previews: some View {
        WishList()
    }
}
