//
//  AppDelegate.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //加载标签
    func logMenu() {
        let param = [String:AnyObject]()
        Alamofire.request(.GET, "http://api.zpzk100.com/client/tag_list", parameters: param).responseJSON {
            (response) -> Void in
//            debugPrint(response)
//            let ary = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            if let JSON = response.result.value {
                LogMenu.setMenu(JSON as! NSArray)
            }
            print(response)
        }
    }
    
    //加载左侧菜单数据
    func logLeftMenu() {
        let param = [String:AnyObject]()
        Alamofire.request(.GET, "http://api.zpzk100.com/client/tag_and_sub_tag", parameters: param).responseJSON {
            (response) -> Void in
            if let JSON = response.result.value {
                print(JSON)
                NSUserDefaults.standardUserDefaults().setObject(JSON, forKey: "leftMenu")
            }
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        logMenu()
        logLeftMenu()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

