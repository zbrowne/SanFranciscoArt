//
//  Artwork.swift
//  SanFranciscoArt
//
//  Created by Zachary Browne on 2/26/16.
//  Copyright © 2016 zbrowne. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let medium: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, medium: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.medium = medium
        self.coordinate = coordinate
        
        super.init()
    }
    
    // read csv dictionary here. TODO: Make this work...
    class func fromCSV(csv: [[String:String]]?) -> Artwork? {
        // 1
        let title = csv![1]["title"]
        let locationName = csv![1]["location_description"]
        let medium = csv![1]["medium"]
        
        // 2
        let latitude = (csv![1]["geometry"]! as NSString).doubleValue
        let longitude = (csv![1]["geometry"]! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 3
        return Artwork(title: title!, locationName: locationName!, medium: medium!, coordinate: coordinate)
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [CNPostalAddressStreetKey: subtitle as! AnyObject]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}