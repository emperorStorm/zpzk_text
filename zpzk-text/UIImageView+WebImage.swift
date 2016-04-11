//
//  UIImageView+WebImage.swift
//  shop_ke
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    func setWebImage(urlString:String,placeHolder:UIImage!,forState:UIControlState)
    {
        
        let url = NSURL(string: urlString)
        let cacheFilename = url!.lastPathComponent
        let cachePath = FileUtility.cachePath(cacheFilename!)
        if let image = FileUtility.imageDataFromPath(cachePath) {
            self.setImage(image, forState: forState)
        }
        else
        {
            let req = NSURLRequest(URL: url!)
            let queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil)
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            print(error)
                            self.setImage(placeHolder, forState: forState)
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            let image = UIImage(data: data!)
                            if (image == nil)
                            {
                                let jsonData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                                
                                if let _:String? = jsonData["error"] as? String {
                                    print("url fail=\(urlString)");
                                }
                                self.setImage(placeHolder, forState: forState)
                            }
                            else
                            {
                                self.setImage(image, forState: forState)
                                let bIsSuccess = FileUtility.imageCacheToPath(cachePath,image:data!)
                                if !bIsSuccess
                                {
                                    print("*******cache fail,path=\(cachePath)")
                                }
                            }
                    })
                }
            })
            
        }
        
    }
}
extension UIImageView {
    func setWebImage(urlString:String,placeHolder:UIImage!)
    {
        
        let url = NSURL(string: urlString)
        let cacheFilename = url!.lastPathComponent
        let cachePath = FileUtility.cachePath(cacheFilename!)
        if let image  = FileUtility.imageDataFromPath(cachePath)         {
            self.image = image
        } else  {
            let req = NSURLRequest(URL: url!)
            let queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil)
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            print(error)
                            self.image = placeHolder
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            let image = UIImage(data: data!)
                            if (image == nil)
                            {
                                return
//                                let jsonData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
//                                
//                                if let _:String? = jsonData["error"] as? String {
//                                    print("url fail=\(urlString)");
//                                }
//                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                let bIsSuccess = FileUtility.imageCacheToPath(cachePath,image:data!)
                                if !bIsSuccess
                                {
                                    print("*******cache fail,path=\(cachePath)")
                                }
                            }
                    })
                }
            })
            
        }
        
    }
    
}