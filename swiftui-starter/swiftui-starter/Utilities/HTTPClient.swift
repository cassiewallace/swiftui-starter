//
//  HTTPClient.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
    case encodingError(Error)
    case decodingError(Error)
}

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
    static func get<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.GET.rawValue
        request.setValue(Constants.API.apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    // Make a POST request to a URL.
    // Assumes:
    // 1) The request body uses snake_case.
    // 2) The response uses snake_case.
    // 3) Authorization is provided via an API key from Constants.
    static func post<T: Encodable, U: Decodable>(url: String, body: T) async throws -> U {
        guard let url = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.POST.rawValue
        request.setValue(Constants.API.apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try encoder.encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(U.self, from: data)
    }
}


