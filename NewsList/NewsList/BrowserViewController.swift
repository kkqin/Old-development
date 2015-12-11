//
//  ViewController.swift
//  Safari
//
//  Created by chuna on 15/12/11.
//  Copyright (c) 2015年 chuna. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController,UIWebViewDelegate {

    var url:NSURL!  //网址
    var webView:UIWebView!  // 网页视图
    var stopButton:UIBarButtonItem! //停止按钮
    var backButton:UIBarButtonItem! //后退按钮
    var forwardButton:UIBarButtonItem!//前进按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1.配置webView
        webView = UIWebView()
        webView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-44)
        webView.scalesPageToFit=true  //自适应
        self.view.addSubview(webView)
        webView.delegate=self
        
        //2.工具条UIToolBar
        let myToolBar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44))
        myToolBar.backgroundColor = UIColor.blackColor()
        self.view.addSubview(myToolBar)
        
        //控制网页刷新、停止、后退、前进的按钮，加载到工具条中
        let reloadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("reloadDidPush"))
        stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: Selector("stopDidPush"))
        backButton = UIBarButtonItem(title: "后退", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backDidPush"))
        forwardButton = UIBarButtonItem(title: "前进", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("forwardDidPush"))
        myToolBar.setItems([reloadButton,stopButton,backButton,forwardButton], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        //通过NSURLRequest方法来加载并显示URL指定的内容
        //var url = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func reloadDidPush(){
        webView.reload()     //重新载入页面
    }
    
    func stopDidPush(){
        webView.stopLoading()  //停止载入
    }
    
    func backDidPush(){
        webView.goBack()     //后退
    }
    
    func forwardDidPush(){
        webView.goForward()  //前进
    }
    
    //MARK:控件刷新方法，自定义
    func updateControlEnabled(){
        stopButton.enabled = webView.loading
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
    }
    
    //MARK:UIWebViewDelegate协议中的方法
    func webViewDidStartLoad(webView: UIWebView) {
        updateControlEnabled()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        updateControlEnabled()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        updateControlEnabled()
    }

}

