//
//  AppState.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 12/11/24.
//

import SwiftUI
import MapKit

final class ModelData: ObservableObject {
    @Published var manuallyReloadViews = false
    @Published var mkMapView = MKMapView()
    @Published var sheetDetent = PresentationDetent.height(100)
    @Published var selectedZone: Zone?
    @Published var cameraRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8522, longitude: 14.265),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var moveCameraRegion = false
    let naplesZones: [Zone] = decodeJSON(from: "Zones")
    
    func zoneOfLocation(_ location: CLLocationCoordinate2D) -> Zone? {
        for (index, overlay) in mkMapView.overlays.enumerated() {
            guard let polygon = overlay as? MKPolygon else { continue }
            
            let renderer = MKPolygonRenderer(polygon: polygon)
            let mapPoint = MKMapPoint(location)
            let rendererPoint = renderer.point(for: mapPoint)
            if renderer.path.contains(rendererPoint) {
                return naplesZones[index]
            }
        }
        return nil
    }
}

final class UserLocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

final class QualityModel {
    static let parameters: [Parameter] = decodeJSON(from: "Parameters")
    static let zonesQuality: [ZoneQuality] = decodeJSON(from: "Quality")
}

final class GeneralInfoModel: ObservableObject {
    @Published var generalInfo: [GeneralInfoItem] = decodeJSON(from: "GeneralInfo")
}

extension MKCoordinateRegion {
    static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
    
    static func != (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        !(lhs == rhs)
    }
}

func decodeJSON<T: Decodable>(from fileName: String) -> T {
    let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
    let decoder = JSONDecoder()
    return try! decoder.decode(T.self, from: Data(contentsOf: url))
}
