//
//  Park.swift
//  npf2
//
//  Created by Julianna Gabler on 9/29/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import Foundation
import CoreLocation

class Park: CustomStringConvertible {
    private var parkName: String = ""
    private var parkLocation: String = ""
    private var dateFormed: String = ""
    private var area: String = ""
    private var link: String = ""
    private var imageLink: String = ""
    private var imageName: String = ""
    private var imageSize: String = ""
    private var imageType: String = ""
    private var parkDescription: String = ""
    
    /****** variables for CoreLocation *******/
    private var location: CLLocation?
    
    /****** description for CustomStringConvertible *******/
    var description : String {
        return "{\n\tparkName: \(self.parkName)\n\tparkLocation: \(self.parkLocation)\n\tdateFormed: \(dateFormed)\n\tarea: \(self.area)\n\tlink: \(self.link)\n\tlocation: \(self.location!)\n\timageLink: \(self.imageLink)\n\tparkDescription: \(self.parkDescription) \n}"
    }
    
    /****** initializers *******/
    
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation?,imageLink: String, imageName: String, imageSize: String, imageType: String, parkDescription: String) {
        self.setParkName(parkName)
        self.setParkLocation(parkLocation)
        self.setDateFormed(dateFormed)
        self.setArea(area)
        self.setLink(link)
        self.setImageLink(imageLink)
        self.setImageName(imageName)
        self.setImageSize(imageSize)
        self.setImageType(imageType)
        self.setParkDescription(parkDescription)
        self.setLocation(location!)
    }
    
    convenience init() {
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "TBD", location: nil, imageLink: "TBD", imageName: "Unknown", imageSize: "Unknown", imageType: "Unknown",parkDescription: "TBD")
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
    
    func getParkLocation() -> String { return self.parkLocation }
    func setParkLocation(_ value: String) { self.parkLocation = value }
    
    func getDateFormed() -> String { return self.dateFormed }
    func setDateFormed(_ value: String) { self.dateFormed = value }
    
    func getArea() -> String { return self.area }
    func setArea(_ value: String) { self.area = value }
    
    func getLink() -> String { return self.link }
    func setLink(_ value: String) { self.link = value }
    
    func getLocation() -> CLLocation { return self.location! }
    func setLocation(_ value: CLLocation) { self.location = value }
    
    func getImageLink() -> String { return self.imageLink }
    func setImageLink(_ value: String) { self.imageLink = value}
    
    func getImageName() -> String { return self.imageName }
    func setImageName(_ value: String) { self.imageName = value }
    
    func getImageSize() -> String { return self.imageSize }
    func setImageSize(_ value: String) { self.imageSize = value }
    
    func getImageType() -> String { return self.imageType }
    func setImageType(_ value: String) { self.imageType = value }
    
    func getParkDescription() -> String { return self.parkDescription }
    func setParkDescription(_ value: String) { self.parkDescription = value }
}
