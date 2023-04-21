//
//  DetailsView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import SwiftUI

struct DetailsView: View {
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            DetailImage(url: person.avatar)
            Text("#\(person.id)")
                .foregroundColor(.white)
                .frame(width: 50, height: 20)
                .background(.purple)
                .cornerRadius(10)
            TextView(firstName: person.first_name, lastName: person.last_name, email: person.email)
            Spacer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(person: Person(id: 1, first_name: "aa", last_name: "aaa", avatar: "", email: ""))
    }
}
struct TextView: View {
    var firstName: String
    var lastName: String
    var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("First Name:")
            Text(firstName)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Text("Last Name:")
            Text(lastName)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Text("Email:")
            Text(email)
                .foregroundColor(.gray)
                .padding(.bottom, 40)
            Text("Support Reqres")
            Text("https://reqres.in/#support-heading")
                .foregroundColor(.blue)
        }
    }
}


