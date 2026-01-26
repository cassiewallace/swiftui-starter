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
    @State private var selectedItem: Item?

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
                //     Button {
                //         selectedItem = item
                //     } label: {
                //         Text("\(item.id)")
                //     }
                // }
                // START code to replace
                List {
                    Button {
                        selectedItem = Item(id: 1)
                    } label: {
                        Text("Link 1")
                    }
                    Button {
                        selectedItem = Item(id: 2)
                    } label: {
                        Text("Link 2")
                    }
                    Button {
                        selectedItem = Item(id: 3)
                    } label: {
                        Text("Link 3")
                    }
                }
                .listStyle(.plain)
                .navigationDestination(item: $selectedItem) { item in
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
