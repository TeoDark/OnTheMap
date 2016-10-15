//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 15.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var addPinButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: testLocation)
        print(navigationController?.navigationBar.subviews.count)
        print(navigationController?.navigationBar.subviews[0])
        print(navigationController?.navigationBar.subviews[1])
        print(navigationController?.navigationBar.subviews[2])
        print(navigationController?.navigationBar.subviews[3])
        print(navigationController?.navigationBar.subviews[4])
        
        //addPinButton=navigationController!.navigationBar.subviews[2]
        print("czy ma?")
        print(navigationController?.navigationBar.subviews.contains(where: {$0.tag==2}))
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function from: https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func tappingAddPin(_ sender: UIBarButtonItem) {
        print("Dzialam!")
        let alert = UIAlertController(title: "Pin allready egsist!", message: "override existing pin?", preferredStyle: UIAlertControllerStyle.alert)
        show(alert, sender: nil)
    }
}
