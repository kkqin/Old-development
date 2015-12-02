//
//  zhuce.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/11/27.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class zhuce: UIViewController{

    var btBack:UIButton!
    
    override func loadView() {
        super.loadView()
        
        btBack = UIButton(frame: CGRectMake(10, 30, 90, 30))
        
        self.view.addSubview(btBack)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brownColor()
        btBack.setTitle("BACK", forState: UIControlState.Normal)
        btBack.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        btBack.backgroundColor = UIColor.greenColor()
        btBack.addTarget(self, action: Selector("backToLogin"), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func backToLogin(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
