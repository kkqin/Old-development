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
    
    var textview:UITextView!
    var memoTitle:UITextField!
    
    var db:SQLiteDB!
    
    override func loadView() {
        super.loadView()
        
        mmTitle = UILabel(frame: CGRectMake(10, 100, 100, 30))
        mmTitle.textColor = UIColor.grayColor()
        mmTitle.text = "标题："
        
        mmText = UILabel(frame: CGRectMake(10, 150, 100, 10))
        mmText.textColor = UIColor.grayColor()
        mmText.text = "记录内容"
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
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyy年MM月dd日 HH:mm:ss"
        let datestr = dformatter.stringFromDate(self.date)
        dt.text = datestr
        dt.textColor = UIColor.grayColor()
        //dt.backgroundColor = UIColor.greenColor()
        
        self.view.addSubview(dt)
        //文本框
        memoTitle = UITextField(frame: CGRectMake(60, 100, self.view.bounds.size.width-90, 30))
        memoTitle.borderStyle = UITextBorderStyle.RoundedRect
        memoTitle.font = UIFont.systemFontOfSize(25)
        memoTitle.text = "my new memo"
        memoTitle.clearButtonMode = UITextFieldViewMode.Always
        self.view.addSubview(memoTitle)
        //多行文本控件
        textview = UITextView(frame: CGRectMake(10, 170, self.view.bounds.size.width-20, self.view.bounds.size.height-500))
        textview.layer.borderWidth = 0.3
        textview.layer.borderColor = UIColor.grayColor().CGColor
        textview.font = UIFont.systemFontOfSize(20)//设置字体大小，以后能自己选择
        textview.textColor = UIColor.redColor()
        textview.text = "Today I ..."//自动补充,以后能自己选择
        self.view.addSubview(textview)
    }
    
    //MARK: 点击完成函数
    func btnClicked2(sender: AnyObject){
        
        let alert = UIAlertController(title: "完成备忘？", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.Default, handler: { (title:UIAlertAction) -> Void in

            self.db = SQLiteDB.sharedInstance()
            
            self.db.execute("insert into memoDB(title, detail) values('\(self.memoTitle.text!)', '\(self.textview.text!)')")
            
            let nav = UINavigationController(rootViewController: ViewController())
            self.presentViewController(nav, animated: true, completion: nil)
            
        }))//当点击确定时插入数据库并跳回首页
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
