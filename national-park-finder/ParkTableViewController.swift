//
//  ParkTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkTableViewController: TableViewController {
    var sortedParks: [Park] = []
    
    @IBAction func sortParksArray(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
            case 0:
                sortedParks = parks.sorted {$0.getParkName() < $1.getParkName()}
            case 1:
                sortedParks = parks.sorted {$0.getParkName() > $1.getParkName()}
            case 2:
                sortedParks = parks.sorted { self.getDistance($0.coordinate) < self.getDistance($1.coordinate)}
            default:
                break
        }
        super.tableView.reloadData()
    }
/**************** override functions *******************/
    override func viewDidLoad() {
        super.viewDidLoad()
        sortedParks = self.parks
    }
    
    //return the number of cells to display total
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }

    //display the text for the intial cell view, calls parent class
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.setUpCellObj("ParkCell", sortedParks, indexPath, tableView)
    }
    
    // When it is pushed to navigation your park will now have a title, and information to fill in the sections we created in the ParkDetailGroupTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get a Landmark
        let park = sortedParks[indexPath.row]
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = park.title
        detailVC.park = park
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


