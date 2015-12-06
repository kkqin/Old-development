//
//  MyViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    var number : Int!
    let colorMap = [
        1:UIColor.brownColor(),
        2:UIColor.blueColor(),
        3:UIColor.orangeColor()
    ]
    
    init(number initNumber:Int){
        self.number = initNumber
        super.init(nibName:nil, bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let numberLabel = UILabel(frame: CGRectMake(0,0,100,100))
        numberLabel.center = self.view.center
        numberLabel.text = "第\(number)页"
        numberLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(numberLabel)
        self.view.backgroundColor = colorMap[number]
    }
}
