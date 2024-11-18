//
//  ZonesMapInteractions.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 18/11/24.
//

import SwiftUI
import MapKit

extension ZonesMapView.Coordinator {
    // Map view delegate
    // Handles tapping on a fountain AnnotationView
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedAnnotation = view.annotation
        
        guard let calloutView = view.subviews.first else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCalloutTap))
        calloutView.addGestureRecognizer(tapGesture)
    }
    
    // Gesture recognizer delegate
    // Conditionally prevents that tapping on a fountain triggers the recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if !parent.modelData.showingFountains {
            return true
        }
        
        let mapView = parent.modelData.mkMapView
        let tapLocation = touch.location(in: mapView)
        
        for annotationView in mapView.annotations.compactMap({ mapView.view(for: $0) }) {
            if annotationView.frame.contains(tapLocation) {
                return false // avoid calling handleZoneTap if user tapped on a fountain icon
            }
        }

        return true
    }
    
    @objc func handleZoneTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gestureRecognizer.location(in: parent.modelData.mkMapView)
        let location = parent.modelData.mkMapView.convert(tapLocation, toCoordinateFrom: parent.modelData.mkMapView)
        if let zone = parent.modelData.zoneOfLocation(location) {
            parent.modelData.selectedZone = zone
        }
    }
    
    @objc func handleCalloutTap(_ gesture: UITapGestureRecognizer) {
        guard let annotation = selectedAnnotation else { return }
        openInAppleMaps(coordinate: annotation.coordinate, name: annotation.title!!)
    }
}
