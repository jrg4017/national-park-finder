//
//  FavoritesViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

/**
  * creates a UITableView for all of the users' favorite parks
  * see: TableViewController for shared functions
  */
class FavoritesViewController: TableViewController {

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
        self.tableView.reloadData()
    }

// MARK: - UITableViewDelegate functions
    
    //number of rows to display, equal to total favorited
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    //sets up a UITableViewCell for each favorited park
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoritesObjectArray = fetchParkArray()
        
        return setUpCellObj("FavoritesCell", favoritesObjectArray, indexPath, tableView)
    }

    // pushes a park detail to the nav controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //gets park object from favorites ([String])
        let favorite = fetchParkObject(favorites[indexPath.row])
        
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = favorite.title
        detailVC.park = favorite
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // allows deleting to occur when edit is pressed
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //number of sections available
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //deletes the UITableViewCell  from the UITableView and favorites array
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let p = fetchParkObject(favorites[indexPath.row])
            removeFromFavorites(p)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
// MARK: - transforms favorites strings to Park
    
    //gets the park object for a single park name
    func fetchParkObject(_ parkName: String) -> Park {
        var p = Park()
        
        for park in parks {
            if park.getParkName() == parkName {
                p = park
            }
        }
        
        return p
    }
    
    //gets all of the Park object in the favorites array
    func fetchParkArray() -> [Park] {
        var fav: [Park] = []
        
        for parkName in favorites {
            let p = fetchParkObject(parkName)
            fav.append(p)
        }
        
        return fav
    }//end fetchParkObject
}

