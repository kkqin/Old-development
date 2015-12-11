//
//  ViewController.swift
//  JSON
//
//  Created by Gatsby on 15/12/11.
//  Copyright © 2015年 Gatsby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonFilePath = NSBundle.mainBundle().pathForResource("personlist", ofType: "json")
        print(jsonFilePath)
        let data = NSData(contentsOfFile: jsonFilePath!)
        
        //反序列化
        //var error:NSError?
        do{
             let jsonObj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
            for person in jsonObj{
                let name = person["Name"] as! String
                print(name)
                let id = person["id"] as! Int
                print(id)
                let hobby = person["Hobby"] as! [String]
                print(hobby)
            }
        }
        catch{
            print("wrong jsonObj")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

