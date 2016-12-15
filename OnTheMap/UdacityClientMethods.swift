//
//  UdacityClientMethods.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 18.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation

extension UdacityClient{
    
    
    public func getStudenList(completionHandlerFor: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void)
    {
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=5&order=-updatedAt")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let getSessionClosure:((AnyObject?, NSError?) -> Void) =
            {(_ result: AnyObject?, _ error: NSError?) -> Void
                in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(result != nil)
                    {
                        print("Teraz robie tak jakby to dzialalo! Próbuje zmienic na slownik a pozniej dodac do data center!")
                        DataCenter.replaceCurrentStudentList(studentList: result as! [String:Any])
                    }
                    else
                    {
                        print("Lista studentow była pusa :<")
                    }
                    print("A teraz orgnialnele przekazane mi:")
                    completionHandlerFor(result, error)
                    })
            }
        WebClient.sharedInstance.taskForMethod(request: request, completionHandlerFor: getSessionClosure)
        //taskForMethod(url: url, jsonBody: httpBody, completionHandlerFor: getSessionClosure)
    }
    
    public func getSession2(userName:String, password:String, completionHandlerFor: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void)
    {
        let url = URL(string: "https://www.udacity.com/api/session")!
        let httpBody="{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
        
        
        let getSessionClosure:((AnyObject?, NSError?) -> Void) =
        {(_ result: AnyObject?, _ error: NSError?) -> Void
            in
            DispatchQueue.main.async(execute: { () -> Void in
            print("Teraz rozpoczynam session closure")
            if(result != nil)
            {
                let parsedResult = result as! [String:AnyObject]
                //DataCenter.sharedInstance.account.key = (parsedResult["account"] as! [String:Int])["key"]!
                //DataCenter.sharedInstance.account.registered = (parsedResult["account"] as! [String:Int])["registered"]!
                //DataCenter.sharedInstance.session.expiration = (parsedResult["session"] as! [String:String])["expiration"]!
                //DataCenter.sharedInstance.session.id = (parsedResult["session"] as! [String:String])["id"]!

                DataCenter.sharedInstance.account.key = (parsedResult["account"] as! [String:Any])["key"]! as! String
                DataCenter.sharedInstance.account.registered = (parsedResult["account"] as! [String:Any])["registered"]! as? Bool
                DataCenter.sharedInstance.session.expiration = (parsedResult["session"] as! [String:Any])["expiration"]! as! String
                DataCenter.sharedInstance.session.id = (parsedResult["session"] as! [String:Any])["id"]! as! String

                print(DataCenter.sharedInstance.account.key)
                print(DataCenter.sharedInstance.account.registered)
                print(DataCenter.sharedInstance.session.expiration)
                print(DataCenter.sharedInstance.session.id)
            }
            print("A teraz orgnialnele przekazane mi:")
            completionHandlerFor(result, error)
            })
        }
        
        taskForMethod(url: url, jsonBody: httpBody, completionHandlerFor: getSessionClosure)
    
    
    }
    
    public func getSession(userName:String, password:String, completionHandlerFor: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void)
    {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: String.Encoding.utf8)
        request.httpBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        print(request.httpBody)
        print(request)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                print("error!: \(error)")
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count))
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
            
            var parsedResult:Any? = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .mutableContainers)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
                print("huh?")
            }
            //let directored = parsedResult as! NSDictionary
            //let key=(directored["account"] as! NSDictionary)["key"]!
            
            //self.getMyLocation(key: key)
        }
        task.resume()/*
        let newData = "{\"account\": {\"registered\": true, \"key\": \"300606645\"}, \"session\": {\"id\": \"1511044734S5049aa62b11be4f8de926d88439d829a\", \"expiration\": \"2017-01-17T22:38:54.249070Z\"}}"
        var parsedResult:Any? = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData.data(using: .utf8)!, options: .mutableContainers)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
            print("huh?")
        }
        let directored = parsedResult as! NSDictionary
        print((directored["account"] as! NSDictionary)["key"]!)
        //print(parsedResult!["session"]["id"])*/
    }
    
    
    public func getMyLocation(key:String)
    {

        
    print("probaPobierania:")
    let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?where={\"uniqueKey\":\"300606645\"}"
        let url = udacityURLFromParameters(["where":"{\"uniqueKey\":\"300606645\"}" as AnyObject])
    print(url)
    let request = NSMutableURLRequest(url: url)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil { // Handle error
    return
    }
    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
    }
    task.resume()
    }
}
