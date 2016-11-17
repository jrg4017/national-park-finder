//
//  TableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/17/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var parkList = Parks()
    var parks: [Park] {
        get {
            return self.parkList.parkList
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
