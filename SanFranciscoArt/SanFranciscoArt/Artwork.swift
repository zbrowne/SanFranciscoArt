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
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    // read csv dictionary here
/*    class func fromCSV(csv: [[String: String]]) -> Artwork? {
        // 1
        var title: String
        if let titleOrNil =  {
            title = titleOrNil
        } else {
            title = ""
        }
        let locationName = csv[12].string
        let discipline = csv[15].string
        
        // 2
        let latitude = (csv[18].string! as NSString).doubleValue
        let longitude = (csv[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 3
        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    } */
    
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