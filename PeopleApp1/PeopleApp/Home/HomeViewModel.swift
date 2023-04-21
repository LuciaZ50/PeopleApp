//
//  HomeViewModel.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    private let service: Service
    @Published var people: [Person]?
    @Published var newPerson = NewPerson()
    @Published var isError = false
    @Published var error: FormError?
    @Published var isLoading = false
    @Published var state: Submitting?
    
    private let validator = Validator()
    
    init(service: Service) {
        self.service = service
    }
    
    
    func getPeople(atPage: String) async throws {
        isLoading = true
        do {
            self.people = try await service.fetchPeople(atPage: atPage)
            self.isLoading = false
        } catch {
            self.isError = true
            self.error = .networking(error: error as! Service.NetworkingError)
            self.isLoading = false
            throw NetworkingError.failedToDecode(error: error)
        }
    }
    
    func post(newPerson: NewPerson?) async throws {
        
        do {
            try validator.validate(newPerson!)
            self.state = .submitting
            
            await Service().postPerson(newPerson: newPerson) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let result):
                        print(result)
                        self.isError = false
                        self.state = .successful
                    case .failure(let error):
                        print(error)
                        self.isError = true
                        self.error = .networking(error: error as! Service.NetworkingError)
                        self.state = .unsuccessful
                        print(error)
                    }
                }
            }
        } catch {
            self.isError = true
            self.error = .validation(error: error as! Validator.ValidatorError)
            self.state = .unsuccessful
            throw NetworkingError.failedToDecode(error: error)
        }
        
    }
}


