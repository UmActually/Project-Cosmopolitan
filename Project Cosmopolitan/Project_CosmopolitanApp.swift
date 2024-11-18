//
//  Project_CosmopolitanApp.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 04/11/24.
//

import SwiftUI

@main
struct Project_CosmopolitanApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var userLocationModel = UserLocationModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(userLocationModel)
        }
    }
}
