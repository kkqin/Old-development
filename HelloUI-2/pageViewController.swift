//
//  pageViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class pageViewController: UIViewController {

    let numOfPages = 3
    let pageWidth = 414
    let pageHeight = 736
    
    override func viewDidLoad(){
     super.viewDidLoad()
        //初始化scrollView
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        
        //为了能让内容横向滚动，设置横向内容宽度为3个页面宽度总和
        scrollView.contentSize = CGSizeMake(CGFloat(pageWidth*numOfPages), CGFloat(pageHeight))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        for i in 0..<numOfPages{
            let myViewController = MyViewController(number: (i+1))
            //设置每一页内容的位置
            myViewController.view.frame = CGRectMake(CGFloat(pageWidth * i), CGFloat(0),CGFloat(pageWidth),CGFloat(pageHeight))
            scrollView.addSubview(myViewController.view)
        }
        self.view.addSubview(scrollView)
    }
    
}
