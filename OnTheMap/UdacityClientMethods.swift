//
//  UdacityClientMethods.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 18.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation

extension UdacityClient{
    
    public func test()
    {
        
        getSession(userName: TestDummy.getLoginToTest(), password: TestDummy.getPasswordToTest())
        getMyLocation()
        /*
        //print(client.tmdbURLFromParameters([:]))
        print(self.testURLFromParameters(["method":("costam" as AnyObject)], withPathExtension: "asdf"))
        print(self.udacityURLFromParameters(["method":("costam" as AnyObject)], withPathExtension: "/session"))
        let url=self.udacityURLFromParameters(nil, withPathExtension: "/session")
        print(url)
        self.taskForMethod(url: url, jsonBody: nil, completionHandlerFor: {_,_ in })
        */
        //https://www.udacity.com/api/session
        //https://udacity.com/apiasdf?method=costam
        //tmdbURLFromParameters
    }
    
    public func getSession(userName:String, password:String)
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
            let directored = parsedResult as! NSDictionary
            let key=(directored["account"] as! NSDictionary)["key"]!
            
            self.getMyLocation(key: key)
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
