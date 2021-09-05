//
//  SelfInforViewController.swift
//  SelfInformation
//
//  Created by Gatsby on 15/12/12.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class SelfInforViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView:UITableView!
    var Dic = Dictionary<Int, [String]>()
    let me = UserItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationPrepare()
        tableviewPrepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationPrepare(){
        self.title = "Me"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 0/255, green: 160/255, blue: 255/255, alpha: 1)//导航栏背景颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]//文字颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white//按钮颜色
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)//导航栏返回的按键名
        self.navigationItem.backBarButtonItem = item;
        
        print("navigation loaded")
    }
    
    func tableviewPrepare(){
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height),
                                     style: UITableView.Style.grouped)//创建表视图
        self.tableView.dataSource=self//数据源
        self.tableView.delegate=self//委托
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "aCell")
        
        self.view.addSubview(self.tableView)
        
        //json数据在此操作
        let jsonFilePath = Bundle.main.path(forResource: "test", ofType: "json")//当前json数据
        print(jsonFilePath!)
        let data = NSData(contentsOfFile: jsonFilePath!)
        
        let json = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary//反序列化
        let selfDataSource = json["1"] as! [[String:Any]]
        
        for current in selfDataSource {
            self.me.username = current["username"] as? String
            self.me.userpic = current["userpic"] as? String
            self.me.userfavorite = current["userfavorite"] as? String
            self.me.userhistroy = current["userhistroy"] as? String
            self.me.userrank = current["userrank"] as? String
        }
        self.Dic = [
            0:["\(self.me.username!)"],
            1:["收藏","练习历史","排行榜"],
            2:["设置"]
        ]

       // print(Dic)
        print("tableview loaded")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.Dic.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Dic[section]!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选中状态
        self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let secno = indexPath.section
        if secno == 0{//在分区1中选中
            let insidemyinfo = InsideMyInfo()
            ////// 传值过去 /////
            insidemyinfo.userpic = self.me.userpic!
            insidemyinfo.username = self.me.username!
            self.navigationController?.pushViewController(insidemyinfo, animated: true)
        }
        else if secno == 1{//在分区2中选中 //待添加功能
            if indexPath.row == 0{//选中第一行
                let favorite = MyfavoriteTableViewController()
                self.navigationController?.pushViewController(favorite, animated: true)
            }
            else if indexPath.row == 1{//选中第2行
                let favorite = MyfavoriteTableViewController()//使用同一对象不同显示
                favorite.flag = 1//改变其显示
                self.navigationController?.pushViewController(favorite, animated: true)
            }
            else {print("index 3")}//选中第3行
        }
        else {//在分区2中选中 //待添加功能
            print("secno 2")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let secno = indexPath.section
        if secno == 0{//第一个分区的行高点点
            return 150
        }else{//其它行高普通
            return 50
        }
    }//end of heightForRowAtIndexPath
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }//表头高度
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secno = indexPath.section  //分区号
        var data = self.Dic[secno]!
        
        if secno == 0 {  //第一分区配置
            let cell = tableView.dequeueReusableCell(withIdentifier: "aCell",for: indexPath as IndexPath)
            cell.textLabel!.text = data[indexPath.row]
            cell.imageView!.image = UIImage(named: "\(self.me.userpic!)")
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }else if secno == 1{//第二分区配置
            let cell = tableView.dequeueReusableCell(withIdentifier: "aCell",for: indexPath as IndexPath)
            cell.textLabel!.text = data[indexPath.row]
            if(indexPath.row == 0){
                cell.imageView!.image = UIImage(named: "collection.png")
            }else if indexPath.row == 1{cell.imageView!.image = UIImage(named: "history.png")}
            else if indexPath.row == 2{cell.imageView!.image = UIImage(named: "rank.png")}
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }
        else{//最后一个分区配置
            let cell = tableView.dequeueReusableCell(withIdentifier: "aCell",for: indexPath as IndexPath)
            cell.textLabel!.text = data[indexPath.row]
            cell.imageView!.image = UIImage(named: "config.png")
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }
    }

}
