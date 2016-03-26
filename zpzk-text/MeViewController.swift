//
//  MeViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAEK:登陆
    @IBAction func loginBtn(sender: UIButton) {
//        let nib=LoginViewController()//需要跳转的viewcontroller
        self.presentViewController(LoginViewController(), animated: true, completion: nil)
    }
    
    //MARK:退出登录
    @IBAction func exitBtn(sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
