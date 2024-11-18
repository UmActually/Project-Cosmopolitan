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
    @EnvironmentObject var userLocationModel: UserLocationModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                ZonesMapView()
                    .ignoresSafeArea()
                
                VStack(alignment: .trailing) {
                    HelpButton()
                    ZonesMapButton(iconName: "location", action: goToUserLocation)
                }
                .padding()
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
    
    func goToUserLocation() {
        guard let location = userLocationModel.userLocation else { return }
        
        modelData.sheetDetent = .height(100)
        modelData.moveCameraRegion = true
        modelData.cameraRegion = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )

        // This has to run after the button action ends
        DispatchQueue.main.async {
            modelData.moveCameraRegion = false
        }
    }
}
