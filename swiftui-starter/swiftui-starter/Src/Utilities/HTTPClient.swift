//
//  HTTPClient.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

enum HTTPMethods: String {
    case DELETE = "DELETE"
    case GET = "GET"
    case PATCH = "PATCH"
    case POST = "POST"
    case PUT = "PUT"
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
}


