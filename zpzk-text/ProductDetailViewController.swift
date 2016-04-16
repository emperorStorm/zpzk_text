//
//  ProductDetailViewController.swift
//  zpzk-text
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailIntroduction: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    var detailUrl :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //返回
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //去购买
    @IBAction func goBuy(sender: UIButton) {
        let urlString = self.detailUrl
        let url = NSURL(string: urlString!)
        UIApplication.sharedApplication().openURL(url!)
    }
}
