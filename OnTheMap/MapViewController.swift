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
        //centerMapOnLocation(location: testLocation)

        //Buttons:
        let naviButtons=navigationController?.navigationBar.subviews.filter({(($0 as? UIButton) != nil)}) as! [UIButton]
        let leftButton = naviButtons.first(where: {$0.currentTitle=="Add Pin"})
        let rightButton = naviButtons.first(where: {$0.currentTitle=="Refresh"})
        leftButton?.addTarget(self, action: #selector(tappingAddPinButton), for: .touchUpInside)
        rightButton?.addTarget(self, action: #selector(tappingRefreshButton), for: .touchUpInside)
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
    
    @IBAction func tappingAddPinButton(_ sender: UIButton) {
        print("Dzialam!")
        //let alert = UIAlertController(title: "Pin allready egsist!", message: "override existing pin?", preferredStyle: UIAlertControllerStyle.alert)
        //navigationController?.pushViewController(alert, animated: true)
        //show(alert, sender: nil)
        
        //solution from: http://nshipster.com/uialertcontroller/
        let alertController = UIAlertController(title: nil, message: "You Have Already Posted a Student Location. Would You Like to Overwrite Your Current Location?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let overwriteAction = UIAlertAction(title: "Overwrite!", style: .destructive) { (action) in print(action) }
        alertController.addAction(overwriteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        
    }
    
    @IBAction func tappingRefreshButton(sender: UIButton){
        print("I acting like refreshing but rly not!")
    }
    
}
