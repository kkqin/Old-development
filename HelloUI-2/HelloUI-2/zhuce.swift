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
        
        btBack = UIButton(frame: CGRect(x: 10, y: 30, width: 90, height: 30))
        
        self.view.addSubview(btBack)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        btBack.setTitle("BACK", for: UIControl.State())
        btBack.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        btBack.backgroundColor = UIColor.green
        btBack.addTarget(self, action: #selector(zhuce.backToLogin), for: UIControl.Event.touchUpInside)
    }

    @objc func backToLogin(){
        self.dismiss(animated: true, completion: nil)
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
