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
        NavigationView {
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
            .listStyle(PlainListStyle())
        .navigationBarTitle("SwiftUI Starter", displayMode: .large)
        }
    }
    
}


// MARK: - Previews

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let itemsList = ItemsList()
        ListView(itemsList: itemsList)
    }
}
