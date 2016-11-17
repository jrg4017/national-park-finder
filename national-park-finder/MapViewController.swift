//
//  MapViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
//    @IBOutlet weak var mapTypeSegmentCtrl: UISegmentedControl!
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()
        loadAnnotations()
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
//    //updates the view when different control is selected
//    @IBAction func updateMapViewType(_ sender: UISegmentedControl) {
//        switch(sender.selectedSegmentIndex) {
//        case 0:
//            mapView.mapType = .standard
//        case 1:
//            mapView.mapType = .satellite
//        case 2:
//            mapView.mapType = .hybrid
//        default:
//            mapView.mapType = .standard
//        }
//    }
//    
    //zooms out to intial viewcenter of us when clicked
    @IBAction func zoomViewOut(_ sender: UIButton) {
        let lattitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        zoomRegion(lattitude, longitude, 60.0)
    }
    
    //function to zoom in or out on a location
    func zoomRegion(_ lattitude: CLLocationDegrees, _ longitude: CLLocationDegrees, _ delta: Double) {
        let center = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        
        mapView.setRegion(region, animated: true)
    }
    
    //asks for location and sets up the need for location to update
    func loadLocation() {
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //loads the data in from data.plist and add as mkAnnotations
    func loadAnnotations() {
        
        //add to annotations
        for park in parks {
            mapView.addAnnotation(park)
        }
    }
}


