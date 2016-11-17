//
//  ParkTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkTableViewController: UITableViewController {
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parks.count
    }
    
    // Uncomment and change identifier to 'landmark cell'
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell", for: indexPath)
        
        // Configure the cell...
        let park = parks[indexPath.row]
        cell.textLabel?.text = park.getParkName()
        cell.detailTextLabel?.text = park.getParkLocation()
        // Gives you greater than sign, last time you created a segue, this why is programmatically
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // When it is pushed to navigation your landmark will now have a title, and information to fill in the sections we created in the LandmarkDetailGroupTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get a Landmark
        let park = parks[indexPath.row]
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = park.title
        detailVC.park = park
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


