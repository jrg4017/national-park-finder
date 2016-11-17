//
//  ParkDetailTableViewController.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

class ParkDetailTableViewController: UITableViewController {
    
    var park: Park!
    let heightForEachSection: [Double] = [44.0, 88.0, 88.0, 44.0, 44.0, 44.0]
    
    
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
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //first section has different row #s
        if section == 0 {
            return 4
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if indexPath.section == 2{
//            return 88.0
//        }
//        // standard height
//        return 44.0
        return CGFloat(heightForEachSection[indexPath.section])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var msg = ""
        switch indexPath.section {
            case 0:
                msg = "You tapped Park Name"
            case 0:
                msg = "You tapped Park State"
            case 0:
                msg = "You tapped Park Coordinates"
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        switch indexPath.section {
            case 0:
                cell!.textLabel?.text = "\(park.getParkName()) \n \(park.getParkLocation()) \n \(park.getArea()) \n \(park.getDateFormed())"
            case 1:
                insertImageViewCell(cell!, park)
            case 2:
                cell!.textLabel?.text = "Latitude: \(park.coordinate.latitude) \nLongitude: \(park.coordinate.longitude)"
            default:
                break
        }
        cell?.textLabel?.numberOfLines = 0 // use as many lines as it needs
        
        return cell!
    }
    
    func insertImageViewCell(_ cell: UITableViewCell, _ park: Park){
        var imageCache = [String : UIImage]()
        let imageView = UIImageView()
        let url = park.getImageLink()
        
        if let img = imageCache[url] {
            imageView.image = img
        } else {
            let request: NSURLRequest = NSURLRequest(url: NSURL(string: url)! as URL)
            let mainQueue = OperationQueue.main
            
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    let image = UIImage(data: data!)
                    imageCache[url] = image
                    
                    DispatchQueue.main.async (execute: {
                        imageView.image = image
                    })
                }
            })
        }
        
        cell.imageView?.image = imageView.image
    
//        let url = NSURL(string: park.getImageLink()) as! URL
//        let data = NSData(contentsOf: url) as! Data
//        
//        cell.imageView!.image = UIImage(data: data)

    }
    
    func getSectionRowInfo(_ indexPath: IndexPath, _ cell: UITableViewCell) {
        
    }

}
