//
//  MainTableViewController.swift
//  NewsList
//
//  Created by chuna on 15/12/11.
//  Copyright (c) 2015年 chuna. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let newsString = "http://c.3g.163.com/nc/article/local/5aSn6L%2Be/0-20.html"
    
    var news = [] //空数组，放所有的新闻列表
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "reuseIdentifier")
        
        self.title="大连新闻"

        loadDataSource()  //加载新闻数据
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 加载新闻数据
    func loadDataSource(){
        //1.封装NSURL
        let url = NSURL(string: newsString)!
        //2.NSURL封装NSRequest
        let request = NSURLRequest(URL: url)
        //3.异步链接
        let quene = NSOperationQueue()
        UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        NSURLConnection.sendAsynchronousRequest(request,
            queue: quene) { (response, data, error) -> Void in
                if error != nil {
                    //出错
                    print(error!.description)
                    self.refreshControl?.endRefreshing()
                UIApplication.sharedApplication().networkActivityIndicatorVisible=false
                }
                else{
                    if data == nil {
                        print("空数据")
                    }
                    else{
                        print("处理数据\n")
                        var errorRead:NSError?
                        let json = (try! NSJSONSerialization.JSONObjectWithData(data!,
                                    options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                        if errorRead != nil{
                            print("json数据不合法，解析失败")
                        }
                        else{
                            let newsDataSource = json["大连"] as! NSArray
                            var currentNewsDataSource = NSMutableArray() //新闻项数组
                            for currentNews in newsDataSource {
                                let newsItem = NewsItem()
                                //新闻标题
                                newsItem.newsTitle=currentNews["title"] as? String
                                //新闻链接地址
                                newsItem.newsId = currentNews["url"] as? String
                                //新闻图片,根据图片网址，嵌套异步链接请求图片，在给newsItem.newsThumb
                                //currentNews["imgsrc"] as! String //图片链接地址
                                
                                //把新闻实例加入到数组中
                                currentNewsDataSource.addObject(newsItem)
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.news = currentNewsDataSource
                                self.tableView.reloadData()
                                self.refreshControl?.endRefreshing()
                                UIApplication.sharedApplication().networkActivityIndicatorVisible=false
                            })
                            
                        }
                    }
                }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) 

        // Configure the cell...
        let aNew = self.news[indexPath.row] as! NewsItem
        
        cell.textLabel?.text = aNew.newsTitle
        
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    //点击单元格，跳转到新闻详情界面,UITableViewDelegate协议的方法之一
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let data = self.news[row] as! NewsItem
        //入栈
        let webView = BrowserViewController()
        webView.title = data.newsTitle
        webView.url = NSURL(string: data.newsId!)
        
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
