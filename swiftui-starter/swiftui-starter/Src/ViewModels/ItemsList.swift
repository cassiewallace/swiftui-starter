//
//  ItemsList.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

@MainActor
class ItemsList: ObservableObject {

    // MARK: - Public Variables
    
    @Published var items = [Item]()
    @Published var error: Error?
    
    // MARK: Init(s)
    
    init() {
        Task {
            await getItems()
        }
    }
    
    // MARK: - Public Functions
    
    func getItems() async {
        do {
            let fetchedItems = try await DataStore.getItems()
            self.items = fetchedItems
            self.error = nil
        } catch {
            self.error = error
        }
    }

}

