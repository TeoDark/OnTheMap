//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 17.11.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation


class UdacityClient: NSObject {
    var session = URLSession.shared
    //var config =
    var sessionID: String? = nil
    
    func taskForMethod(url:URL, jsonBody: String?, completionHandlerFor: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) ->Void { //-> URLSessionDataTask {
        
        //example GET and POST taskForMethod had allmoste same code why keep 2 of them?
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: url)
        if(jsonBody != nil){
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonBody?.data(using: String.Encoding.utf8)
        }
        else
        {
            request.httpMethod = "GET"
        }

        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print("Pojawil sie blad kurna!")
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerFor(nil, NSError(domain: "taskForGETorPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            print("converting:")
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerFor)
            
        }
        
        /* 7. Start the request */
        task.resume()
        
        //return task
    }

    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        let range = Range(uncheckedBounds: (5, data.count))
        let newData = data.subdata(in: range)
        print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
        var parsedResult: Any? = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .mutableContainers)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult as AnyObject?, nil)
    }
    
    public func udacityURLFromParameters(_ parameters: [String:AnyObject]?, withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.apiScheme
        components.host = Constants.udacity.apiHost
        components.path = Constants.udacity.apiPath + (withPathExtension ?? "")
        
        if(parameters != nil){
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters! {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        return components.url!
    }
    
    public func testURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3" + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}


