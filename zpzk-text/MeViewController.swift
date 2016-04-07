//
//  MeViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let dic = User.getUser()
        if let flag = dic["flag"] as? Int where flag == 1 {
            loginBtn.setTitle(dic["web_user"]!["name"] as? String, forState: UIControlState.Normal)
            loginBtn.enabled = false
        }else {
            loginBtn.setTitle("登陆正品折扣", forState: UIControlState.Normal)
            loginBtn.enabled = true 
        }
    }
    
    //MAEK:登陆
    @IBAction func loginBtn(sender: UIButton) {
        self.presentViewController(LoginViewController(), animated: true, completion: nil)
    }
    
    //MARK:退出登录
    @IBAction func exitBtn(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("User")
        loginBtn.setTitle("登陆正品折扣", forState: UIControlState.Normal)
        loginBtn.enabled = true
    }

}
