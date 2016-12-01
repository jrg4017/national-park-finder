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

/**
  * main controller for anything relating the app's mapview
  * extensions: MkMapViewDelegate, CLLocationManagerDelegate, UIPickerDelegate
  */
class MapViewController: UIViewController {
// MARK: - constants
    
    let ZOOMED_OUT_DELTA : Double = 60.0
    let ZOOMED_IN_DELTA : Double = 0.75
    let MAP_VIEW_INDEX: Int = 0
    
// MARK: - variables
    
    /***** IBOutlet variables ******/
    @IBOutlet weak var mapView: MKMapView!
    
    /****** park wrapper and variables ******/
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    /****** CLLocation variables ******/
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
// MARK: - Actions
    
    //zooms out to initial view
    @IBAction func zoomViewOut(_ sender: UIButton) {
        let lattitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        zoomRegion(lattitude, longitude, ZOOMED_OUT_DELTA)
    }
    
// MARK: - Lifecycle
    
    // on view did load, load annotations & location data
    // implement delegates for MKMapView, CLLocation, UIPickerView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()
        loadAnnotations()
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
// MARK: - helper functions
    
// MARK: zoom on MKMapView annotation
    
    //function to zoom in or out on a location
    func zoomRegion(_ lattitude: CLLocationDegrees, _ longitude: CLLocationDegrees, _ delta: Double) {
        let center = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        
        mapView.setRegion(region, animated: true)
    }

    //switches to map view and shows the annotation in question
    func showOnMap(_ park: Park) {
        tabBarController?.selectedIndex = MAP_VIEW_INDEX
        
        let lattitude = park.coordinate.latitude
        let longitude = park.coordinate.longitude
        
        zoomRegion(lattitude, longitude, ZOOMED_IN_DELTA)
    }

// MARK: Loading Data
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
    }//end loadannotations
}


