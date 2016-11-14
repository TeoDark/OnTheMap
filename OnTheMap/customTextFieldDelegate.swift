//
//  CustomTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 08.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var textFieldHasDefaultText:Bool=true
    
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        if(textFieldHasDefaultText==true)
        {
            textField.text=""
            textFieldHasDefaultText=false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
