//
//  DataStore.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

class DataStore {

    // MARK: - Class Methods
    
    // Retrieve all of a particular type of item using a GET request.
    static func getItems(completionHandler: @escaping ([Item]?) -> Void) {
        let url = Constants.API.baseURL + Constants.API.path

        HTTPClient.get(url: url) { items in
            completionHandler(items)
            return
        }
    }
    
}

