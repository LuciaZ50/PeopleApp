//
//  PersonView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 19.12.2022..
//

import SwiftUI

struct PersonView: View {
    
    var imgName: String
    var personName: String
    var id: Int
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imgName)) { image in
            image
                .resizable()
                .scaledToFit()
            } placeholder: {
            Color.gray
            }.frame(width: 100, height: 100)
            Text("#" + String(id))
                .foregroundColor(.white)
                .frame(width: 50, height: 20)
                .background(.purple)
                .cornerRadius(10)
            Text(personName)
                .padding(.bottom, 20)
        }
        .frame(width: 120, height: 155)
        .cornerRadius(5)
        .shadow(color: .gray.opacity(0.7), radius: 5, x: -8, y: -8)
    }
}
    

//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView()
//    }
//}
