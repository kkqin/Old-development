//
//  SegViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/11/27.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class SegViewController: UIViewController , UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

    var tf = UITextField()
    var btAdd = UIButton()
    var btDelete = UIButton()
    var seg:UISegmentedControl!//分段控件
    
    var pickerView = UIPickerView()//选择框

    var sportArray = ["soccer","buildCity","singing","reading","swiming"]
    
    var btClick = UIButton()//用于获取控件信息
    
    var datePicker = UIDatePicker()//日期选择框
    
    var btExit = UIButton()
    
    override func loadView() {
        super.loadView()
        
        /*相对布局*/
        var rect = CGRect(x: self.view.frame.width/11, y: 50, width: self.view.frame.width*6/11, height: 30)
        self.tf.frame = rect//对话框
        
        rect.origin.x += tf.frame.size.width
        rect.size.width = self.view.frame.width*2/11
        btAdd.frame = rect //增加按钮
        
        rect.origin.x += rect.size.width
        btDelete.frame = rect//删除按钮
        
        let items = ["Alarm","Opertion","Selector","DateSelect","TableView","pageScroll"]
        
        seg = UISegmentedControl(items: items)
        
        rect.origin.x = 10
        rect.origin.y += 50
        rect.size.width = self.view.frame.size.width - 20
        seg.frame = rect

        self.pickerView.frame=CGRect(x: 20, y: 150, width: 300, height: 216)
        self.btClick.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height*4/5, width: 120, height: 30)
        self.datePicker.frame = CGRect(x: 20, y: 150, width: 300, height: 216)
        
        self.btExit.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height*4/5 + 40, width: 120, height: 30)
        /* 加入视图 */
        self.view.addSubview(self.tf)
        self.view.addSubview(self.btAdd)
        self.view.addSubview(self.btDelete)
        self.view.addSubview(self.seg)
        self.view.addSubview(self.pickerView)
        self.view.addSubview(self.btClick)
        self.view.addSubview(self.datePicker)
        self.view.addSubview(self.btExit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white//设置这个类背景色
        
        self.tf.borderStyle = UITextBorderStyle.roundedRect
        self.tf.placeholder = "enter"
        self.btAdd.setTitle("ADD", for: UIControlState())
        self.btDelete.setTitle("DELETE", for: UIControlState())
        
        self.btAdd.setTitleColor(UIColor.black, for: UIControlState())
        self.btAdd.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        self.btDelete.setTitleColor(UIColor.black, for: UIControlState())
        self.btDelete.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        self.btExit.setTitle("EXIT", for: UIControlState())
        self.btExit.setTitleColor(UIColor.red, for: UIControlState())
        self.btExit.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        self.seg.tintColor = UIColor.red
        
        self.btAdd.addTarget(self, action: #selector(SegViewController.add), for: UIControlEvents.touchUpInside)
        
        self.btDelete.addTarget(self, action: #selector(SegViewController.remove), for: UIControlEvents.touchUpInside)
      
        self.seg.addTarget(self, action: #selector(SegViewController.segmentChanged(_:)), for: UIControlEvents.valueChanged)

        self.btExit.addTarget(self, action: #selector(SegViewController.exit), for: UIControlEvents.touchUpInside)
        
        btClick.setTitle("未选择", for: UIControlState())
        btClick.setTitleColor(UIColor.white, for: UIControlState())
        btClick.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        btClick.backgroundColor = UIColor.gray
        btClick.addTarget(self, action: #selector(SegViewController.showInfo(_:)), for: UIControlEvents.touchUpInside)
    }

    //MARK add
    func add(){
        let num = self.seg.numberOfSegments//一共有多少项
        //get the enter tf characters
        let title = self.tf.text
        //if user enters characters > 0
        if !(title!.isEmpty){
            self.seg.insertSegment(withTitle: title, at: num, animated: true)
            self.tf.text = ""
        }
    }
    //MARK delect
    func remove(){
        let num = self.seg.numberOfSegments
        if num > 6
        {
            self.seg.removeSegment(at: num-1, animated: true)
        }
    }
    //MARK seg changed
    func segmentChanged(_ sender:UISegmentedControl){
        switch self.seg.selectedSegmentIndex{
        case 0://alarm view, or warning view
            
            let alertView = UIAlertController(title: "Warning", message: "This is alarm view or warning view", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)

        case 1:
            let sheet = UIAlertController(title: "select", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            sheet.addAction(UIAlertAction(title: "man", style: UIAlertActionStyle.default, handler: {
                (title:UIAlertAction) -> Void in print("select the \(title)")
            }))
            sheet.addAction(UIAlertAction(title: "female", style: UIAlertActionStyle.default, handler: { (title:UIAlertAction) -> Void in
                print("select the \(title)");
                }))
            sheet.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(sheet, animated: true, completion: nil)
            
        case 2:
            self.pickerView.backgroundColor = UIColor.white//设置选择框背景色
            self.pickerView.dataSource = self//数据源
            self.pickerView.delegate = self//委托事件
            self.pickerView.showsSelectionIndicator = true//显示选择指示器
            self.pickerView.selectRow(1, inComponent: 0, animated: true)//设置选择框默认列,是否活跃
            self.view.bringSubview(toFront: self.pickerView)//把指定的子视图移动到顶层
            btClick.setTitle("显示被选信息", for: UIControlState())
        case 3:
            self.datePicker.backgroundColor = UIColor.white
            self.view.bringSubview(toFront: self.datePicker)//把指定的子视图移动到顶层
            btClick.setTitle("显示所选时间", for: UIControlState())
        case 4:
            let nav = UINavigationController(rootViewController: MyTableView())
            self.present(nav, animated: true, completion: nil)
        case 5:
            let v = pageViewController()
            self.present(v, animated: true, completion: nil)
        default:
            break
        }
    }
    
    //MARK: 退出当前登陆函数
    func exit(){

        let alertView = UIAlertController(title: "EXITING", message: "ARE YOU SURE TO EXIT?", preferredStyle: UIAlertControllerStyle.alert)
      alertView.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel
        , handler: nil))
        alertView.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.default, handler: { (did:UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
       }))
        
       self.present(alertView, animated: true, completion: nil)
    }
    

    //MARK: 设置选择器的内容，继承于UIPickViewDelegate protrol
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportArray[row]
    }
    //MARK: 设置选择器的列数，UIPiceViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: 设置选择器的行数，UIPiceViewDelegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportArray.count
    }
    
    func showInfo(_ sender:UIButton){
        switch sender.titleLabel!.text!{
            case "显示所选时间":
            let date =  self.datePicker.date
            let dformater = DateFormatter()  //创建一个日期格式器
            dformater.dateFormat = "yyy年MM月dd日 HH:mm:ss"//确定日期格式器显示格式
            let dateStr = dformater.string(from: date)//转换日期格式器为字符串
        
            let alertView = UIAlertController(title: "被选中的日期为", message: dateStr, preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            
            case "显示被选信息":
                let idx = self.pickerView.selectedRow(inComponent: 0)
                let alertView = UIAlertController(title: "被选中的索引为", message: sportArray[idx], preferredStyle: UIAlertControllerStyle.alert)
                alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alertView, animated: true, completion: nil)
        default :
            break
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
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
