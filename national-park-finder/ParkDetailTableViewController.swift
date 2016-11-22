//
//  ParkDetailTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkDetailTableViewController: TableViewController {
/**************** constant values **************************/
    let NUM_OF_SECTIONS: Int = 6
    let NUM_OF_ROWS: Int = 1
    let NUM_OF_SECTION_0_ROWS: Int = 4
    let STANDARD_ROW_HEIGHT: CGFloat = 44.0
    let MAP_CELL_TITLE: String = "Show on Map"
    let FAVORITES_CELL_TITLE: String = "Add to Favorites"
    let FAVORITES_ALERT_TITLE: String = "Favorites"
    let FAVORITES_ALERT_MSG: String = "added to Favorites"
/**************** variables ********************************/
    var park: Park!
    
/**************** override funcs **************************/
    
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
//            case 4:
//                createAlert(title: "Maps", msg: "Go to map")
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
                let url = URL(string: park.getImageLink())
                cell!.imageView?.downloadedFrom(url: url!)
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

/**************** helper functions **************************/
    
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
    
    //goes to URL if row is clicked
    func goToURL(_ park: Park) {
        let parkURL = NSURL(string: park.getLink())! as URL
        UIApplication.shared.open(parkURL, options: [:], completionHandler: nil)
    }
    
    //creates an alert for the "Add to Favorites" Cell row and then adds it to the Favorites array
    func createFavoritesAlert(_ park: Park) {
        let msg = "\(park.getParkName()) \(FAVORITES_ALERT_MSG)"
        let alert = UIAlertController(title: FAVORITES_ALERT_TITLE, message: msg, preferredStyle: .alert)
        
        // handler nil, don't need to do anything when they tap ok button
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.addToFavorites(park)})
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            print("success")
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
