//
//  MapFountainsContentBuilder.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 13/11/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {

  static let viaCesarioConsoleCoordinate = CLLocationCoordinate2D(latitude: 40.8358, longitude: 14.2499)
    
    static let parcoVirgilianoCoordinate = CLLocationCoordinate2D(latitude: 40.8025, longitude: 14.1941)
}

struct MapFountainsContentBuilder: View {
    var body: some View {
        Text("Drinkable fountains")
        Map{
            Marker("Fountain Via Cesario Console", coordinate: .viaCesarioConsoleCoordinate)
            Marker("Fountain Parco Virgiliano", coordinate: .parcoVirgilianoCoordinate)

        }
    }
}

#Preview {
    MapFountainsContentBuilder()
}
/*extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return.init(center: .myLocation, latitude: 40.8522, longitude: 14.2681)
    }
}*/
