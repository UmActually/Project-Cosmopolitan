//
//  Home.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI
import MapKit

struct Home: View {
    @State private var selectedZone: Zone?
    @State private var showSheet = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZonesMapView(zones: MapViewModel.naplesZones, selectedZone: $selectedZone)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $showSheet) {
                HomeSheet(selectedZone: $selectedZone)
                    .interactiveDismissDisabled()
                    .presentationDetents([.height(100), .medium, .large])
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            }
            .navigationTitle("Home")
            .navigationDestination(isPresented: Binding(
                get: {
                    let isSelected = selectedZone != nil
                    showSheet = !isSelected
                    return isSelected
                }, set: {
                    showSheet = !$0
                    if !$0 {
                        selectedZone = nil
                    }
                }
            )) {
                ZoneDetail(zone: selectedZone)
            }
        }
    }
}

#Preview {
    Home()
}
