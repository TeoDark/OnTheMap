//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 15.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithFBButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappingSingUpButton(_ sender: UIButton) {
        print("Sing Up tapped!")
        openIfPosibleLinkInBrawser(notSafeURL: "https://www.udacity.com/account/auth#!/signup")
    }
}
