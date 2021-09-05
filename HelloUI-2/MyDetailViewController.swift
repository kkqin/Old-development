//
//  MyDetailViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/12/2.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class MyDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图的背景色
        self.view.backgroundColor = UIColor.white
        //按title加载控件
        loadControl(self.title!)
        
        //设置代码和效果展示切换，增加导航条的右上角按钮
        let btn = UIBarButtonItem(title: "代码", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MyDetailViewController.btnClicked(_:)))
        self.navigationItem.rightBarButtonItem = btn//在导航栏上加一个按钮
    }
    
    /////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //////////////////////
    
    func loadControl(_ ctrl:String){
        switch ctrl {
        case "UILabel":
            let label = UILabel(frame: self.view.frame)
            label.backgroundColor = UIColor.clear
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 36)
            label.text = "Hello UILabel"
            self.view.addSubview(label)
        case "UIButton":
            let btn = UIButton(frame: CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.height/5, width: 80, height: 30))
            btn.setTitle("按钮", for: UIControl.State())
            btn.setTitleColor(UIColor.black, for: UIControl.State())
            btn.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
            btn.addTarget(self, action: #selector(MyDetailViewController.Clicked(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        default:
            print("control name:\(ctrl)")
        }
    }
    
    @objc func Clicked(_ sender:UIButton) {
        print(sender.titleLabel?.text, terminator: "")
    }
    
    func loadCode(_ ctrl:String)
    {
        var str:String!
        switch ctrl {
        case "UILabel":
            str = "let label = UILabel(frame: self.view.frame) \n"
            str = str + "label.backgroundColor = UIColor.clearColor() \n"
            str = str + "label.textAlignment = NSTextAlignment.Center \n"
            str = str + "label.font = UIFont.systemFontOfSize(36) \n"
            str = str + "label.text = \"Hello UILabel\" \n"
            str = str + "self.view.addSubview(label) \n"
        case "UIButton":
            str =  "let btn = UIButton(frame: CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/5, 80, 30))\n"
            str =  str + "btn.setTitle(\"按钮\", forState: UIControlState.Normal)\n"
            str =  str + "btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)\n"
            str =  str + "btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)\n"
            str =  str + "btn.addTarget(self, action: Selector(\"Clicked:\"), forControlEvents: UIControlEvents.TouchUpInside)\n"
            str =  str + "self.view.addSubview(btn)\n"
        default:
            str = "other ctrl"
        }
        
        //在导航条下方位置显示代码
        let txt = UITextView(frame: CGRect(x: 0, y: 80, width: self.view.bounds.width, height: self.view.bounds.height-80))
        txt.text = str
        self.view.addSubview(txt)
        
    }
    
    @objc func btnClicked(_ sender:AnyObject){
        clearViews()
        if self.navigationItem.rightBarButtonItem!.title == "代码"{//如果在导航栏中点击到了“代码”
            self.navigationItem.rightBarButtonItem!.title="效果"
            loadCode(self.title!)
        }
        else{//若点击不是‘代码’
            self.navigationItem.rightBarButtonItem!.title = "代码"//让右上角为'代码'
            loadControl(self.title!)//重新载入一遍视图
        }
    }
    
    func clearViews(){
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
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

