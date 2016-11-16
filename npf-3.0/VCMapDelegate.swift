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
    
    //called for each annotation to create a pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view:MKPinAnnotationView
        let identifier = "Pin"
    
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
}
