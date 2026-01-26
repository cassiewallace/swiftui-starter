//
//  DetailView.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import SwiftUI

struct DetailView: View {

    // MARK: - Variables
    
    let item: Item

    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Detail")
            Text("View")
            Text("Item ID: \(item.id)")
        }
        .navigationTitle("Detail View Navigation Title")
    }
   
}

