//
//  WebClient.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 13.12.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//

import Foundation

class WebClient {

    static let sharedInstance = WebClient()
    var session = URLSession.shared
    
    private init() {}
    
    func taskForMethod(request:NSMutableURLRequest, completionHandlerFor: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) ->Void { //-> URLSessionDataTask {
    
    //example GET and POST taskForMethod had allmoste same code why keep 2 of them?
    
    /* 2/3. Build the URL, Configure the request */
    if(request.httpBody != nil){
        print("it's POST!")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    else
    {
        request.httpMethod = "GET"
        print("it's GET!")
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
        //self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerFor)
        self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerFor)
    }
    
    /* 7. Start the request */
    task.resume()
    
    //return task
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        // using more than one service force to find bracket to trim properly
        let oldData:NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
        let rangeWithBracket: NSRange = oldData.range(of: "{")
        let trimFrom:Int = (rangeWithBracket.toRange()?.lowerBound)!;
        print("tutaj sie zaczyna: \(trimFrom)")
        
        let range = Range(uncheckedBounds: (trimFrom, data.count))
        let newData = data.subdata(in: range)
        print("Teraz podaje dane:")
        print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
        print("Skonczylem")
        var parsedResult: Any? = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .mutableContainers)
            print("json!")
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
            print("Corventing To Json Failed!")
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult as AnyObject?, nil)
    }
    
}
