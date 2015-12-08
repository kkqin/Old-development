//
//  ViewController.swift
//  MyMemo
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UIGestureRecognizerDelegate{

    var tableView:UITableView!             //定义表示图对象
    private let identify:String = "aCell"  //单元格名字
    
    var dic : [[String:AnyObject]]?
    
    var db:SQLiteDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MY MEMO"
        
        self.db = SQLiteDB.sharedInstance()//连接数据裤
        db.execute("create table if not exists memoDB(uid integer primary key,title varchar(20), detail varchar(200),time varchar(30))")//如果表不存在则创建表
        let data = db.query("select *from memoDB")
        
        self.dic = data
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count-1]
            let id = user["uid"]!
            let txtUname = user["title"] as! String
            let txtMobile = user["detail"] as! String
            print("the uid : \(id)")
            print("the title: \(txtUname)")
            print("the detail: \(txtMobile)")
            print("the time: \(user["time"]!)")
        }
        
        //左上角'新增'按键
        self.view.backgroundColor = UIColor.whiteColor()
        let config = UIBarButtonItem(title: "设置", style: UIBarButtonItemStyle.Plain, target: self, action: "configClicked:")
        self.navigationItem.leftBarButtonItem = config
        
        //右上角'新增'按键
        self.view.backgroundColor = UIColor.whiteColor()
        let btn = UIBarButtonItem(title: "新增一个", style: UIBarButtonItemStyle.Plain, target: self, action: "btnClicked:")
        self.navigationItem.rightBarButtonItem = btn
        
        //1.使用frame和风格初始化一个表视图对象
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height),
            style: UITableViewStyle.Grouped)
        //2.设置数据源和委托，并使加载了表视图的类继承两个协议，实现协议中规定的方法
        self.tableView.dataSource=self
        self.tableView.delegate=self
        //3.创建一个重用的单元格，注册
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identify)
        self.view.addSubview(self.tableView)
        
        if data.count > 0{
            let searchBar = UISearchBar(frame: CGRectMake(0, 63, self.view.bounds.width, 37))  //创建UISearchBar对象
            //searchBar.sizeToFit()          //
            searchBar.showsCancelButton = true //显示取消按钮
            searchBar.delegate=self                //设置搜索条的委托
            //self.tableView.tableHeaderView = searchBar //为表添加搜索条
            self.view.addSubview(searchBar)
        }else{//若无备忘则显示
            let label = UILabel(frame: self.view.frame)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(36)
            label.text = "Have No MEMO"
            label.textColor = UIColor.grayColor()
            
            self.view.addSubview(label)
        }
        
        let longPress =  UILongPressGestureRecognizer(target:self, action:Selector("tableviewCellLongPressed:"))
        longPress.delegate = self  //代理
        longPress.minimumPressDuration = 1.0
        self.tableView.addGestureRecognizer(longPress)//将长按手势添加到需要实现长按操作的视图里
    }
    
    //MARK：点击新增按钮
    func btnClicked(sender:AnyObject){
        //print("btnClicked")
         let detail = addNewMemo()
         detail.title = "new memo"
         self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //MARK:点击设置按钮
    func configClicked(sender: AnyObject){
        //print("configClicked");
        let alertview = UIAlertController(title: "提示", message: "🚧施工中...", preferredStyle: UIAlertControllerStyle.Alert)
        alertview.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    
    //MARK:长按点击
    func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if self.tableView!.editing == false {
                self.tableView!.setEditing(true, animated: true)
            }
            else{
                self.tableView!.setEditing(false, animated: true)
            }
        }
    }
    
    //MARK: 提交编辑，生效
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.db.query("delete from memoDB where uid = '\(self.dic![indexPath.row]["uid"]!)'")//delete from DB
            self.dic?.removeAtIndex(indexPath.row)
            self.tableView.reloadData()//更新表
            self.tableView!.setEditing(false, animated: true)//禁止编辑
            
        let alertview = UIAlertController(title: "提示", message: "已删除", preferredStyle: UIAlertControllerStyle.Alert)
        alertview.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
        }
    }
    
    //MARK:
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dic!.count
    }
    
    //MARK: 显示数据库资料
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let data = self.dic![indexPath.row]
        //print(data)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identify)
        
        cell.textLabel!.text = data["title"] as? String
        cell.detailTextLabel!.text = data["detail"] as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    //MARK:选中列
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let itemStr = self.dic![indexPath.row]
        
//        let alertview = UIAlertController(title: "提示", message: "你选中了\(itemStr["title"]!)", preferredStyle: UIAlertControllerStyle.Alert)
//        alertview.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alertview, animated: true, completion: nil)
        
        let detail = addNewMemo()
         detail.title = itemStr["title"] as? String
         //print("\(itemStr["title"]!), \(itemStr["detail"]!)")
         detail.txtTitle = itemStr["title"] as! String
         detail.txtView = itemStr["detail"] as! String
         detail.datestr = itemStr["time"] as! String
         detail.id = itemStr["uid"] as! Int
         self.navigationController?.pushViewController(detail, animated: true)//入栈
    }

    //MARK: 搜索条
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {    // 没有搜索内容时显示全部组件
            self.dic = db.query("select *from memoDB")
        }
        else{
            self.dic = db.query("select *from memoDB where title like '%\(searchText)%'")
        }
        self.tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

