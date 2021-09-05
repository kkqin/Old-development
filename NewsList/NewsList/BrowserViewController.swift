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
        webView.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height-44)
        webView.scalesPageToFit=true  //自适应
        self.view.addSubview(webView)
        webView.delegate=self
        
        //2.工具条UIToolBar
        let myToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.size.height-44, width: self.view.bounds.size.width, height: 44))
        myToolBar.backgroundColor = UIColor.black
        self.view.addSubview(myToolBar)
        
        //控制网页刷新、停止、后退、前进的按钮，加载到工具条中
        let reloadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: Selector(("reloadDidPush")))
        stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: Selector(("stopDidPush")))
        backButton = UIBarButtonItem(title: "后退", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("backDidPush")))
        forwardButton = UIBarButtonItem(title: "前进", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("forwardDidPush")))
        myToolBar.setItems([reloadButton,stopButton,backButton,forwardButton], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        //通过NSURLRequest方法来加载并显示URL指定的内容
        //var url = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(url: url! as URL)
        webView.loadRequest(request as URLRequest)
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
    func updateControlEnabled() {
        stopButton.isEnabled = webView.isLoading
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    //MARK:UIWebViewDelegate协议中的方法
    func webViewDidStartLoad(_ webView: UIWebView) {
        updateControlEnabled()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        updateControlEnabled()
    }
    
    private func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        updateControlEnabled()
    }

}

