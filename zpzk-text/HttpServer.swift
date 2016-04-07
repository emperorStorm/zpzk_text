//
//  HttpServer.swift
//  zpzk-text
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation
import UIKit

enum RequestMethod: String {
    case Get = "GET"
    case Post = "POST"
}

protocol HttpRequest {
    func didResult(result: NSDictionary?)
}

class HttpServer {
    
    var delegate: HttpRequest?
    
    func postRequest(url: String,params: [String: AnyObject]?,type: RequestMethod) {
        let session = NSURLSession.sharedSession()
        let urlString = NSURL(string: url)
        let request = NSMutableURLRequest(URL: urlString!)
        var stringBody = ""
        if params != nil {
            for (key,value) in params! {
                stringBody += "\(key)=\(value)&"
            }
        }
        request.HTTPMethod = type.rawValue
        request.HTTPBody = stringBody.dataUsingEncoding(NSUTF8StringEncoding)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print("\(error)")
                return
            }
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            debugPrint("\(jsonResult)")
            self.delegate?.didResult(jsonResult)
        }
        dataTask.resume()
    }
}