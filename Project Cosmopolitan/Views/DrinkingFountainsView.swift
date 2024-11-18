//
//  DrinkingFountainsView.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 17/11/24.
//

import SwiftUI
import MapKit

struct DrinkingFountainsView: View {
    ///Map Properties
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: MKMapItem?
    @Namespace private var locationSpace
    @State private var viewingRegion: MKCoordinateRegion?
    
    ///University
    let sanGiovanni = CLLocationCoordinate2D(latitude: 40.838986, longitude: 14.291757)
    
    @State var camera: MapCameraPosition = .automatic
    
    
    var body: some View {
        NavigationStack{
            Map(position: $cameraPosition) {
                
                Annotation("University Federico II", coordinate: sanGiovanni) {
                    Image(systemName: "house")
                        .background(.blue)
                }
                ForEach(FountainCoordinates.all, id: \.name) { fountain in
                    Marker(fountain.name, systemImage: "drop.fill", coordinate: fountain.coordinate)
                        .tint(.blue)
                }
                
            }
            .onMapCameraChange({ ctx in
                viewingRegion = ctx.region
                
            })
            .overlay(alignment:.bottomTrailing){
                VStack(spacing: 15) {
                    MapCompass(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("Drinkable Fountains")
            ///Showing Translucent ToolBar
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            
        }
    }
    
}

#Preview {
    DrinkingFountainsView()
}

extension CLLocationCoordinate2D {
    static var myLocation : CLLocationCoordinate2D {
        return .init(latitude: 40.838986, longitude: 14.291757)
    }
}

extension MKCoordinateRegion {
    static var myRegion : MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.8358, longitude: 14.2499), // Center near the fountains
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
    }
}




