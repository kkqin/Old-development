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
        
        let jsonFilePath = Bundle.main.path(forResource: "personlist", ofType: "json")//当前json数据
        print(jsonFilePath!)
        let data = NSData(contentsOfFile: jsonFilePath!)//
        
        //反序列化
        //var error:NSError?
        do{
            let jsonObj = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]//反序列化为数组
            
            for person in jsonObj {
                let id = person["id"] as! Int
                print(id)
                let name = person["Name"] as! String
                print(name)
                let hobby = person["Hobby"] as! [String]
                print(hobby)
            }
        } catch let error as NSError {
            print(error.code)
            print(error.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

