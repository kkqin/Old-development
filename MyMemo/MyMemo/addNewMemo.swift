//
//  addNewMemo.swift
//  MyMemo
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class addNewMemo: UIViewController, UITextViewDelegate {
    //MARK:获取当前时间
    var date = NSDate()
    var mmTitle:UILabel!
    var mmText:UILabel!
    
    var txtTitle:String = ""
    var txtView:String = ""
    var memoTitle:UITextField!
    var textview:UITextView!
    var datestr:String = ""
    var id : Int = -1
    var db:SQLiteDB!
    
    override func loadView() {
        super.loadView()
        
        mmTitle = UILabel(frame: CGRectMake(10, 100, 100, 30))
        mmTitle.textColor = UIColor.grayColor()
        //mmTitle.text = "标题："
        
        mmText = UILabel(frame: CGRectMake(10, 150, 100, 10))
        mmText.textColor = UIColor.grayColor()
        //mmText.text = "记录内容"
        self.view.addSubview(mmTitle)
        self.view.addSubview(mmText)
    }
    
    //MARK:视图载入
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //右上角完成按钮
        let btn = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "btnClicked2:")
        self.navigationItem.rightBarButtonItem = btn
        
        //获取当前时间
        let dt = UILabel(frame: CGRectMake(0,70, self.view.bounds.size.width, 10))
        dt.textAlignment = NSTextAlignment.Center//居中显示
       
        if(txtTitle == ""){
            let dformatter = NSDateFormatter()
            dformatter.dateFormat = "yyy年MM月dd日 HH:mm:ss"
            self.datestr = dformatter.stringFromDate(self.date)
            dt.text = datestr
        }
        else{
            dt.text = "上一次修改日期: "+datestr
            let dformatter = NSDateFormatter()
            dformatter.dateFormat = "yyy年MM月dd日 HH:mm:ss"
            self.datestr = dformatter.stringFromDate(self.date)
        }
        dt.textColor = UIColor.grayColor()
        //dt.backgroundColor = UIColor.greenColor()
        
        self.view.addSubview(dt)
        //文本框
        self.memoTitle = UITextField(frame: CGRectMake(12, 100, self.view.bounds.size.width-25, 30))
        self.memoTitle.borderStyle = UITextBorderStyle.None
        self.memoTitle.font = UIFont.systemFontOfSize(25)
        memoTitle.placeholder = "请填写标题"
        memoTitle.text = txtTitle
        memoTitle.clearButtonMode = UITextFieldViewMode.Always
        self.view.addSubview(memoTitle!)
        //多行文本控件
        textview = UITextView(frame: CGRectMake(10, 170, self.view.bounds.size.width-20, self.view.bounds.size.height-500))
        textview.layer.borderWidth = 0
        textview.layer.borderColor = UIColor.grayColor().CGColor
        textview.font = UIFont.systemFontOfSize(20)//设置字体大小，以后能自己选择
        textview.textColor = UIColor.redColor()
        
        if(txtView == ""){
        textview.text = "事件："//txtView
        }
        else{
        textview.text = txtView
        }
        
        self.view.addSubview(textview)
    }
    
    //MARK: 点击完成函数
    func btnClicked2(sender: AnyObject){
        if(self.memoTitle.text == ""){
            let alert = UIAlertController(title: "没有标题", message: "请填写标题", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "好的", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else{
        
        let alert2 = UIAlertController(title: "完成备忘？", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert2.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert2.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.Default, handler: { (title:UIAlertAction) -> Void in

            self.db = SQLiteDB.sharedInstance()
            
            let num = self.db.query("select *from memoDB where uid = '\(self.id)'")
            if(num.count == 0){
                self.db.execute("insert into memoDB(title, detail, time) values('\(self.memoTitle.text!)', '\(self.textview.text!)', '\(self.datestr)')")
            
            let nav = UINavigationController(rootViewController: ViewController())
            self.presentViewController(nav, animated: true, completion: nil)
            }else{
                
                self.db.execute("update memoDB set title = '\(self.memoTitle.text!)', detail = '\(self.textview.text)', time = '\(self.datestr)' where uid = '\(self.id)'")
                
               // print("update memoDB set title = '\(self.memoTitle.text!)', detail = '\(self.textview.text)' where uid = '\(self.id)'")
                
                let nav = UINavigationController(rootViewController: ViewController())
                self.presentViewController(nav, animated: true, completion: nil)
               
            }
            
        }))//当点击确定时插入数据库并跳回首页
        self.presentViewController(alert2, animated: true, completion: nil)
        }
    }

    
}
