//
//  FavoritesViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class FavoritesViewController: TableViewController {

    @IBOutlet var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFavorites()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoritesObjectArray = fetchParkArray()
        
        return setUpCellObj("FavoritesCell", favoritesObjectArray, indexPath, tableView)
    }

    
    // When it is pushed to navigation your favorties will now have a title, and information to fill in the sections we created in the LandmarkDetailGroupTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get a park
        let favorite = fetchParkObject(favorites[indexPath.row])
        let detailVC = ParkDetailTableViewController(style: .grouped)
        detailVC.title = favorite.title
        detailVC.park = favorite
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func fetchParkObject(_ parkName: String) -> Park {
        var p = Park()
        
        for park in parks {
            if park.getParkName() == parkName {
                p = park
            }
        }
        
        return p
    }
    
    func fetchParkArray() -> [Park] {
        var fav: [Park] = []
        
        for parkName in favorites {
            let p = fetchParkObject(parkName)
            fav.append(p)
        }
        
        return fav
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let p = fetchParkObject(favorites[indexPath.row])
            removeFromFavorites(p)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
//    func insertRow(_ park: Park) {
//        
////        tabBarController?.selectedIndex = 2
////        
////        let indexPath = IndexPath(row: (favorites.count), section: 1)
////    
////        //self.tableView.beginUpdates()
////        self.addToFavorites(park)
////        self.tableView.insertRows(at: [indexPath], with: .bottom)
////        //self.tableView.endUpdates()
//        
//        self.tableView.beginUpdates()
//        
//        let insertedIndexPathRange = 0..<favorites.count + 1 // total count 4
//        
////        self.addToFavorites(park)
//        
//        let insertedIndexPaths = insertedIndexPathRange.map { IndexPath(row: $0, section: 0) }
//        
//        self.tableView.insertRows(at: insertedIndexPaths, with: .fade)
//        self.tableView.endUpdates()
//    }
    
}

