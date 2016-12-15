//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 16.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct StudentInformation {
    let firstName:String
    let lastName:String
    let location:CLLocationCoordinate2D
    let desiredLink:String
    
    init (studentInfoIn:[String:Any])
    {
        if (studentInfoIn["firstName"] != nil && studentInfoIn["lastName"] != nil && studentInfoIn["mediaURL"] != nil ){
            firstName = studentInfoIn["firstName"] as! String
            lastName = studentInfoIn["lastName"] as! String
            location = CLLocationCoordinate2DMake(CLLocationDegrees(studentInfoIn["longitude"] as! Double), CLLocationDegrees(studentInfoIn["latitude"] as! Double))
            desiredLink = studentInfoIn["mediaURL"] as! String
        }
        else
        {
            print("Student didnt have required info! Added fake empty student insteed ;<")
            firstName = ""
            lastName = ""
            location = CLLocationCoordinate2DMake(0,0)
            desiredLink = ""
        }
    }
    
    func saySomethingAboutYourself()
    {
        print("\(firstName) \(lastName) geo: (\(location.latitude),\(location.longitude)) link: \(desiredLink)")
    }
}
