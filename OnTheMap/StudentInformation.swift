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
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(cordinates:CLLocationCoordinate2D) {
        coordinate=cordinates
        title="moo?"
        subtitle="https://www.youtube.com/watch?v=D4oFSOjSkl8"
    }
}
