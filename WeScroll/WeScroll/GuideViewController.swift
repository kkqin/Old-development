//
//  GuideViewController.swift
//  WeScroll
//
//  Created by Gatsby on 15/12/11.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {

    var numOfPages = 3
    var pageControl:UIPageControl!//页控件
    
    override func viewDidLoad()
    {
        let frame = self.view.bounds
        //scrollView的初始化
        let scrollView=UIScrollView()
        scrollView.frame=self.view.bounds
        scrollView.delegate = self
        //为了能让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize=CGSizeMake(frame.size.width*CGFloat(numOfPages),frame.size.height)
        print("\(frame.size.width*CGFloat(numOfPages)),\(frame.size.height)")
        
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.scrollsToTop=false
        for i in 0..<numOfPages{
            let imgfile = "0\(Int(i+1)).jpg"
            print(imgfile)
            let image = UIImage(named:"\(imgfile)")
            let imgView = UIImageView(image: image)
            imgView.frame=CGRectMake(frame.size.width*CGFloat(i),CGFloat(0),
                frame.size.width,frame.size.height)
            scrollView.addSubview(imgView)
        }
        scrollView.contentOffset = CGPointZero
        
        //pageControl页控件初始化
        pageControl=UIPageControl(frame: CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height-100, 200, 100))
        pageControl.numberOfPages=3
        pageControl.currentPage=0
        
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        
    }
    //MARK: scrollView委托事件
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        print("scrolled:\(scrollView.contentOffset)")
        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
        
        let offset=scrollView.contentOffset
        pageControl.currentPage=Int(offset.x/self.view.frame.size.width)
        if(scrollView.contentOffset.x > twidth)
        {
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let viewController = mainStoryboard.instantiateInitialViewController()! as UIViewController
            
            self.presentViewController(viewController, animated: true, completion:nil)
        }
    }
    
}
