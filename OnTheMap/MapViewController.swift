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
        print(navigationController?.prefersStatusBarHidden)
        navigationController?.setNavigationBarHidden(true, animated: false)
        print(navigationController?.prefersStatusBarHidden)
        //Buttons - this code sime like bad practice, plz rate it:
        /*
        let naviButtons=navigationController?.navigationBar.subviews.filter({(($0 as? UIButton) != nil)}) as! [UIButton]
        let leftButton = naviButtons.first(where: {$0.currentTitle=="Add Pin"})
        let rightButton = naviButtons.first(where: {$0.currentTitle=="Refresh"})
        let logOutButton = naviButtons.first(where: {$0.currentTitle=="Refresh"})
        leftButton?.addTarget(self, action: #selector(tappingAddPinButton), for: .touchUpInside)
        rightButton?.addTarget(self, action: #selector(tappingRefreshButton), for: .touchUpInside)
         */
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
    
    /*
     Additional notes:
     Recomended Tab Icon Sizes (from: http://stackoverflow.com/questions/18068597/what-size-should-tabbar-images-be ):
     @1x : about 25 x 25 (max: 48 x 32)
     @2x : about 50 x 50 (max: 96 x 64)
     @3x : about 75 x 75 (max: 144 x 96)
     Aplication Tab Images:
     List - https://www.iconfinder.com/icons/536275/bullet_format_list_text_icon#size=24
     Map - https://www.iconfinder.com/icons/175440/map_marker_icon#size=64
     Navigation Bar Icons Sizes (from: http://stackoverflow.com/questions/22607674/ios-navigation-bar-item-image-size):
     @1: 22 x 22
     @2: 44 x 44
     @3: 66 x 66
     Pin - https://www.iconfinder.com/icons/763236/gps_location_map_marker_pin_icon#size=64
     */
}
