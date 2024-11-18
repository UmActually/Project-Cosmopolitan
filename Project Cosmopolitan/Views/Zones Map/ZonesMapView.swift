//
//  ZonesMapView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI
import MapKit

struct ZonesMapView: UIViewRepresentable {
    @EnvironmentObject var modelData: ModelData
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = modelData.mkMapView
        modelData.mkMapView.delegate = context.coordinator
        
        mapView.region = modelData.cameraRegion
        mapView.pointOfInterestFilter = .excludingAll
        mapView.mapType = .standard
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        
        for zone in modelData.naplesZones {
            let polygonOverlay = MKPolygon(coordinates: zone.vertices, count: zone.vertices.count)
            mapView.addOverlay(polygonOverlay)
            let annotation = MKPointAnnotation()
            annotation.coordinate = zone.center
            annotation.title = zone.name
            mapView.addAnnotation(annotation)
        }
        
        for fountain in modelData.naplesFountains {
            let annotation = FountainAnnotation(fountain: fountain)
            mapView.addAnnotation(annotation)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if modelData.moveCameraRegion {
            UIView.animate(withDuration: 0.5) {
                uiView.setRegion(modelData.cameraRegion, animated: true)
            }
        }
        
        
        uiView.delegate?.mapView?(uiView, regionDidChangeAnimated: false)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
        var parent: ZonesMapView
        var locationManager = CLLocationManager()
        var gestureRecognizer = UITapGestureRecognizer()
        var selectedAnnotation: MKAnnotation?
        
        init(_ parent: ZonesMapView) {
            self.parent = parent
            super.init()
            
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            
            self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleZoneTap))
            self.gestureRecognizer.delegate = self
            self.parent.modelData.mkMapView.addGestureRecognizer(gestureRecognizer)
        }
        
        // Map view delegate
        // Checar que el mapa esté lo suficientemente zoomeado para mostrar las annotations
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let latitudeDelta = mapView.region.span.latitudeDelta
            let threshold: CLLocationDegrees = 0.06
            
            for annotation in mapView.annotations {
                guard !(annotation is MKUserLocation), let view = mapView.view(for: annotation) else {
                    continue
                }
                view.isHidden = latitudeDelta > threshold || (annotation is FountainAnnotation && !parent.modelData.showingFountains) || (annotation is MKPointAnnotation && parent.modelData.showingFountains)
            }
        }
        
        // Location manager delegate
        // Ask for permission 👉👈
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                parent.modelData.mkMapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
            default:
                break
            }
        }
        
        // Other functions in ZonesMapAnnotations & ZonesMapInteractions
    }
}

func openInAppleMaps(coordinate: CLLocationCoordinate2D, name: String) {
    let placemark = MKPlacemark(coordinate: coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = name
    mapItem.openInMaps(launchOptions: [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ])
}
