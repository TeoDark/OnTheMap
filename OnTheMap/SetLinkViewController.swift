//
//  SetLinkViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 04.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import UIKit
import MapKit

class SetLinkViewController: UIViewController {
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func shareInfo(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToTab", sender: self)
    }
}
