//
//  Dashboard.swift
//  LoginScreenDemo
//
//  Created by Ashfaq Shaikh on 02/02/22.
//

import SwiftUI

struct Dashboard: View {
    
    var arrCategory: [CategoryModel] = [.init(id: 1, name: "Test", image: "person.fill"), .init(id: 1, name: "Test", image: "person.fill"), .init(id: 1, name: "Test", image: "person.fill"), .init(id: 1, name: "Test", image: "person.fill")]
    
    init(){
        for _ in 0...2 {
            self.arrCategory.append(contentsOf: self.arrCategory)
        }
    }
    
    var body: some View {
        let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 2)
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                ForEach(arrCategory.indices){ index in
                    GridCell(category: CategoryModel.init(id: arrCategory[index].id, name: arrCategory[index].name, image: arrCategory[index].image)).frame(minWidth: (UIScreen.main.bounds.size.width / 2) - 15, maxWidth: (UIScreen.main.bounds.size.width / 2) - 15, minHeight: (UIScreen.main.bounds.size.width / 2) - 15, maxHeight: (UIScreen.main.bounds.size.width / 2) - 15, alignment: .center)
                }
            }
        }.padding(.all, 10)
    }
}

struct GridCell: View {
    var category: CategoryModel
    
    var bgImage: some View{
        return Image("natureicon").resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var body: some View {
        
        ZStack{
            bgImage
            VStack() {
                //Image(person.image)
                Image.init(systemName: category.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 50.0, height: 50.0, alignment: .center)
                    .padding()
                Text(category.name).lineLimit(1).foregroundColor(.white)
            }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
