//
//  Helper.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 19.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation
import UIKit

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

func openIfPosibleLinkInBrawser(notSafeURL:String)->Bool{
    if let checkURL = URL(string: notSafeURL) {
        UIApplication.shared.open(checkURL as URL, options: [:], completionHandler:nil)
        return true
    }
    return false
}





