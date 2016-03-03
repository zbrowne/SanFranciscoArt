//
//  ViewController.swift
//  SanFranciscoArt
//
//  Created by Zachary Browne on 2/26/16.
//  Copyright © 2016 zbrowne. All rights reserved.
//

import UIKit
import MapKit
import CSwiftV

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
        let fileName = NSBundle.mainBundle().pathForResource("sfPublicArt", ofType: "csv");
        var data: String?
        //        NSLog("fileName: %@", fileName!)
        do {
            data = try String(contentsOfFile: fileName!)
        } catch _ {
            data = nil
            NSLog("unable to open file")
        }
        
        if let _ = data {
            let inputString = data
            let csv = CSwiftV(String: inputString!)
            let artworkDict = csv.keyedRows
            
            // debugging with one value
            let artwork = Artwork.fromCSV(artworkDict![1])
            artworks.append(artwork!)
            
            
            // full loop for when I'm done debuggint with one value
            /* for artworkCSV in artworkDict! {
            let artwork = Artwork.fromCSV(artworkCSV)
            artworks.append(artwork!)
            }
            } */
            print (artworks)
        }
    }
}



