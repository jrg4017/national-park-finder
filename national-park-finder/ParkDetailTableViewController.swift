//
//  ParkDetailTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

/**
  * Implements a UITableView containing park details
  * see: TableViewController for shared functions
  */
class ParkDetailTableViewController: TableViewController {
    
// MARK: - constant variables
    
    let NUM_OF_SECTIONS: Int = 6
    let NUM_OF_ROWS: Int = 1
    let NUM_OF_SECTION_0_ROWS: Int = 4
    let STANDARD_ROW_HEIGHT: CGFloat = 44.0
    let MAP_CELL_TITLE: String = "Show on Map"
    let FAVORITES_CELL_TITLE: String = "Add to Favorites"
    let FAVORITES_ALERT_TITLE: String = "Favorites"
    let FAVORITES_ALERT_MSG: String = "added to Favorites"
    
// MARK: - variables
    
    var park: Park!

// MARK: - Lifecycle
    
    //when view loads, implement variable section heights
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //just in case it hasn't been initalized
        if favorites.count == 0 {
            loadFavorites()
        }
        
        //allows the section to have variable heights, to adapt to content
        super.tableView.rowHeight = UITableViewAutomaticDimension
        
        //inserts intial section height of 44
        super.tableView.estimatedRowHeight = STANDARD_ROW_HEIGHT
        
    }
    
// MARK: - UITableViewDelegate functions
    
    //we have exactly 6 sections of information
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NUM_OF_SECTIONS
    }
    
    //returns the number of rows in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return NUM_OF_SECTION_0_ROWS
        }
        
        return NUM_OF_ROWS
    }
    
    //when tapping on specific sections, implement appropiate action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 3:
                goToURL(park)
            case 4:
                let mapVC = tabBarController?.viewControllers?[0] as! MapViewController
                mapVC.showOnMap(park)
            case 5:
                createFavoritesAlert(park)
            default:
                break
        }
        
        //deselect the row that was clicked
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //sets the content for each section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        switch indexPath.section {
            case 0:
                setSection0Content(cell!, indexPath, park)
            case 1:
                fetchImageFromURL(urlString: park.getImageLink(), cell: cell!)
                cell!.imageView?.contentMode = .scaleToFill
            case 2:
                cell!.textLabel?.text = "\(park.getParkDescription())"
            case 3:
                cell!.textLabel?.text = "\(park.getLink())"
            case 4:
                cell!.textLabel?.text = MAP_CELL_TITLE
            case 5:
                cell!.textLabel?.text = FAVORITES_CELL_TITLE
            default:
                break
        }
        
        if indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 {
            cell!.textLabel?.textAlignment = .center
        }
        
        cell?.textLabel?.numberOfLines = 0 // use as many lines as it needs
        
        return cell!
    }

// MARK: - helper functions
    
// MARK: detail view controller section 0
    
    //sets the appropiate content for each row within the first section
    func setSection0Content(_ cell: UITableViewCell, _ indexPath: IndexPath, _ park: Park) {
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(park.getParkName())"
            case 1:
                cell.textLabel?.text = "\(park.getParkLocation())"
            case 2:
                cell.textLabel?.text = "\(park.getArea())"
            case 3:
                cell.textLabel?.text = "Date Formed: \(park.getDateFormed())"
            default:
                break
        }
        
        cell.textLabel?.textAlignment = .center
    }

// MARK: url functions
    
    //goes to park URL if row is clicked
    func goToURL(_ park: Park) {
        let parkURL = NSURL(string: park.getLink())! as URL
        UIApplication.shared.open(parkURL, options: [:], completionHandler: nil)
    }
    
    //fetches an image from the link url
    func fetchImageFromURL(urlString: String, cell: UITableViewCell) {
        let imageUrl = URL(string: urlString)
        
        if let imageData = NSData(contentsOf: imageUrl!), let image = UIImage(data: imageData as Data) {
            cell.imageView?.image = image
        }
    }

// MARK: alert creation
    
    //creates an alert for the "Add to Favorites" Cell row and then adds it to the Favorites array
    func createFavoritesAlert(_ park: Park) {
        let msg = "\(park.getParkName()) \(FAVORITES_ALERT_MSG)"
        let alert = UIAlertController(title: FAVORITES_ALERT_TITLE, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in self.addToFavorites(park) })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }//end createFavoritesAlert
}

