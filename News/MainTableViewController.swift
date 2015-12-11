//
//  MainTableViewController.swift
//  News
//
//  Created by Gatsby on 15/12/11.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let newsString = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html"
    
    var news = []//空数组,放所有新闻列表
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadDataSource()//加载新闻数据
        self.title = "大连新闻"
        self.tableView.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "reuseIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 加载新闻数据
    func loadDataSource(){
        //封装NSURL
        let url = NSURL(string: newsString)
        //封装request
        let request = NSURLRequest(URL: url!)
        //异步链接请求
        let queue = NSOperationQueue()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NSURLConnection.sendAsynchronousRequest(request, queue: queue){ (response, data, error) -> Void in
            if error != nil{
                //出错
                self.refreshControl?.endRefreshing()
                print(error)
            }else{
                if data == nil{
                    print("控数据")
                }else{
                    print("handle data")
                    var errorRead:NSError?
                    do{
                        let jsonObj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                        let newsDataSource = jsonObj["大连"] as! NSArray
                        let currentNewsDataSource = NSMutableArray()
                        
                        for currentNews in newsDataSource
                        {
                            let newsItem = NewsItem()
                            newsItem.newsTitle = currentNews["title"] as? String
                            newsItem.newsId = currentNews["url"] as? String
                            currentNewsDataSource.addObject(newsItem)
                        }
                    
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.news = currentNewsDataSource
                            self.tableView.reloadData()
                            self.refreshControl?.endRefreshing()
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        })
                        
                    }//end do
                    catch {
                        print("wrong")
                    }
                }//else end
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.news.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let aNew = self.news[indexPath.row] as! NewsItem
        cell.textLabel?.text = aNew.newsTitle
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath){
        var row = indexPath.row
        var data = self.news[row] as? NewsItem
        //入咱
        var webView = ViewController()
        webView.title = data?.newsTitle
        webView.url = NSURL(string: (data?.newsId)!)
        self.navigationController?.pushViewController(webView, animated: true)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
