//
//  Constants.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 17.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation

public class Constants{
    
    static let apiScheme = "https"
    static let udacity = Udacity()
    static let parse=Parse()
}

public class Udacity{
    public let apiHost = "www.udacity.com"
    public let apiPath = "/api"
    public let session="/session"
    public let users="/users"
}

public class Parse{
    
    public let apiParse="parse.udacity.com"
    public let studenLocation="/parse/classes/StudentLocation"
    public let parseApplicationId="QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    public let restApiKey="QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
}

/*
 https://parse.udacity.com/parse/classes/StudentLocation
 https://parse.udacity.com/parse/classes/StudentLocation
 https://parse.udacity.com/parse/classes/StudentLocation
 https://parse.udacity.com/parse/classes/StudentLocation/<objectId>
 https://www.udacity.com/api/session
 https://www.udacity.com/api/session
 https://www.udacity.com/api/session
 https://www.udacity.com/api/users/<user_id>
 */
