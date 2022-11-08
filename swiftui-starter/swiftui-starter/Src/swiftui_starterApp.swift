//
//  swiftui_starterApp.swift
//  swiftui-starter
//
//  Created by Cassie Wallace on 11/8/22.
//

import SwiftUI

@main
struct swiftui_starterApp: App {
    private let itemsList = ItemsList()
    
    var body: some Scene {
        WindowGroup {
            ListView(itemsList: itemsList)
        }
    }
}
