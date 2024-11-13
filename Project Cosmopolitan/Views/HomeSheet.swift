//
//  HomeSheet.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 12/11/24.
//

import SwiftUI
import MapKit

struct HomeSheet: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var userLocationModel = UserLocationModel()
    @State private var search = ""
    
    var userCurrentZone: Zone? {
        if let location = userLocationModel.userLocation {
            return modelData.zoneOfLocation(location)
        }
        return nil
    }
    
    var filteredZones: [Zone] {
        if search.isEmpty { return modelData.naplesZones }
        return modelData.naplesZones.filter { zone in
            let neighborhood = zone.neighborhood.lowercased()
            let name = zone.name.lowercased()
            let searchText = search.lowercased()
            return neighborhood.contains(searchText) || name.contains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if let userCurrentZone {
                    Section {
                        Button { handleTapZone(zone: userCurrentZone) } label: {
                            ZoneListCard(zone: userCurrentZone)
                        }
                    } header: {
                        Text("Your location")
                    }
                }
                Section {
                    ForEach(filteredZones) { zone in
                        Button { handleTapZone(zone: zone) } label: {
                            ZoneListCard(zone: zone)
                        }
                    }
                } header: {
                    Text("All zones")
                }
            }
            .id(modelData.manuallyReloadViews)
            .searchable(text: $search, prompt: "Search for a zone")
            .navigationTitle("Zones of Naples")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func handleTapZone(zone: Zone) {
        var center = zone.center
        center.latitude -= 0.0075 // Shift map up to account for modal below

        modelData.sheetDetent = .medium
        modelData.moveCameraRegion = true
        modelData.cameraRegion = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        
        // Dismiss search the old way
        DispatchQueue.main.async {
            search = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

        // This has to run after the button action ends
        DispatchQueue.main.async {
            modelData.moveCameraRegion = false
        }
    }
}
