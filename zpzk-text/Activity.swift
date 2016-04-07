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
        return activities
    }
}