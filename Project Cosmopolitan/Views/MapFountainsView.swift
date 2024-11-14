//
//  MapFountainsView.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 12/11/24.
//

import SwiftUI
import MapKit

struct MapFountainsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8522, longitude: 14.2681),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {

        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .frame(width: 400, height: 300)
    }
}

struct MapFountainsView_Previews: PreviewProvider {
    static var previews: some View {
        MapFountainsView()
    }
}
