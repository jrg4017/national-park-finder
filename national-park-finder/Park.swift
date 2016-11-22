//
//  Park.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/16/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Park: NSObject, NSCoding, MKAnnotation {
/**************** data.plist vars ****************************/
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
    private var location: CLLocation? //variable for CoreLocation
    
/**************** MKAnnotation vars **************************/
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return self.location!.coordinate
        }
    }
    
    //optional
    @objc var title: String? {
        get {
            return self.parkName
        }
    }
    
    @objc var subtitle: String? {
        get {
            return self.parkLocation
        }
    }
    
/**************** description for CustomStringConvertible *******/
    override var description : String {
        return "{\n\tparkName: \(self.parkName)\n\tparkLocation: \(self.parkLocation)\n\tdateFormed: \(dateFormed)\n\tarea: \(self.area)\n\tlink: \(self.link)\n\tlocation: \(self.location!)\n\timageLink: \(self.imageLink)\n\tparkDescription: \(self.parkDescription) \n}"
    }
    
/**************** initializer funcs ****************************/
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation?,imageLink: String, imageName: String, imageSize: String, imageType: String, parkDescription: String) {
        
        self.parkName = parkName
        self.parkLocation = parkLocation
        self.dateFormed = dateFormed
        self.area = area
        self.link = link
        self.location = location
        self.imageLink = imageLink
        self.imageName = imageName
        self.imageSize = imageSize
        self.imageType = imageType
        self.parkDescription = parkDescription
        
        super.init()
    }
    
    override convenience init() {
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "TBD", location: nil, imageLink: "TBD", imageName: "Unknown", imageSize: "Unknown", imageType: "Unknown",parkDescription: "TBD")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.parkName = aDecoder.decodeObject(forKey: "parkName") as! String
        self.parkLocation = aDecoder.decodeObject(forKey: "parkLocation") as! String
        self.dateFormed = aDecoder.decodeObject(forKey: "dateFormed") as! String
        self.area = aDecoder.decodeObject(forKey: "area") as! String
        self.link = aDecoder.decodeObject(forKey: "link") as! String
        
//        let lattitude = (aDecoder.decodeObject(forKey: "lattitude") as! NSString).doubleValue
//        let longitude = (aDecoder.decodeObject(forKey: "lattitude") as! NSString).doubleValue
//        self.location = CLLocation(latitude: lattitude, longitude: longitude)
        
        self.imageLink = aDecoder.decodeObject(forKey: "imageLink") as! String
        self.imageName = aDecoder.decodeObject(forKey: "imageName") as! String
        self.imageSize = aDecoder.decodeObject(forKey: "imageSize") as! String
        self.imageType = aDecoder.decodeObject(forKey: "imageType") as! String
        self.parkDescription = aDecoder.decodeObject(forKey: "description") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.parkName, forKey: "parkName")
        aCoder.encode(self.parkLocation, forKey: "parkLocation")
        aCoder.encode(self.dateFormed, forKey: "dateFormed")
        aCoder.encode(self.area, forKey: "area")
        aCoder.encode(self.link, forKey: "link")
        aCoder.encode(self.location?.coordinate.latitude, forKey: "lattitude")
        aCoder.encode(self.location?.coordinate.longitude, forKey: "longitude")
        aCoder.encode(self.imageLink, forKey: "imageLink")
        aCoder.encode(self.imageName, forKey: "imageName")
        aCoder.encode(self.imageSize, forKey: "imageSize")
        aCoder.encode(self.imageType, forKey: "imageType")
        aCoder.encode(self.parkDescription, forKey: "description")
    }
    
/**************** accessors & mutators **************************/
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

