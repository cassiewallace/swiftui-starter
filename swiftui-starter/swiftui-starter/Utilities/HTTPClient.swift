//
//  HTTPClient.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

enum HTTPMethods: String {
    case DELETE
    case GET
    case PATCH
    case POST
    case PUT
}

class HTTPClient {
    
    // MARK: - Class Methods
    
    // Make a GET request from a URL.
    // Assumes:
    // 1) The response uses snake_case.
    // 2) Authorization is provided via an API key from Constants.
    static func get<T: Decodable>(url: String, completionHandler: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.GET.rawValue
        request.setValue(Constants.API.apiKey, forHTTPHeaderField: "Authorization")
            
        let sharedSession = URLSession.shared
        
        let dataTask = sharedSession.dataTask(with: request) {
            (data, response, error) in
                do {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                        completionHandler(typedObject)
                    }
                }
                catch {
                    print(error)
                }
        }
        
        dataTask.resume()
    }
    
    // Make a POST request to a URL.
    // Assumes:
    // 1) The request body uses snake_case.
    // 2) The response uses snake_case.
    // 3) Authorization is provided via an API key from Constants.
    static func post<T: Encodable, U: Decodable>(url: String, body: T, completionHandler: @escaping (U?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.POST.rawValue
        request.setValue(Constants.API.apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try encoder.encode(body)
        } catch {
            print("Error encoding request body: \(error)")
            completionHandler(nil)
            return
        }
        
        let sharedSession = URLSession.shared
        
        let dataTask = sharedSession.dataTask(with: request) {
            (data, response, error) in
                do {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let typedObject: U? = try decoder.decode(U.self, from: jsonData)
                        completionHandler(typedObject)
                    } else {
                        completionHandler(nil)
                    }
                }
                catch {
                    print("Error decoding response: \(error)")
                    completionHandler(nil)
                }
        }
        
        dataTask.resume()
    }
}


