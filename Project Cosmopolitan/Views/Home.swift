//
//  Home.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI
import MapKit

struct Home: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZonesMapView()
                    .ignoresSafeArea()
            }
            .sheet(isPresented: Binding(get: {
                modelData.selectedZone == nil
            }, set: {_ in})) {
                HomeSheet()
                    .interactiveDismissDisabled()
                    .presentationDetents([.height(100), .medium, .large], selection: $modelData.sheetDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            }
            .navigationDestination(isPresented: Binding(get: {
                modelData.selectedZone != nil
            }, set: {
                if !$0 {
                    modelData.selectedZone = nil
                }
            })) {
                ZoneDetail()
            }
        }
    }
}
