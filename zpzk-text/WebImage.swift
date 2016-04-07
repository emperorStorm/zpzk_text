//
//  WebImage.swift
//  zpzk-text
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView {
    /**
     *设置web图片
     *url:图片路径
     *defaultImage:默认缺省图片
     */
    func setZYHWebImage(url:String?, defaultImage:String?) {
        var ZYHImage:UIImage?
        if url == nil {
            return
        }
        //设置默认图片
        if defaultImage != nil {
            self.image=UIImage(named: defaultImage!)
        }

        let dispath=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        dispatch_async(dispath, { () -> Void in
            let URL:NSURL = NSURL(string: url!)!
            let data:NSData?=NSData(contentsOfURL: URL)
            if data != nil {
                ZYHImage=UIImage(data: data!)
                //写缓存
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //刷新主UI
                    self.image=ZYHImage
                })
            }
            
        })
    }
    
    

    
    
}
    