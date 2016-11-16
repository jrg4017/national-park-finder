//
//  VCLocationDelegate.swift
//  npf-3.0
//
//  Created by Julianna Gabler on 11/1/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//
import UIKit
import Foundation
import CoreLocation
import MapKit

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
    }
}
