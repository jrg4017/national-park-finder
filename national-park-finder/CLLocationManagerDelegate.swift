//
//  CLLocationManagerDelegate.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit
import CoreLocation

/**
 * extension handles the needs for CLLocationManagerDelegate
 * see MapViewController
 */
extension MapViewController: CLLocationManagerDelegate {
    
// MARK: - CLLocationManagerDelegate functions
    
    //updates current location, used by other controllers
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
    }
}

