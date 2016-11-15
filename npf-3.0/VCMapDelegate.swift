//
//  VCMapDelegate.swift
//  npf-3.0
//
//  Created by Julianna Gabler on 11/1/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    //button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Control tapped: \(control), view title: \(view.annotation?.title), tag numbers: ")
    }
    
    //get driving or go to url
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        print("The title of the annotation is: \(annotation!.title)")
    }
    
//    //user location
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        // Create a point object
//        let point = MKPointAnnotation()
//        // Assign it a location
//        point.coordinate = userLocation.coordinate
//        
//        // add it to map
//        mapView.addAnnotation(point)
//        let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20000, 20000)
//        mapView.setRegion(mkCoordinateRegion, animated: true)
//    }

    
    //called for each annotation to create a pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view:MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            return nil
        } // end of annotation is
        
        if annotation !== mapView.userLocation {
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.greenPinColor()
                view.animatesDrop = true
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: -5)
                let leftButton = UIButton(type: .infoLight)
                let rightButton = UIButton(type: .detailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            
            return view
        }
        
        return nil
    }
}
