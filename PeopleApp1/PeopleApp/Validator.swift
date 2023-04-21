//
//  Validator.swift
//  PeopleApp
//
//  Created by LuciaDecode on 20.12.2022..
//

import Foundation

struct Validator {
    
    func validate(_ person: NewPerson) throws {
        if person.firstName.isEmpty {
            throw ValidatorError.invalidName
        } else if person.lastname.isEmpty {
            throw ValidatorError.invalidSurname
        } else if person.job.isEmpty {
            throw ValidatorError.invalidJob
        }
    }
}


