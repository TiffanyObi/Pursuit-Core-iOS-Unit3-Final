//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Tiffany Obi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsAPIClient {
    
     static func getElements(completion: @escaping (Result<[Element],AppError>) -> ()) {
           
           let elementsEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
           guard let url = URL(string: elementsEndpoint) else {
               completion(.failure(.badURL(elementsEndpoint)))
               return
           }
           
           let request = URLRequest(url: url)
           
           NetworkHelper.shared.performDataTask(with: request) { (result) in
            
               switch result {
               case .failure(let appError):
                   completion(.failure(.networkClientError(appError)))
                   
               case .success(let elements):
                   
                   do {
                       let elementsList = try JSONDecoder().decode([Element].self, from: elements)
                    
                       completion(.success(elementsList))
                   } catch {
                       completion(.failure(.decodingError(error)))
                   }
               }
           }
           
       }
    
    static func favoriteElement(for favorite: Element, completion: @escaping (Result<Bool,AppError>)->()) {
        
        let endpointURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
                
                guard let url = URL(string: endpointURLString) else {
                    completion(.failure(.badURL(endpointURLString)))
                    return
                }
                
              
                
                do {
                    let data = try JSONEncoder().encode(favorite)
                    
                  
                    var request = URLRequest(url: url)
                    
                    
                    request.httpMethod = "POST"
                    
                    
                    request.addValue("application/json", forHTTPHeaderField: "Content-type")
                    
                   
                    request.httpBody = data
                    
                    
                    NetworkHelper.shared.performDataTask(with: request) { (result) in
                        switch result {
                        case .failure(let appError):
                            completion(.failure(.networkClientError(appError)))
                            
                        case .success:
                            completion(.success(true))
                        }
                    }
                    
                } catch {
                    
                    completion(.failure(.encodingError(error)))
            }
        }
    
    static func getFavoritesList(completion: @escaping (Result<[Element],AppError>)->()) {
        
        let endpointURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                    let favorites = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(favorites))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    
}
