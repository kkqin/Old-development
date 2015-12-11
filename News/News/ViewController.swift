//
//  ViewController.swift
//  Safari
//
//  Created by Gatsby on 15/12/11.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    
    var url:NSURL!
    var webView:UIWebView!//定义webview
    var stopButton:UIBarButtonItem!//定义工具条的按钮
    var backButton:UIBarButtonItem!
    var forwardButton:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.配置webview
        webView = UIWebView()
        webView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-44)
        webView.scalesPageToFit = true//有自适应效果
        webView.delegate = self
        self.view.addSubview(webView)
        
        //2.工具条UIToolBar
        let myToolBar =  UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44))
        myToolBar.backgroundColor = UIColor.blackColor()
        self.view.addSubview(myToolBar)
        //控制网页刷新，停止，后退，前进的按钮,加载到工具条中
        var reloadButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("reloadDidPush"))
        
        stopButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: Selector("stopDidPush"))
        
        backButton=UIBarButtonItem(title: "后退", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backDidPush"))
        
        forwardButton = UIBarButtonItem(title: "前进", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("forwardDidPush"))
        
        myToolBar.setItems([reloadButton, stopButton, backButton, forwardButton], animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        //通过NSURLRequest方法来加载并显示URL指定内容
        //let url = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadDidPush(){
        webView.reload()
    }
    
    func stopDidPush(){
        webView.stopLoading()
    }
    func backDidPush(){
        webView.goBack()
    }
    func forwardDidPush(){
        webView.goForward()
    }
    //MARK: 控件刷新方法，自定义
    func updateControlEnable(){
        stopButton.enabled = webView.loading
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
    }
    
    //MARK:UIWebViewDelegate实现方法
    func webViewDidStartLoad(webView: UIWebView) {
        updateControlEnable()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        updateControlEnable()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        updateControlEnable()
    }
}

