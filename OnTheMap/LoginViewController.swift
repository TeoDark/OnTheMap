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
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var customTextFieldDelegate1=CustomTextFieldDelegate()
    var customTextFieldDelegate2=CustomTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //solution from:http://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
        setLeftMarginForBothTextFields()
        emailTextField.delegate=customTextFieldDelegate1
        passwordTextField.delegate=customTextFieldDelegate2
        
        print("Jakies glupoty")
        let client = UdacityClient()
        client.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //rly concern about quality of code here:
        resetTextField(field: emailTextField, defaultText: "Email", delegate: customTextFieldDelegate1)
        resetTextField(field: passwordTextField, defaultText: "Password", delegate: customTextFieldDelegate2)
    }
    
    func resetTextField(field:UITextField,defaultText:String, delegate: CustomTextFieldDelegate)
    {
        field.text=defaultText
        delegate.resetToDefaultText(defaultText: defaultText)
    }
    
    @IBAction func tappingSingUpButton(_ sender: UIButton) {
        
        errorVisable(isVisable: false)
        if(!openIfPosibleLinkInBrawser(notSafeURL: "https://www.udacity.com/account/auth#!/signup"))
        {
          errorVisable(isVisable: true,text: "Udacity page could not be opened!")
        }
    }
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
    }
    
    func setLeftMarginForBothTextFields()
    {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    }
    
    func errorVisable(isVisable:Bool, text:String = " ")
    {
        errorLabel.isEnabled=isVisable
        errorLabel.text=text
    }
    
    @IBAction func test(_ sender: Any) {
        if errorLabel.isHidden==true{
            errorLabel.isHidden=false
            activityIndicator.isHidden=true
        }
        else
        {
            errorLabel.isHidden=true
            activityIndicator.isHidden=false
        }
    }
}
