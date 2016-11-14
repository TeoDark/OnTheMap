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
    var tabController: TabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let testLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        //centerMapOnLocation(location: testLocation)
        
        //navigationController?.navigationBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tabController=navigationController?.viewControllers.first(where: {$0 is TabBarController}) as? TabBarController
        print("jestm w mapie i: \(tabController)")
        tabController?.setNavigationBarTitle(title: "Map")
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func setActivityIndicatorAsHidden(hide:Bool)
    {
        activityIndicator?.isHidden=hide
    }
    
    //function from: https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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
