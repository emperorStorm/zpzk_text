//
//  User.swift
//  zpzk-text
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

class User {
    static func setUser(dic : [String:AnyObject]) {
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(dic, forKey: "User")
    }
    
    static func getUser() -> [String:AnyObject]{
        let user = NSUserDefaults.standardUserDefaults()
//        let dic = user.objectForKey("User") as? [String:AnyObject]
        if let dic =  user.objectForKey("User") as? [String:AnyObject] {
            return  dic
        }else {
            return [:]
        }
    }
}
