//
//  FavoritesViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class FavoritesViewController: TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//          return setUpCellObj("FavoritesCell", parks, indexPath, tableView)
//    }
//    
//    // When it is pushed to navigation your landmark will now have a title, and information to fill in the sections we created in the LandmarkDetailGroupTableVC
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Get a Landmark
//        let park = parks[indexPath.row]
//        let detailVC = ParkDetailTableViewController(style: .grouped)
//        detailVC.title = park.title
//        detailVC.park = park
//        navigationController?.pushViewController(detailVC, animated: true)
//    }

    
}


