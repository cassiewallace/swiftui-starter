//
//  ItemsList.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import Foundation

enum ItemsListState {
    case loading
    case loaded([Item])
    case error(String)
}

class ItemsList: ObservableObject {

    // MARK: - Public Variables
    
    @Published var state: ItemsListState = .loading
    
    // MARK: Init(s)
    
    init() {
        Task {
            await getItems()
        }
    }
    
    // MARK: - Public Functions
    
    @MainActor
    func getItems() async {
        state = .loading
        do {
            let items = try await DataStore.getItems()
            state = .loaded(items)
        } catch {
            state = .error(error.localizedDescription)
            print("Error fetching items: \(error)")
        }
    }

}

