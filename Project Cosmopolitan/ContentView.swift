//
//  ContentView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.largeTitle)
                .background(Color.red)
            // this is a modification
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
