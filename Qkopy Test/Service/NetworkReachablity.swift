//
//  NetworkReachablity.swift
//  Qkopy Test
//
//  Created by user on 27/06/20.
//  Copyright © 2020 user. All rights reserved.
//


import Foundation
import SystemConfiguration

public class Reachability {
    // Check if internet connection is available
    class func isConnectedToNetwork() -> Bool {
        var status:Bool = false
        let url = NSURL(string: "https://google.com")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response:URLResponse?
        do {
            let _ = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response) as NSData?
        }
        catch let error as NSError {
        }
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
        return status
    }
}


