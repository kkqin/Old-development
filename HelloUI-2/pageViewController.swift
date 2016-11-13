//
//  pageViewController.swift
//  HelloUI-2
//
//  Created by Gatsby on 15/12/3.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class pageViewController: UIViewController, UIScrollViewDelegate {

    let numOfPages = 3
//    let pageWidth = 414
//    let pageHeight = 736
    
    var pageControl:UIPageControl!//页控件
    
    override func viewDidLoad(){
     super.viewDidLoad()
        //初始化scrollView
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        
        
        let frame = self.view.bounds
        //为了能让内容横向滚动，设置横向内容宽度为3个页面宽度总和
       scrollView.contentSize=CGSize(width: frame.size.width*CGFloat(numOfPages),height: frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        for i in 0..<numOfPages{
            let myViewController = MyViewController(number: (i+1))
            //设置每一页内容的位置
            myViewController.view.frame = CGRect(x: frame.size.width*CGFloat(i),y: CGFloat(0),width: frame.size.width,height: frame.size.height)
            scrollView.addSubview(myViewController.view)

        }
        
        
        scrollView.contentOffset = CGPoint.zero
        
        self.pageControl=UIPageControl(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-100, width: 200, height: 100))
        self.pageControl.numberOfPages=3
        self.pageControl.currentPage=0

        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
        let offset=scrollView.contentOffset
        pageControl.currentPage=Int(offset.x/self.view.frame.size.width)
        
        if(scrollView.contentOffset.x > twidth)
        {
            
            let SEG = SegViewController()
            SEG.modalTransitionStyle = UIModalTransitionStyle.coverVertical//出现方式
            self.present(SEG, animated: true, completion:nil)
        }
        
        
    }
    
}
