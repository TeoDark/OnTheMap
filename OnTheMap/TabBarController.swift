//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 18.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var pinButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var mapView: MapViewController?
    var tableView: TableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //finding children
        mapView=self.childViewControllers.first(where: {$0 is MapViewController}) as? MapViewController
        tableView=self.childViewControllers.first(where: {$0 is TableViewController}) as? TableViewController
    }
        
    @IBAction func tappingAddPinButton(_ sender: UIBarButtonItem) {

        if(DataCenter.sharedInstance.myInfoIsAllreafyPosted == nil)
        {
            print("Sprawdzam czy czasem informacje nie sa umieszczone")
            tableView?.setActivityIndicatorAsHidden(hide: false)
            mapView?.setActivityIndicatorAsHidden(hide: false)
            DataCenter.sharedInstance.udacityClient.checkIfMyLocationIsPosted(completionHandlerFor: checkIfMyLocationIsAllreadyPosted)
        }
        else
        {
            print("Nie ma co sprawdzac!")
            displayAleftBeforePresentFindLocationIfNeeded()
        }

    }
    
    func displayAleftBeforePresentFindLocationIfNeeded()
    {
        if(DataCenter.sharedInstance.myInfoIsAllreafyPosted == true)
        {
            //solution from: http://nshipster.com/uialertcontroller/
            let alertController = UIAlertController(title: nil, message: "You Have Already Posted a Student Location. Would You Like to Overwrite Your Current Location?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let overwriteAction = UIAlertAction(title: "Overwrite!", style: .destructive)
            {
                (action) in
                self.presentFindLocation()
            }
        
            alertController.addAction(overwriteAction)
            alertController.addAction(cancelAction)
        
            self.present(alertController, animated: true)
            {
            // ...
            }
        }
        else
        {
            self.presentFindLocation()
        }
    }
    
    @IBAction func tappingRefreshButton(_ sender: UIBarButtonItem) {
        //sending to both controllers becouse I dont know which one is currently displayed - looks like bad practice
        tableView?.setActivityIndicatorAsHidden(hide: false)
        mapView?.setActivityIndicatorAsHidden(hide: false)
        
        DataCenter.sharedInstance.udacityClient.getStudenList(completionHandlerFor: reactToRecivedStudentList)
    }
    
    @IBAction func tappingLogoutButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindToLogin", sender: self)
    }

    func setNavigationBarTitle(title:String){
        navigationBar.title=title
    }
    
    func presentFindLocation()
    {
        performSegue(withIdentifier: "SagueToFindLocation", sender: nil)
    }
    
    @IBAction func unwindToTab(segue: UIStoryboardSegue) {
    }
    // MARK Networking part
    func reactToRecivedStudentList(data: AnyObject? ,error:NSError?)
    {

        tableView?.tableView.reloadData()
        mapView?.showStudents()
        //need to refresh!
    
        tableView?.setActivityIndicatorAsHidden(hide: true)
        mapView?.setActivityIndicatorAsHidden(hide: true)
    }
    
    func checkIfMyLocationIsAllreadyPosted(data: AnyObject? ,error:NSError?)
    {
        displayAleftBeforePresentFindLocationIfNeeded()
        
        tableView?.setActivityIndicatorAsHidden(hide: true)
        mapView?.setActivityIndicatorAsHidden(hide: true)
    }
    
}
