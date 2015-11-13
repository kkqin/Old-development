//
//  ViewController.swift
//  HELLOUI-1
//
//  Created by Gatsby on 15/11/13.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var v1 : UIView?
    var v2 : UIView?
    
    override func loadView() {
        //加载视图，建立层次关系
        super.loadView()
        
        v1 = UIView(frame: CGRectMake(100, 120, 140, 160))
        self.view.addSubview(v1!)
        v2 = UIView(frame: CGRectMake(20, 40, 60, 80))
        v1?.addSubview(v2!)
        print(__FUNCTION__)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(__FUNCTION__)
        v1?.backgroundColor = UIColor.grayColor()
        v2?.backgroundColor = UIColor.purpleColor()
//        print("v1 frame\(v1?.frame)")
//        print("v1 bounds \(v1?.bounds)")
//        print("v1 center \(v1?.center)")
        
        v1?.bounds.size.width = 280//以center为原点放大
        v1?.bounds.size.height = 320
        }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(__FUNCTION__)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(__FUNCTION__)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print(__FUNCTION__)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print(__FUNCTION__)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(__FUNCTION__)
        // Dispose of any resources that can be recreated.
    }


}

