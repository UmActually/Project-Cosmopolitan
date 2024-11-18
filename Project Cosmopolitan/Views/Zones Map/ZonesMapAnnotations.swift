//
//  ZonesMapAnnotations.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 18/11/24.
//

import SwiftUI
import MapKit

// This class is mainly to differentiate MKAnnotations in the coordinator renderer function
class FountainAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
    }
    
    init(fountain: Fountain) {
        coordinate = fountain.location
        title = fountain.name
        subtitle = "Tap to get directions"
    }
}

class AnnotationButton: UIButton {
    var annotation: MKAnnotation?
}

extension ZonesMapView.Coordinator {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygonOverlay = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygonOverlay)
            renderer.fillColor = UIColor.customBlue.withAlphaComponent(0.1)
            renderer.strokeColor = UIColor.customBlue
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let zoneAnnotation = annotation as? MKPointAnnotation {
            return zoneAnnotationView(mapView, viewFor: zoneAnnotation)
        }
        
        if let fountainAnnotation = annotation as? FountainAnnotation {
            return fountainAnnotationView(mapView, viewFor: fountainAnnotation)
        }
        
        return nil
    }
    
    func zoneAnnotationView(_ mapView: MKMapView, viewFor annotation: MKPointAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ZoneLabel")
        annotationView.canShowCallout = false
        annotationView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = annotation.title ?? ""
        label.textColor = .black
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        
        let padding: CGFloat = 6
        label.frame = CGRect(
            x: 0,
            y: 0,
            width: label.intrinsicContentSize.width + 2 * padding + 4,
            height: label.intrinsicContentSize.height + 2 * padding
        )
        label.layer.cornerRadius = label.frame.height / 2
        
        annotationView.addSubview(label)
        annotationView.frame = label.frame
        
        return annotationView
    }
    
    func fountainAnnotationView(_ mapView: MKMapView, viewFor annotation: FountainAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "FountainAnnotation")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "FountainAnnotation")
            annotationView?.image = UIImage(named: "FountainMarker")
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.canShowCallout = true
        
        let button = AnnotationButton(type: .detailDisclosure)
        button.annotation = annotation
        button.addTarget(self, action: #selector(handleCalloutTap), for: .touchUpInside)
        annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
    }
}
