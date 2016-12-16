//
//  DataCenter.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 16.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation
import MapKit

public class DataCenter
{
    static let sharedInstance = DataCenter()
    private init() {}
    
    let udacityClient = UdacityClient()
    let session = Session()
    let account = Account()
    
    var mapAnnotations:[MKAnnotation]=[MKAnnotation]()
    var studentsList:[StudentInformation] = [StudentInformation]()
    
    var myInfoIsAllreafyPosted:Bool?
    
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
    
    public static func replaceCurrentStudentList(studentList:[String:Any])
    {
        sharedInstance.studentsList.removeAll()
        if(studentList["results"] != nil){
            let students = studentList["results"] as! [[String:Any]]
            for student in students {
            sharedInstance.studentsList.append(StudentInformation(studentInfoIn: student))
            }
        }
        else{
            print("Errrora!")
        }
    }
    
}



