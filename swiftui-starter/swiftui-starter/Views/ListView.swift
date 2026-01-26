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
            // UNCOMMENT and replace the working List when an API endpoint is added.
            // List(itemsList.items, id: \.id) { item in
            //     NavigationLink(destination: DetailView(item: item)) {
            //         Text(item.id)
            //     }
            // }
            // START code to replace
            List {
                NavigationLink(destination: DetailView()) {
                    Text("Link 1")
                }
                NavigationLink(destination: DetailView()) {
                    Text("Link 2")
                }
                NavigationLink(destination: DetailView()) {
                    Text("Link 3")
                }
            }
            // END code to replace
            .listStyle(.plain)
            .navigationTitle("SwiftUI Starter")
        }
    }
    
}


// MARK: - Previews

#Preview {
    let itemsList = ItemsList()
    return ListView(itemsList: itemsList)
}
