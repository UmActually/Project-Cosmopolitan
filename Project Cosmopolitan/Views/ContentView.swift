//
//  ContentView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
