//
//  ItemsList.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

class ItemsList: ObservableObject {

    // MARK: - Public Variables
    
    @Published var items = [Item]()
    @Published var error = false
    
    // MARK: Init(s)
    
    init() {
        getItems()
    }
    
    // MARK: - Public Functions
    
    func getItems() {
        DataStore.getItems { items in
            guard let items = items else {
                self.error = true
                return
            }
            DispatchQueue.main.async {
                self.items = items
            }
        }
    }

}

