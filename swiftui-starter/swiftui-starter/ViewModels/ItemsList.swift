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
        Task {
            await getItems()
        }
    }
    
    // MARK: - Public Functions
    
    @MainActor
    func getItems() async {
        do {
            let items = try await DataStore.getItems()
            self.items = items
            self.error = false
        } catch {
            self.error = true
            print("Error fetching items: \(error)")
        }
    }

}

