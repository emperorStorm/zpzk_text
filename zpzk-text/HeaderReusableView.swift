//
//  HeaderReusableView.swift
//  zpzk-text
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

//创建一个分组头视图view
class HeaderReusableView: UICollectionReusableView  {
    var headerLb:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLb=UILabel()
        headerLb.frame=CGRectMake(10, 0, 262, 20)
        headerLb.textColor = UIColor.blueColor()
        headerLb.textAlignment = NSTextAlignment.Center
        self.addSubview(headerLb)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
