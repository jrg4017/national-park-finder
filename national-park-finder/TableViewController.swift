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
    var favorites: [Park]  = []
    var mapViewController: MapViewController?
    
/**************** override functions **************************/    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadFavorites() {
        //read array of Favorites from UserDefaults in
        let favoritesData = UserDefaults.standard.object(forKey: "favorites") as? Data

        
//        let placesData = NSUserDefaults.standardUserDefaults().objectForKey("places") as? NSData
        
        if let favoritesData = favoritesData {
            favorites = (NSKeyedUnarchiver.unarchiveObject(with: favoritesData) as? [Park])!
        }
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
    
    //encodes the favorites array and updates accordingly
    func updateFavoriteDefaults() {
        let favoritesData = NSKeyedArchiver.archivedData(withRootObject: favorites)
        
        let defaults = UserDefaults.standard
        defaults.set(favoritesData, forKey: "favorites")
        defaults.synchronize()
    }
    
    func addToFavorites(_ park: Park) {
        favorites.append(park)
        updateFavoriteDefaults()
    }

    func removeFromFavorites(_ park: Park) {
        if let index = favorites.index(of: park) {
            favorites.remove(at: index)
        }
        
        updateFavoriteDefaults()
    }
}
