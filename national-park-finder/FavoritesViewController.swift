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
        
        loadFavorites()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          return setUpCellObj("FavoritesCell", parks, indexPath, tableView)
    }

    // When it is pushed to navigation your favorties will now have a title, and information to fill in the sections we created in the LandmarkDetailGroupTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get a park
        let favorite = getFavoritePark(indexPath)
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = favorite.title
        detailVC.park = favorite
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getFavoritePark(_ indexPath: IndexPath) -> Park {
        
        let parkName = self.favorites[indexPath.row]
        var favoritePark = Park()
        
        for park in parks {
            if park.getParkName() == parkName {
                favoritePark = park
                print("PARK OBJ: \(park.getParkName()) &&&& FAV OBJ: \(parkName)")
            }
        }
        
        return favoritePark
    }

//    override func viewWillAppear(_ animated: Bool) {
//        
//        if(self.isViewLoaded){
//            super.viewWillAppear(animated)
//            super.tableView.reloadData()
//        }
//    }
}


