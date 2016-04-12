//
//  LoginViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        name.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK:登录
    @IBAction func login(sender: UIButton) {
        var dic = [String : AnyObject]()
        dic["name"] = name.text
        dic["pwd"] = password.text
        
        Alamofire.request(.POST,"http://api.zpzk100.com/client/login", parameters: dic).responseJSON { (response) -> Void in
            if let JSON = response.result.value {
                if let flag = JSON["flag"] as? Int where flag == 1 {
                    self.MsgShow("登陆成功", OKAction: { () -> () in
                        User.setUser(JSON as! [String : AnyObject])
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }else {
                    self.MsgShow("登陆失败，请重新登录", OKAction: { () -> () in
                        self.name.text = ""
                        self.password.text = ""
                    })
                }
            }
            print(response)
        }
    }
    
    //MARK:注册
    @IBAction func register(sender: UIButton) {
        self.presentViewController(RegisterViewController(), animated: true, completion: nil)
    }
    
    //提示弹框
    func MsgShow(Msg : String? , OKAction : () -> ()) {
        let alert = UIAlertController(title: "提示", message: Msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: {
            action in
            OKAction()
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
