//
//  ZonesMapView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI
import MapKit

struct ZonesMapView: UIViewRepresentable {
    let zones: [Zone]
    @Binding var selectedZone: Zone?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.region = MapViewModel.naplesRegion
        mapView.pointOfInterestFilter = .excludingAll
        mapView.mapType = .standard
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        
        for zone in zones {
            let polygonOverlay = MKPolygon(coordinates: zone.vertices, count: zone.vertices.count)
            mapView.addOverlay(polygonOverlay)
            let annotation = MKPointAnnotation()
            annotation.coordinate = zone.center
            annotation.title = zone.name
            mapView.addAnnotation(annotation)
        }
        
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ZonesMapView
        
        init(_ parent: ZonesMapView) {
            self.parent = parent
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
            label.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            
            let padding: CGFloat = 8
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
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? MKPointAnnotation,
               let zone = parent.zones.first(where: { $0.name == annotation.title }) {
                parent.selectedZone = zone
            }
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let latitudeDelta = mapView.region.span.latitudeDelta

            let threshold: CLLocationDegrees = 0.08

            for annotation in mapView.annotations {
                if let view = mapView.view(for: annotation) {
                    view.isHidden = latitudeDelta > threshold
                }
            }
        }
    }
}
