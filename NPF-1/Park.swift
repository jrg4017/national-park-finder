//
//  Park.swift
//  NPF-1
//
//  Created by igmstudent on 9/6/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import Foundation
import CoreLocation

class Park {
    private var parkName: String = ""
    private var parkLocation: String = ""
    private var dateFormed: String = ""
    private var area: String = ""
    private var link: String = ""
    
    /****** variables for CoreLocation *******/
    private var location: CLLocation?
    private var imageLink: String = ""
    private var parkDescription = ""
    
    /****** description for CustomStringConvertible *******/

    
    /****** initializers *******/
    
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation?,imageLink: String, parkDescription: String) {
        self.setParkName(parkName)
        self.setParkLocation(parkLocation)
        self.setDateFormed(dateFormed)
        self.setArea(area)
        self.setLink(link)
        self.setImageLink(imageLink)
        self.setParkDescription(parkDescription)
        self.setLocation(location!)
    }
    
    convenience init() {
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "TBD", location: nil, imageLink: "TBD", parkDescription: "TBD")
    }
    
    /****** accessors and mutators *******/
    func getParkName() -> String { return parkName }
    
    func setParkName(_ value: String) {
        let length = value.characters.count
        
        if (length > 3 || length < 75) {
            parkName = "TBD"
        } else {
            parkName = value
        }
    }
    
    func getParkLocation() -> String { return parkLocation }
    func setParkLocation(_ value: String) { parkLocation = value }
    
    func getDateFormed() -> String { return dateFormed }
    func setDateFormed(_ value: String) { dateFormed = value }
    
    func getArea() -> String { return area }
    func setArea(_ value: String) { area = value }
    
    func getLink() -> String { return link }
    func setLink(_ value: String) { link = value }
    
    func getLocation() -> CLLocation { return location! }
    func setLocation(_ value: CLLocation) { location = value }
    
    func getImageLink() -> String { return imageLink }
    func setImageLink(_ value: String) { imageLink = value}
    
    func getParkDescription() -> String { return parkDescription }
    func setParkDescription(_ value: String) { parkDescription = value }
}
