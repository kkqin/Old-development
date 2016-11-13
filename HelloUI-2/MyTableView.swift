//
//  MyTableView.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/12/2.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class MyTableView: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate {
    
    var tableView:UITableView!             //定义表示图对象
    fileprivate let identify:String = "aCell"  //单元格名字
    
    var adHeaders = ["基本UI控件","高级UI控件","个人"]
    
    var ctrls = ["UILabel","UIButton","UITextField","UISwitch",
        "UIImageView","UIAlertView","UIActionSheet",
        "UISegmentedControl","UIScrollView","UIGestureRecognizer",
        "UIPickerView","UIDatePicker","UIPageControl","UISlider",
        "UIProgressView"]        //基本控件数组
    
    var allnames:Dictionary<Int,[String]>!  //所有控件字典
    var ctrlsel:Dictionary<Int, [String]>=[:] // 搜索匹配的结果，Table View使用这个数组作为datasource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航标题
        self.title = "控件列表"
        
        self.allnames = [0:self.ctrls,
            1:["UITableView","UITableViewController",
                "UISearchBar","UINavigationController",
                "UIWebView","UIActivityIndicatorView","UITabBarController"],
            2:["page"]]
        self.ctrlsel = self.allnames  //起始
        
        //1.使用frame和风格初始化一个表视图对象
        self.tableView = UITableView(frame: self.view.frame,
            style: UITableViewStyle.grouped)//整个页面都给tableView
        //2.设置数据源和委托，并使加载了表视图的类继承两个协议，实现协议中规定的方法
        self.tableView.dataSource=self
        self.tableView.delegate=self
        //3.创建一个重用的单元格，注册
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identify)//identify named "acell"
        //4.加入当前视图
        self.view.addSubview(self.tableView)
        
        //5.绑定对长按手势的响应
        let longPress =  UILongPressGestureRecognizer(target:self, action:#selector(MyTableView.tableviewCellLongPressed(_:)))
        longPress.delegate = self  //代理
        longPress.minimumPressDuration = 1.0
        //将长按手势添加到需要实现长按操作的视图里
        self.tableView.addGestureRecognizer(longPress)
        
        //6.
        let searchBar = UISearchBar()  //创建UISearchBar对象
        searchBar.sizeToFit()          //
        searchBar.showsCancelButton = true //显示取消按钮
        searchBar.delegate=self                //设置搜索条的委托
        self.tableView.tableHeaderView = searchBar //为表添加搜索条
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:长按方法
    func tableviewCellLongPressed(_ gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if self.tableView!.isEditing == false {
                self.tableView!.setEditing(true, animated: true)
            }
            else{
                self.tableView!.setEditing(false, animated: true)
            }
        }
    }
    
    //MARK:UITableViewDataSource协议中的方法
    
    //返回分区数,(可选)
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allnames.count
    }
    
    //1.返回每个分区的行数有几部分，(必须实现)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.ctrls.count
        //return self.allnames[section]!.count
        return self.ctrlsel[section]!.count
    }
    
    //2.设置单元格显示内容，(必须实现)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //单元格重用
        //let cell = tableView.dequeueReusableCellWithIdentifier(identify,
        //forIndexPath: indexPath) as! UITableViewCell
        //配置单元格
        //cell.textLabel!.text = self.ctrls[indexPath.row] //主标题
        //cell.imageView!.image=   //图片
        //cell.detailTextLabel!.text= //在default风格下，没有副标题
        
        let secno = indexPath.section  //分区号
        //var data = self.allnames[secno]!
        var data = self.ctrlsel[secno]!
        
        if secno == 0 {  //基本控件单元格配置
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,for: indexPath)
            cell.textLabel!.text = data[indexPath.row]
            cell.imageView!.image = UIImage(named: "heart.jpg")
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell
        }
        else if secno == 1{  //高级控件单元格配置
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identify)
            cell.textLabel!.text=data[indexPath.row]
            cell.detailTextLabel!.text = "这是\(data[indexPath.row])的说明"
            return cell
        }
        else{//add myself
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identify)
            cell.textLabel!.text=data[indexPath.row]
            cell.detailTextLabel!.text = "这是\(data[indexPath.row])的说明"
            return cell
        }
    }
    
    //3.配置分区头部标题，可选实现
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return adHeaders[section]
    }
    
    //4.配置分区尾部标题,可选实现
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        //let data = self.allnames[section]!
        let data = self.ctrlsel[section]!
        return "有\(data.count)个控件"
    }
    
    //MARK:UITableViewDelegate协议中的方法
    //处理选中单元格事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选中状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        //获取被选中的单元格内容
        //let itemStr = self.ctrls[indexPath.row]
        //let itemStr = self.allnames[indexPath.section]![indexPath.row]
        let itemStr = self.ctrlsel[indexPath.section]![indexPath.row]
        
        /*
        let alertview = UIAlertController(title: "提示", message: "你选中了\(itemStr)", preferredStyle: UIAlertControllerStyle.Alert)
        alertview.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)*/
        
        //界面跳转
        let detail = MyDetailViewController()
        detail.title = itemStr
        self.navigationController?.pushViewController(detail, animated: true)//入栈
    }
    
    //2.设置编辑状态
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 1 {
            return UITableViewCellEditingStyle.insert
        }
        return UITableViewCellEditingStyle.delete
    }
    
    //4.提交编辑，生效
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.allnames[indexPath.section]!.remove(at: indexPath.row)
            self.tableView.reloadData()//更新表
            self.tableView!.setEditing(true, animated: true)
        }
        else if editingStyle == UITableViewCellEditingStyle.insert {
            self.allnames[indexPath.section]!.insert("插入新项", at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    //MARK: 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {    // 没有搜索内容时显示全部组件
            self.ctrlsel = self.allnames
        }
        else {                    // 匹配用户输入内容的前缀
            self.ctrlsel = [:]
            for ctrl in self.allnames {
                for ct in ctrl.1 {
                    if ct.hasPrefix(searchText){
                        if self.ctrlsel[ctrl.0] != nil {
                            self.ctrlsel[ctrl.0]! += [ct]
                        }
                        else{
                            self.ctrlsel[ctrl.0] = [ct]
                        }
                    }
                }
                
            }
        }
        
        self.tableView.reloadData()// 刷新Table View显示
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}


