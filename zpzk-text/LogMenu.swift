//
//  LogMenu.swift
//  zpzk-text
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

class LogMenu {
    
    //存放标签
    static func setMenu(data:NSArray) {
        let menu = NSUserDefaults.standardUserDefaults()
        menu.setObject(data, forKey: "Menu")
        print(menu)
    }
    
    //获取标签
    static func getMenu() ->NSArray{
        let tags = NSUserDefaults.standardUserDefaults()
        let arr = tags.objectForKey("Menu") as? NSArray
        return arr!
    }

}