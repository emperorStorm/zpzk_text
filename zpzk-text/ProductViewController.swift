//
//  ProductViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    let menuArray = LogMenu.getMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        menuArray = LogMenu.getMenu()
        loadMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //加载标签
    func loadMenu() {
        scrollView.contentSize = CGSizeMake(CGFloat(menuArray.count) * 65, 30)
        for index in 0..<menuArray.count {
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(CGFloat(index) * 65, 0, 65, 30)
            btn.setTitle(menuArray[index]["name"] as? String, forState: .Normal)
            btn.tintColor = UIColor.blackColor()
            scrollView.addSubview(btn)
        }
    }

    @IBAction func logMenu(sender: UIButton) {
        
    }
}
