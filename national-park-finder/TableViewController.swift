//
//  TableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/17/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit
import CoreLocation

/**
  * Parent UITableViewController for ParkTableViewController, FavoritesViewController
  * implements shared functions and variables
  */
class TableViewController: UITableViewController {
    
/**************** Constant variables *********************/
    let NUM_OF_SECTIONS: Int = 1
    
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
    
    var favoritesList = Parks()
    var favorites: [Park] {
        get {
            return self.favoritesList.parkList
        }
        set(val) {
            self.favoritesList.parkList = val
        }
    }

    var mapViewController: MapViewController?
    
/**************** override functions **************************/
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NUM_OF_SECTIONS
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

/**************** helper functions **************************/
    //set ups the cell for the appropiate
    func setUpCellObj(_ identifier: String, _ parkList: [Park], _ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let park = parkList[indexPath.row]
        cell.textLabel?.text = park.getParkName()
        
        if (identifier == "ParkCell") {
            cell.detailTextLabel?.text = "Distance: \(self.getDistance(park.coordinate))"
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //gets the distance in miles from the current location 
    func getDistance(_ parkCoordinates: CLLocationCoordinate2D) -> String {
        //convert to CLLocation from CLLocationCoordinate2Dß
        let currLocation = CLLocation(latitude: (mapViewController?.currentLocation.latitude)!, longitude: (mapViewController?.currentLocation.longitude)!)
        let parkLocation = CLLocation(latitude: parkCoordinates.latitude, longitude: parkCoordinates.longitude)
        
        //calculate distance in miles (returns in meters)ß
        let distanceInMiles = currLocation.distance(from: parkLocation) / 1609.344
        
        //round to nearest 10th
        let multiplier = pow(10.0, 2.0)
        let rounded = round(distanceInMiles * multiplier) / multiplier
        
        return "\(rounded) miles"
    }
}
