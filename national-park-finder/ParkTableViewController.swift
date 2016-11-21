//
//  ParkTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkTableViewController: TableViewController {
/**************** override functions *******************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //return the number of cells to display total
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    

    //display the text for the intial cell view, calls parent class
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.setUpCellObj("ParkCell", parks, indexPath, tableView)
    }
    
    // When it is pushed to navigation your park will now have a title, and information to fill in the sections we created in the ParkDetailGroupTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get a Landmark
        let park = parks[indexPath.row]
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = park.title
        detailVC.park = park
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


