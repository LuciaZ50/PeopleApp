//
//  Extensions.swift
//  PeopleApp
//
//  Created by LuciaDecode on 19.12.2022..
//

import Foundation
import SwiftUI

//MARK: - SERVICE EXTNESIONS
extension Service {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode
        case failedToDecode(error: Error)
    }
}
extension Service.NetworkingError: Equatable {
    
    static func == (lhs: Service.NetworkingError, rhs: Service.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension Service.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidStatusCode:
            return "Status code falls into wrong range"
        case .failedToDecode:
            return "Failed to decode"
        }
    }
}
enum People {
    case people(page: Int)
}
extension People {
    
    var queryItems: [String: String?] {
        ["" : ""]
        switch self {
        case People.people(let page):
            return ["page": "\(page)"]
        default:
            return [:]
        }
    }
  
}
extension People {
    var url: URL? {
        var host: String { "reqres.in" }
        var path: String { "/api/users" }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        queryItems.forEach { item in
                    requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
                }
        return urlComponents.url
    }
}

//MARK: - HOMEVIEWMODEL EXTNESIONS
extension HomeViewModel {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode
        case failedToDecode(error: Error)
    }
    enum Submitting {
        case successful
        case unsuccessful
        case submitting
    }
    
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
    }
}

extension HomeViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error),
                .validation(let error):
            return error.errorDescription
        }
    }
}



//MARK: - VALIDATOR EXTNESIONS
extension Validator {
    enum ValidatorError: LocalizedError {
        case invalidName
        case invalidSurname
        case invalidJob
    }
}

extension Validator.ValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "First name can't be empty"
        case .invalidSurname:
            return "Last name can't be empty"
        case .invalidJob:
            return "Job can't be empty"
        }
    }
}

