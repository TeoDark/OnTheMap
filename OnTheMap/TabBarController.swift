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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func tappingAddPinButton(_ sender: UIBarButtonItem) {
        print("Dzialam!")
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
    
    @IBAction func tappingRefreshButton(_ sender: UIBarButtonItem) {
        print("I acting like refreshing but rly not!")
    }
    
    @IBAction func tappingLogoutButton(_ sender: UIBarButtonItem) {
        print("I acting like loging out but rly not!")
    }

    func setNavigationBarTitle(title:String){
        navigationBar.title=title
    }
}
