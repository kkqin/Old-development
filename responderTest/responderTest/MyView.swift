//
//  MyView.swift
//  responderTest
//
//  Created by Gatsby on 15/11/20.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class MyView: UIView {

    override init(frame:CGRect){
        super.init(frame: frame)

       }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("In " + (__FILE__) + ":" + __FUNCTION__)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("In " + (__FILE__) + ":" + __FUNCTION__)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
                print("In " + (__FILE__) + ":" + __FUNCTION__)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
                print("In " + (__FILE__) + ":" + __FUNCTION__)
    }
    
}
