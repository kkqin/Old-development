//
//  ViewController.swift
//  tttt
//
//  Created by Gatsby on 15/9/18.
//  Copyright (c) 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var FAILED = 6 //尝试密码或用户名次数
     var lesslongOfpwd = 6 //限制密码长度

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var ps: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func clicked(sender: UIButton) {
        if name.text == "ok" && Int(ps.text!) == 123 && FAILED > 0{
        infoLabel.text = "成功。跳转中。。。"
        }else{
            --FAILED
            infoLabel.text = "密码或用户名错误"
        }
        
        
        if FAILED <= 3 && FAILED > 0{
            infoLabel.text = "您还有\(FAILED)次尝试机会"
        }else if FAILED <= 0{
            infoLabel.text = "尝试次数已够"
            FAILED = 0
        }
        
        if ps.text!.isEmpty{
            infoLabel.text = "请输入密码"
            FAILED = 6
        }
        
        if name.text!.isEmpty{
            infoLabel.text = "请输入用户名"
            FAILED = 6
        }
//        var user = (username:name.text, pwd:ps.text)
//
//        if user.username.hasPrefix("c") /*== "cao"*/ && user.1 == "123" && FAILDED < 3{
//            infoLabel.text = "跳转中。。。"
//                }else{
//            infoLabel.text = "用户名或密码错误❌"
//
//        }//使用元组
//       
        
       // name.text.insert(Character("f"), atIndex: name.text.startIndex)
    }
    
    @IBAction func signUp(sender: UIButton) {
        if name.text!.isEmpty{
            infoLabel.text = "注册请输入邮箱"
        }else if ps.text!.isEmpty {
            infoLabel.text = "请输入密码"
        }
        
        
        
    }
    
    func pwdDiste(pwd:String) -> Bool{
        for count in pwd.count{//Failed
            if count < lesslongOfpwd{
                return false
            }else if count >= lesslongOfpwd < 2 * lesslongOfpwd{
                return false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

