//
//  ParkDetailTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkDetailTableViewController: UITableViewController {
/**************** constant values **************************/
    let NUM_OF_SECTIONS: Int = 6
    let NUM_OF_ROWS: Int = 1
    let NUM_OF_SECTION_0_ROWS: Int = 4
    let STANDARD_ROW_HEIGHT: CGFloat = 44.0
    let MAP_CELL_TITLE: String = "Show on Map"
    let FAVORITES_CELL_TITLE: String = "Add to Favorites"
/**************** variables ********************************/
    var park: Park!
    
/**************** override funcs **************************/
    
    //when view loads, implement variable section heights
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var msg = ""
        switch indexPath.section {
            case 3:
                goToURL(park)
            case 4:
                msg = "Show on Map"
            case 5:
                msg = "Add to favorites?"
            default:
                break
        }
        
        // Pop up Alert
        let alert = UIAlertController(title: "Tapped a Row", message: msg, preferredStyle: .alert)
        
        // handler nil, don't need to do anything when they tap ok button
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        // Deselect the row that they were on
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
                if let checkedUrl = URL(string: park.getLink()) {
                    cell!.imageView?.contentMode = .scaleAspectFit
                    setCellImageView(url: checkedUrl, cell: cell!)
                }
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
    
    func setCellImageView(url: URL, cell: UITableViewCell) {
        getImageDataFromURL(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() { () -> Void in
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
    }
    
    func getImageDataFromURL(url: URL, completion: @escaping(_ data: Data?, _ response: URLResponse, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in completion(data, response!, error)
        }.resume()
    }
    
    //goes to URL if row is clicked
    func goToURL(_ park: Park) {
        let parkURL = NSURL(string: park.getLink())! as URL
        UIApplication.shared.open(parkURL, options: [:], completionHandler: nil)
    }
}
