//
//  Activity.swift
//  zpzk-text
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

class Activity {
    var image_path :String?
    var discount = 0.0
    var name = ""
    var image_url = ""

    //滚动条图片
    static func saveActivity(data : AnyObject?) ->[Activity]{
        var activities = [Activity]()
        if let dic = data {
            if let act = dic["activities"] {
                for index in 0..<act!.count {
                    let activity = Activity()
                    activity.image_path = act![index]["image_path"] as? String
                    activities.append(activity)
                }
            }
        }
//        
//        if let arr = data!["hot_brands" ] as? [[String: AnyObject]] {
//            for index in 0..<arr.count {
//                let arr_data = arr[index]
//                let shop = Activity()
//                shop.discount = arr_data["discount"] as! Double
//                shop.name = arr_data["name"] as! String
//                shop.image_url = arr_data["img_url"] as! String
//                activities.append(shop)
//            }
//        }

        return activities
    }
    
    //商店数据
    static func getActivityShop(data:AnyObject?) ->[Activity]{
        var shops = [Activity]()
        if let arr = data!["hot_brands" ] as? [[String: AnyObject]] {
            for index in 0..<arr.count {
                let arr_data = arr[index]
                let shop = Activity()
                shop.discount = arr_data["discount"] as! Double
                shop.name = arr_data["name"] as! String
                shop.image_url = arr_data["img_url"] as! String
                shops.append(shop)
            }
        }
        return shops
    }

}