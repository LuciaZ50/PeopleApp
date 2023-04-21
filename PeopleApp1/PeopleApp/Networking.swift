//
//  Networking.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import Foundation

class Service {
   
    func fetchPeople(atPage: String?) async throws -> [Person] {
        
        let pageNumber = atPage ?? "1"
        
        guard let url = URL(string: "https://reqres.in/api/users?delay=2&page=\(pageNumber)") else {
            throw NetworkingError.invalidUrl
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonData = data
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Data.self, from: jsonData)
            return decodedData.data
        } catch {
            throw NetworkingError.failedToDecode(error: error)
        }
    }
    
    
    func postPerson(newPerson: NewPerson?, completion: @escaping (Result<String, Error>) -> Void) async {
        
        if let url = URL(string: "https://reqres.in/api/users?delay=2") {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                let data = newPerson
                
                let encoder = JSONEncoder()
                let dataBody = try encoder.encode(data)
                request.httpBody = dataBody
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if (response as! HTTPURLResponse).statusCode == 201 {
                        completion(.success("success"))
                    } else {
                        print("ERROR")
                        completion(.failure(NetworkingError.invalidStatusCode))
                    }
                    
                }
                task.resume()
                
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        } else {
            completion(.failure(NetworkingError.invalidUrl))
        }
    }
}

