//
//  Detail.swift
//  zpzk-text
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

class Detail {
    var detailImage: String?
    var detailIntroduction: String?
    var discountPrice: Double?
    var originalPrice: Double?
    var discount: String?
    var detailUrl : String?

    
    static func setDetail(data:AnyObject?) ->Detail{
        let detail = Detail()
        if let arr = data {
            detail.detailImage = arr["image_url"] as? String
            detail.detailIntroduction = arr["content"] as? String
            detail.discountPrice = arr["price"] as? Double
            detail.originalPrice = arr["old_price"] as? Double
            detail.discount = arr["discount"] as? String
            detail.detailUrl = arr["url"] as? String
        }
        return detail
    }
}