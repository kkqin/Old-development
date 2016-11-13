//
//  LoginViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/11/20.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    var lbName:UILabel!
    var lbPs:UILabel!
    var tfName:UITextField!
    var tfPs:UITextField!
    
    var btSignin:UIButton!
    var btRegist:UIButton!
    var btForgetPs:UIButton!
    
    var switch_Ps:UISwitch!//control password secure
    
    var imageView = UIImageView()
    override func loadView() {
        super.loadView()
        /*
            有其他可以适应各种手机屏幕的初始化方法。需自查。
        
        */
        var rect = CGRect(x: 30, y: 200, width: 80, height: 30)
        rect.size.width = 100
        lbName = UILabel(frame:rect)
        
        lbPs = UILabel()
        rect.origin.y = 250
        lbPs.frame = rect
        
        tfName = UITextField(frame: CGRect(x: 110, y: 200, width: 200, height: 30))
        tfPs = UITextField(frame: CGRect(x: 110, y: 250, width: 200, height: 30))
        
        btSignin = UIButton(frame: CGRect(x: 110, y: 300, width: 90, height: 30))
        btForgetPs = UIButton(frame: CGRect(x: 103, y: 330, width: 150, height: 30))
        btRegist = UIButton(frame: CGRect(x: 220, y: 300, width: 90, height: 30))
        
        switch_Ps = UISwitch()
        switch_Ps.frame.origin = CGPoint(x: 320, y: 250)

        imageView.frame = self.view.frame
        imageView.image=UIImage(named: "bg2")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        
        self.view.addSubview(imageView)
        self.view.addSubview(lbPs)
        self.view.addSubview(lbName)
        self.view.addSubview(tfName)
        self.view.addSubview(tfPs)
        self.view.addSubview(btSignin)
        self.view.addSubview(btForgetPs)
        self.view.addSubview(btRegist)
        self.view.addSubview(switch_Ps)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        lbName.text = "User"
        lbPs.text = "PassWord"
        lbName.textColor = UIColor.white
        lbPs.textColor = UIColor.white
        lbName.textAlignment = NSTextAlignment.left
        lbPs.textAlignment = NSTextAlignment.left
        
        tfName.borderStyle = UITextBorderStyle.roundedRect
        tfName.placeholder = "enter your username"
        tfName.returnKeyType = UIReturnKeyType.done
        tfName.clearButtonMode = UITextFieldViewMode.whileEditing
        
        tfPs.borderStyle = UITextBorderStyle.roundedRect
        tfPs.placeholder = "enter your password"
        tfPs.returnKeyType = UIReturnKeyType.done
        tfPs.clearButtonMode = UITextFieldViewMode.whileEditing
        tfPs.isSecureTextEntry = true
        tfPs.delegate = self
        tfName.delegate = self
        
        btSignin.setTitle("SignIn", for: UIControlState())//设置按钮标题与文字状态
        btRegist.setTitle("Regist", for:UIControlState())
        btForgetPs.setTitle("ForgotPassword?", for: UIControlState())
        
        btSignin.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btSignin.backgroundColor = UIColor.blue
        //btSignin.enabled = false //和下面解锁按键函数使用, 已注释
        btSignin.addTarget(self, action: #selector(LoginViewController.SignIn), for: UIControlEvents.touchUpInside)
       // btSignin.showsTouchWhenHighlighted = true;//使按键按下时有亮点出现
        
        switch_Ps.addTarget(self, action: #selector(LoginViewController.switchDidChange), for: UIControlEvents.touchUpInside)//添加按钮触摸事件
        btRegist.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btRegist.backgroundColor = UIColor.blue
        //btRegist.showsTouchWhenHighlighted = true;//使按键按下时有亮点出现
        btRegist.addTarget(self, action: #selector(LoginViewController.regist(_:)), for:UIControlEvents.touchUpInside)//注册页面跳转
        
        btForgetPs.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK :SignIn
    func SignIn()
    {
        if (tfName.text!.isEmpty) || (tfPs.text!.isEmpty)
        {
            let alertView = UIAlertController(title: "Warning", message: "lackinfo", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
        else if tfName.text == "ok"
        {
           if tfPs.text == "123"
           {
                let SEG = SegViewController()
                SEG.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                self.present(SEG, animated: true, completion: nil)
           }
           else
           {
                let alertView = UIAlertController(title: "Warning", message: "Password Wrong", preferredStyle: UIAlertControllerStyle.alert)
                alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else
        {
            let alertView = UIAlertController(title: "Warning", message: "WrongEverthing", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    //MARK : signup
    func regist(_ sender: UIButton)
    {
        let reg = zhuce()
        reg.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(reg, animated: true, completion: nil)
    }
    
    
    //MARK : Switch Password
    func switchDidChange()
    {
        if switch_Ps.isOn
        {
            tfPs.isSecureTextEntry = !true
        }
        else
        {
            tfPs.isSecureTextEntry = !false
        }
    }
    
    //MARK: delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //keyborad disappear
        tfName.resignFirstResponder()
        tfPs.resignFirstResponder()
        return true
    }

//    func textFieldDidEndEditing(textField: UITextField) {
//        if (tfName.text!.isEmpty) || (tfPs.text!.isEmpty){
//            btSignin.enabled = false
//        }
//        else{
//            btSignin.enabled = true
//           // btSignin.backgroundColor = UIColor.greenColor()
//        }
//    }
//    用于解锁按键，已注释
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
