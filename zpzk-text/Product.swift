//
//  Peoduct.swift
//  zpzk-text
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

class Product {
    
    var image : String?
    var content : String?
    var discount : Double?
    var price :Double?
    var id : Int?
    
    static func getProduct(data:AnyObject?) ->[Product]{
        var products = [Product]()
        if let arr = data {
            for index in 0..<arr.count {
                let arr_data = arr[index]
                let good = Product()
                let imageURL = arr_data["img_url"] as? String
                good.image = imageURL?.componentsSeparatedByString("http://pic.taojia8.com").joinWithSeparator("")
                good.content = arr_data["content"] as? String
                good.discount = arr_data["discount"] as? Double
                good.price = arr_data["price"] as? Double
                good.id = arr_data["id"] as? Int
                products.append(good)
            }
        }
        return products
    }
}