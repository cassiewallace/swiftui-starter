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

enum HTTPClientError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
}

class HTTPClient {
    
    // MARK: - Class Methods
    
    // Make a GET request from a URL.
    // Assumes:
    // 1) The response uses snake_case.
    // 2) Authorization is provided via an API key from Constants.
    static func get<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw HTTPClientError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.GET.rawValue
        request.setValue(Constants.API.apiKey, forHTTPHeaderField: "Authorization")
            
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw HTTPClientError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let typedObject = try decoder.decode(T.self, from: data)
                return typedObject
            } catch {
                throw HTTPClientError.decodingError(error)
            }
        } catch let error as HTTPClientError {
            throw error
        } catch {
            throw HTTPClientError.networkError(error)
        }
    }
}


