//
//  People.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import Foundation

struct Data: Codable {
    let data: [Person]
}

struct Person: Codable {
    
    let id: Int
    let first_name: String
    let last_name: String
    let avatar: String
    let email: String
}
