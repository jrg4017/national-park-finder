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

// MARK: - variables

    /****** park wrapper & variable ******/
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
    var favorites: [String]  = []
    
// MARK: - Lifecycle functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// MARK: - favorites array functions
    
    func loadFavorites() {
        //read array of Favorites from UserDefaults in
        let favoritesData = UserDefaults.standard.object(forKey: "favorites") as? Data
        
        if let favoritesData = favoritesData {
            favorites = (NSKeyedUnarchiver.unarchiveObject(with: favoritesData) as? [String])!
        }
    }
    
// MARK: - helper functions
    
// MARK: UITableViewCell setup
    
    //set ups the cell for the appropiate
    func setUpCellObj(_ identifier: String, _ parkArr: [Park], _ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let park = parkArr[indexPath.row]
        cell.textLabel?.text = park.getParkName()
                
        if (identifier == "ParkCell") {
            cell.detailTextLabel?.text = "Distance: \(self.getDistance(park.coordinate)) miles"
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

// MARK: measures distance
    
    //gets the distance in miles from the current location 
    func getDistance(_ parkCoordinates: CLLocationCoordinate2D) -> Double {
        let mapVC = tabBarController?.viewControllers?[0] as! MapViewController
        
        //convert to CLLocation from CLLocationCoordinate2Dß
        let currLocation = CLLocation(latitude: mapVC.currentLocation.latitude, longitude: mapVC.currentLocation.longitude)
        let parkLocation = CLLocation(latitude: parkCoordinates.latitude, longitude: parkCoordinates.longitude)
        
        //calculate distance in miles (returns in meters)ß
        let distanceInMiles = currLocation.distance(from: parkLocation) / 1609.344
        
        //round to nearest 10th
        let multiplier = pow(10.0, 2.0)
        let roundedDistance = round(distanceInMiles * multiplier) / multiplier
        
        return roundedDistance
    }
    
// MARK: edit favorites array
    
    //encodes the favorites array and updates accordingly
    func updateFavoriteDefaults() {
        let favoritesData = NSKeyedArchiver.archivedData(withRootObject: favorites)
        
        let defaults = UserDefaults.standard
        defaults.set(favoritesData, forKey: "favorites")
        defaults.synchronize()
    }
    
    func addToFavorites(_ park: Park) {
        if !(favorites.contains(park.getParkName())) {
            favorites.append(park.getParkName())
            updateFavoriteDefaults()
        }
    }

    func removeFromFavorites(_ park: Park) {
        if let index = favorites.index(of: park.getParkName()) {
            favorites.remove(at: index)
        }
        
        updateFavoriteDefaults()
    }//end removeFromFavorites
}
