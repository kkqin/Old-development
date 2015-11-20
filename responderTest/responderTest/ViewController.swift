//
//  ViewController.swift
//  responderTest
//
//  Created by Gatsby on 15/11/20.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create MyView , white background
        var myview = MyView(frame: UIScreen.mainScreen().applicationFrame)
        myview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(myview)
        //MySubView1, green
        var subview1 = MySubView1(frame:CGRectMake(0, 0, myview.bounds.size.width, myview.bounds.size.height/3))
        subview1.backgroundColor = UIColor.greenColor()
        myview.addSubview(subview1)
        //blue
        var subview3 = MySubView3(frame:CGRectMake(myview.bounds.size.width/2, myview.bounds.size.height/5, myview.frame.size.width/2, myview.bounds.size.height*3/5))
        subview3.backgroundColor = UIColor.blueColor()
        myview.addSubview(subview3)
        
        //red
        var subview2 = MySubView2(frame:CGRectMake(0, myview.bounds.size.height*2/3, myview.frame.size.width, myview.bounds.size.height*1/3))
        subview2.backgroundColor = UIColor.grayColor()
        myview.addSubview(subview2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

