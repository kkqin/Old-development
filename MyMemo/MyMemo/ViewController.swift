//
//  ViewController.swift
//  MyMemo
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var tableView:UITableView!             //定义表示图对象
    private let identify:String = "aCell"  //单元格名字
    
    var arr = Array<String>()
    var detail = Array<String>()
    
    var dic : [[String:AnyObject]]?
    var superdic = Dictionary<Int, [[String:AnyObject]]>()
    
    let path = NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory, .UserDomainMask, true
                ).first!//在当前应用下创建可写入的数据库
    
    var db:SQLiteDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MY MEMO"
        
        self.db = SQLiteDB.sharedInstance()//连接数据裤
        db.execute("create table if not exists memoDB(uid integer primary key,title varchar(20),detail varchar(200))")//如果表不存在则创建表
        let data = db.query("select *from memoDB")
        
        self.dic = data
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count-1]
            let id = user["uid"]!
            let txtUname = user["title"] as! String
            let txtMobile = user["detail"] as! String
            print(data.count)
            print(id)
            print(txtUname)
            print(txtMobile)
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
            let searchBar = UISearchBar()  //创建UISearchBar对象
            searchBar.sizeToFit()          //
            searchBar.showsCancelButton = true //显示取消按钮
            searchBar.delegate=self                //设置搜索条的委托
            self.tableView.tableHeaderView = searchBar //为表添加搜索条
        }else{//若无备忘则显示
            let label = UILabel(frame: self.view.frame)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(36)
            label.text = "Have No MEMO"
            label.textColor = UIColor.grayColor()
            
            self.view.addSubview(label)
        }
        
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dic!.count
        //return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let data = self.dic![indexPath.row]
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identify)
        
        cell.textLabel!.text = data["title"] as? String
        cell.detailTextLabel!.text = data["detail"] as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    
}

