//
//  ViewController.swift
//  SanFranciscoArt
//
//  Created by Zachary Browne on 2/26/16.
//  Copyright © 2016 zbrowne. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var artworks = [Artwork]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // hardcoded lat/long for San Francisco
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        centerMapOnLocation(initialLocation)
        loadInitialData()
        mapView.addAnnotations(artworks)
    }
    
    let regionRadius: CLLocationDistance = 14000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func loadInitialData() {
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
        var data : NSData?
        do {
            data = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
        } catch _ {
            data = nil
        }
        
        // 2
        let jsonObject: AnyObject!
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions(rawValue: 0))
        } catch _ {
            jsonObject = nil
        }
        
        // 3
        if let jsonObject = jsonObject as? [String: AnyObject],
            // 4
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                for artworkJSON in jsonData {
                    if let artworkJSON = artworkJSON.array,
                        // 5
                        artwork = Artwork.fromJSON(artworkJSON) {
                            artworks.append(artwork)
                    }
                }
        }
    }
}

