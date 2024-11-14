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
        modelData.mkMapView.delegate = context.coordinator
        let mapView = modelData.mkMapView
        
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
            annotation.subtitle = String(zone.id)
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
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
        var parent: ZonesMapView
        var locationManager = CLLocationManager()
        var gestureRecognizer = UITapGestureRecognizer()
        
        init(_ parent: ZonesMapView) {
            self.parent = parent
            super.init()
            
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            
            self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.gestureRecognizer.delegate = self
            self.parent.modelData.mkMapView.addGestureRecognizer(gestureRecognizer)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygonOverlay = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygonOverlay)
                renderer.fillColor = UIColor.accent.withAlphaComponent(0.3)
                renderer.strokeColor = UIColor.accent
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ZoneLabel")
            annotationView.canShowCallout = false
            annotationView.backgroundColor = .clear
            
            let label = UILabel()
            label.text = annotation.title ?? ""
            label.textColor = .black
            label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            label.font = UIFont.systemFont(ofSize: 8)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            
            let padding: CGFloat = 6
            label.frame = CGRect(
                x: 0,
                y: 0,
                width: label.intrinsicContentSize.width + 2 * padding,
                height: label.intrinsicContentSize.height + 2 * padding
            )
            annotationView.addSubview(label)
            annotationView.frame = label.frame
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let latitudeDelta = mapView.region.span.latitudeDelta

            let threshold: CLLocationDegrees = 0.08

            for annotation in mapView.annotations {
                if !(annotation is MKUserLocation), let view = mapView.view(for: annotation) {
                    view.isHidden = latitudeDelta > threshold
                }
            }
        }

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                parent.modelData.mkMapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
            default:
                break
            }
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let tapLocation = gestureRecognizer.location(in: parent.modelData.mkMapView)
            let location = parent.modelData.mkMapView.convert(tapLocation, toCoordinateFrom: parent.modelData.mkMapView)
            if let zone = parent.modelData.zoneOfLocation(location) {
                parent.modelData.selectedZone = zone
            }
        }
    }
}
