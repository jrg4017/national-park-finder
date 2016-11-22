//
//  MapViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

// TODO LIST : 
//              click on "Show on Map" and goes to MKAnnotation on MApVC 50,000 X 50,000
//              convert MKAnnotation to MKMapItem (20,000 X 20,000 meters)
//              edit button to delete options in favorites list
//              rearrange favorites list (optional)
//              load iamge (optional)
//              reload view on Favorites view tab click

import UIKit
import MapKit
import CoreLocation

/**
  * main controller for anything relating the app's mapview
  * extensions: MkMapViewDelegate, CLLocationManagerDelegate, UIPickerDelegate
  */
class MapViewController: UIViewController {
    
/**************** IBOutlet vars **************************/
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

/**************** UIPicker vars **************************/
    var mapTypePickerView: UIPickerView!
    let pickerDataSource = ["Standard", "Satellite", "Hybrid"]
    
/**************** park array wrapper/vars ****************/
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
/**************** CLLocation variables *******************/
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
/**************** IBAction functions **************************/
    
    //zooms out to intial viewcenter of us when clicked
    @IBAction func zoomViewOut(_ sender: UIButton) {
        let lattitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        zoomRegion(lattitude, longitude, 60.0)
    }
    
/**************** override functions **************************/
    
    //on view did load, load annotations & location data
    // implement delegates for MKMapView, CLLocation, UIPickerView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()
        loadAnnotations()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        //let inputView = UIView(frame: CGRect(0, 0, self.view.frame.width, 240))
        mapTypePickerView = UIPickerView()
        mapTypePickerView.dataSource = self
        mapTypePickerView.delegate = self
        
        //ßsettingsButton.inputView = mapTypePickerView
    }
    
/**************** helper functions **************************/
    
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
    }//end loadannotations
}


