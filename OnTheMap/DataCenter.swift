//
//  DataCenter.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 16.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation

public class DataCenter
{
    static let sharedInstance = DataCenter()
    private init() {}
    
    let udacityClient = UdacityClient()
    let session = Session()
    let account = Account()
    
    
    // MARK: webOperationInProgress
    private static var webOperationInProgress:Bool=false
    
    public static func canIStartWebOperation() -> Bool
    {
        return webOperationInProgress
    }
    
    public static func startedWebOperation()
    {
        webOperationInProgress=true
    }
    
    public static func endedWebOperation()
    {
        webOperationInProgress=false
    }
    // MARK: sessionID
    private static var sessionId:String?
    
    public static func setSessionId(newId:String)
    {
        sessionId=newId
    }
    public static func getSessionId() ->String?
    {
        return sessionId
    }

    
    class Session
    {
        var expiration:String = ""
        var id:String = ""
    }
    
    class Account
    {
        var key:String = ""
        var registered:Bool? 
    }
    
}



