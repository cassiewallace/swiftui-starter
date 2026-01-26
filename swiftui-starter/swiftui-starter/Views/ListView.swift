//
//  ListView.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import SwiftUI

struct ListView: View {

    // MARK: - Public Variables
    
    @ObservedObject var itemsList: ItemsList

    // MARK: - Body
    var body: some View {
        NavigationStack {
            switch itemsList.state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let items):
                // UNCOMMENT and replace the working List when an API endpoint is added.
                // List(items, id: \.id) { item in
                //     NavigationLink(value: item) {
                //         Text("\(item.id)")
                //     }
                // }
                // START code to replace
                List {
                    NavigationLink(value: Item(id: 1)) {
                        Text("Link 1")
                    }
                    NavigationLink(value: Item(id: 2)) {
                        Text("Link 2")
                    }
                    NavigationLink(value: Item(id: 3)) {
                        Text("Link 3")
                    }
                }
                .listStyle(.plain)
                .navigationDestination(for: Item.self) { item in
                    DetailView(item: item)
                }
                // END code to replace
            case .error(let message):
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Error")
                        .font(.headline)
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("SwiftUI Starter")
    }
    
}


// MARK: - Previews

#Preview {
    let itemsList = ItemsList()
    return ListView(itemsList: itemsList)
}
