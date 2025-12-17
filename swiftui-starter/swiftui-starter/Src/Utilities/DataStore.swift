//
//  DataStore.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

class DataStore {

    // MARK: - Methods
    
    // Retrieve all of a particular type of item using a GET request.
    static func getItems() async throws -> [Item] {
        let url = Constants.API.baseURL + Constants.API.path
        return try await HTTPClient.get<[Item]>(url: url)
    }
    
}

