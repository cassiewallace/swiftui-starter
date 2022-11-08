//
//  DetailView.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import SwiftUI

struct DetailView: View {

    // MARK: - Variables
    
    // UNCOMMENT the item variable when an API endpoint is added.
    // var item: Item

    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Detail")
            Text("View")
        }
        .navigationTitle("Detail View Navigation Title")
        .navigationBarTitleDisplayMode(.inline)
    }
   
}

