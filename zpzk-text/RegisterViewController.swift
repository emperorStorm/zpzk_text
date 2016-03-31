//
//  RegisterViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        name.returnKeyType = UIReturnKeyType.Default
//        password.returnKeyType = UIReturnKeyType.Default
//        name.delegate = self
//        password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //触摸键盘以外的部分(失去焦点)
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        name.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    //按键盘返回键(失去焦点)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK:注册
    @IBAction func register(sender: UIButton) {
        if name.text == "" || password.text == "" {
            MsgShow("请输入用户名或密码", OKAction: { () -> () in
                return
            })
        }
        
        var parame = [String : AnyObject]()
        parame["name"] = name.text
        parame["pwd"] = password.text
        
        Alamofire.request(.POST,"http://api.zpzk100.com/client/register", parameters:parame)
            .responseJSON { (response) -> Void in
                
            if let JSON = response.result.value {
                if let flag = JSON["flag"] as? Int where flag == 1 {
                    self.MsgShow("注册成功", OKAction: { () -> () in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }else {
                    self.MsgShow("用户名已存在", OKAction: { () -> () in
                        self.name.text = ""
                        self.password.text = ""
                    })
                }
                print(JSON)
            }
        }
                
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
