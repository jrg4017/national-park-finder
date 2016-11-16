//
//  VCMapDelegate.swift
//  npf-3.0
//
//  Created by Julianna Gabler on 11/1/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

extension ViewController: MKMapViewDelegate {
    
    //button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control == view.rightCalloutAccessoryView) {
            getDirections(view)
        } else if (control == view.leftCalloutAccessoryView) {
            print("Control tapped: \(control), view title: \(view.annotation?.title), tag numbers: ")
        } else {
            goToWebsite(view)
        }
        
    }
    
    func getDirections(_ view: MKAnnotationView) {
        let destination = view.annotation
        
        let currentLocMapItem = MKMapItem.forCurrentLocation()
        
        let destinationPlacemark = MKPlacemark(coordinate: (destination?.coordinate)!, addressDictionary: nil)
        
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = destination?.title!
        
        let mapItems = [currentLocMapItem, destinationMapItem]
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
    }
    
    func goToWebsite(_ view: MKAnnotationView) {
        let annotation = view.annotation
        
        for park in parks {
            if park.title == annotation?.title! {
                let parkURL = NSURL(string: park.getLink())! as URL
                UIApplication.shared.openURL(parkURL)
            }
        }
    }
    
    //get driving or go to url
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let annotation = view.annotation
//        
//        if view {
//        for park in parks {
//            if park.title == annotation?.title! {
//                let parkURL = NSURL(string: park.getLink())! as URL
//                UIApplication.shared.openURL(parkURL)
//            }
//        }
//        }
//    }
    
    //called for each annotation to create a pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view:MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            // Return nil so it will draw the default view -- i.e. blue dot
            return nil
        } // end of annotation is
        
        if annotation !== mapView.userLocation {
            
            // look for an existing view to use
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
