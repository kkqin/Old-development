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
    
    var pickerView = UIPickerView()

    var sportArray = ["soccer","buildCity","singing","reading","swiming"]
    
    var btClick = UIButton()//用于获取控件信息
    
    var datePicker = UIDatePicker()
    
    override func loadView() {
        super.loadView()
        
        /*相对布局*/
        var rect = CGRectMake(self.view.frame.width/11, 50, self.view.frame.width*6/11, 30)
        self.tf.frame = rect//对话框
        
        rect.origin.x += tf.frame.size.width
        rect.size.width = self.view.frame.width*2/11
        btAdd.frame = rect //增加按钮
        
        rect.origin.x += rect.size.width
        btDelete.frame = rect//删除按钮
        
        let items = ["Alarm","Opertion","Selector","DateSelect"]
        
        seg = UISegmentedControl(items: items)
        
        rect.origin.x = 10
        rect.origin.y += 50
        rect.size.width = self.view.frame.size.width - 20
        seg.frame = rect

        self.pickerView.frame=CGRectMake(20, 150, 300, 216)
        self.btClick.frame = CGRectMake(self.view.frame.width/2, self.view.frame.height*4/5, 120, 30)
        self.datePicker.frame = CGRectMake(20, 150, 300, 216)
        
        self.view.addSubview(self.tf)
        self.view.addSubview(self.btAdd)
        self.view.addSubview(self.btDelete)
        self.view.addSubview(self.seg)
        self.view.addSubview(self.pickerView)
        self.view.addSubview(self.btClick)
        self.view.addSubview(self.datePicker)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        self.tf.borderStyle = UITextBorderStyle.RoundedRect
        self.tf.placeholder = "enter"
        self.btAdd.setTitle("ADD", forState: UIControlState.Normal)
        self.btDelete.setTitle("DELETE", forState: UIControlState.Normal)
        
        self.btAdd.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.btDelete.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        self.seg.tintColor = UIColor.redColor()
        
        self.btAdd.addTarget(self, action: Selector("add"), forControlEvents: UIControlEvents.TouchUpInside)
        self.btDelete.addTarget(self, action: Selector("remove"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.seg.addTarget(self, action: Selector("segmentChanged:"), forControlEvents: UIControlEvents.ValueChanged)

        btClick.setTitle("显示被选信息", forState: UIControlState.Normal)
        btClick.backgroundColor = UIColor.grayColor()
        btClick.addTarget(self, action: Selector("showInfo:"), forControlEvents: UIControlEvents.TouchUpInside)
    }

    //MARK add
    func add(){
        let num = self.seg.numberOfSegments//一共有多少项
        //get the enter tf characters
        let title = self.tf.text
        //if user enters characters > 0
        if !(title!.isEmpty){
            self.seg.insertSegmentWithTitle(title, atIndex: num, animated: true)
            self.tf.text = ""
        }
    }
    //MARK delect
    func remove(){
        let num = self.seg.numberOfSegments
        if num > 4{
            self.seg.removeSegmentAtIndex(num-1, animated: true)
        }
    }
    //MARK seg changed
    func segmentChanged(sender:UISegmentedControl){
        switch self.seg.selectedSegmentIndex{
        case 0://alarm view, or warning view
            
            let alertView = UIAlertController(title: "Warning", message: "This is alarm view or warning view", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)

        case 1://operation view
            var sheet = UIActionSheet(title: "Message", delegate: self, cancelButtonTitle: "ok", destructiveButtonTitle: "please select", otherButtonTitles: "male", "female")
            //sheet.delegate = self
            sheet.showInView(self.view)
        
        case 2:
            self.pickerView.backgroundColor = UIColor.whiteColor()
            self.pickerView.dataSource = self
            self.pickerView.delegate = self
            self.pickerView.showsSelectionIndicator = true
            self.pickerView.selectRow(1, inComponent: 0, animated: true)//set pickerView default value
            self.view.bringSubviewToFront(self.pickerView)
            btClick.setTitle("显示被选信息", forState: UIControlState.Normal)
        case 3:
            self.datePicker.backgroundColor = UIColor.whiteColor()
            self.view.bringSubviewToFront(self.datePicker)
            btClick.setTitle("显示TIME", forState: UIControlState.Normal)
        default:
            break
        }
    }
    //MARK: 实现协议Delegete方法, 操作表视图
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print("had touch :" + actionSheet.buttonTitleAtIndex(buttonIndex)!)
    }
    
    //MARK: 设置选择器的内容，继承于UIPickViewDelegate protrol
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportArray[row]
    }
    //MARK: 设置选择器的列数，UIPiceViewDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: 设置选择器的行数，UIPiceViewDelegate
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportArray.count
    }
    
    func showInfo(sender:UIButton){
        switch sender.titleLabel!.text!{
            case "DateSelect":
            var date =  self.datePicker.date
            var dformater = NSDateFormatter()  //创建一个日期格式器
            dformater.dateFormat = "yyy年MM月dd日 HH:mm:ss"
            var dateStr = dformater.stringFromDate(date)
                let alert = UIAlertView(title: "被选中的日期", message: dateStr, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        
        default :
            break
        }
        let idx = self.pickerView.selectedRowInComponent(0)
        let alert = UIAlertView(title: "被选中的索引为", message: String(sportArray[idx]), delegate: nil, cancelButtonTitle: "确定")
        alert.show()
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
