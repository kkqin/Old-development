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
        
        v1 = UIView(frame: CGRect(x: 100, y: 120, width: 140, height: 160))
        self.view.addSubview(v1!)
        v2 = UIView(frame: CGRect(x: 20, y: 40, width: 60, height: 80))
        v1?.addSubview(v2!)
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(#function)
        v1?.backgroundColor = UIColor.gray
        v2?.backgroundColor = UIColor.purple
//        print("v1 frame\(v1?.frame)")
//        print("v1 bounds \(v1?.bounds)")
//        print("v1 center \(v1?.center)")
        
        v1?.bounds.size.width = 280//以center为原点放大
        v1?.bounds.size.height = 320
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(#function)
        // Dispose of any resources that can be recreated.
    }


}

