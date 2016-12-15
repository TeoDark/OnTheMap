//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 15.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var tabController: TabBarController?
    var mapAnnotations:[MKAnnotation] = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showStudents()
    {
        mapAnnotations.removeAll()
        for student in DataCenter.sharedInstance.studentsList
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = student.location
            annotation.title = "\(student.firstName) \(student.lastName)"
            annotation.subtitle = student.desiredLink
            mapAnnotations.append(annotation)
        }
        mapView.addAnnotations(mapAnnotations)
    }
    
    func test()
    {
        //let testLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        //centerMapOnLocation(location: testLocation)
        
        for _ in 0...200 {
            let annotation = MKPointAnnotation()
            annotation.coordinate=CLLocationCoordinate2D(latitude: CLLocationDegrees(arc4random_uniform(100)), longitude: CLLocationDegrees(arc4random_uniform(100)))
            annotation.title="TestTitle"
            annotation.subtitle="https://www.youtube.com/watch?v=D4oFSOjSkl8"
            mapAnnotations.append(annotation)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate=CLLocationCoordinate2D(latitude: 51.11, longitude: 17.05)
        annotation.title="TeoTest"
        annotation.subtitle="https://www.google.pl/maps/@51.112473,17.0562557,16.41z/data=!4m2!10m1!1e2?hl=pl"
        mapAnnotations.append(annotation)
        
        mapView.addAnnotations(mapAnnotations)
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
    
    //fucntions from Udacity's PinSample:
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
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
