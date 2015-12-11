//
//  main.swift
//  Poly
//
//  Created by Gatsby on 15/11/6.
//  Copyright © 2015年 Gatsby. All rights reserved.
//新建Poly工程，在Poly中定义一个名为PolygonShape的协议； 定义Triangle、Square和Rectangle三个类来遵守PolygonShape协议； 在三个类中增加新的实例变量sideLength（边长）； 在协议中为三个新类增加新的方法getTotalSideLength 。 以 学号.zip 文件进行提交

import Foundation

protocol PolygonShape{
    func getTotalSideLength() -> Double
}

class Triangle: PolygonShape { //三角形
    var a:Double = 0; var b:Double = 0; var c:Double = 0
    
    init(a:Double, b:Double, c:Double){
        if (a+b > c) || (a+c > b) || (b+c > a){
            self.a = a
            self.b = b
            self.c = c
        }
        else {
            self.a = 0
            self.b = 0
            self.c = 0
        }
    }
    
    func getTotalSideLength() -> Double{
        return a+b+c
    }
}

class Square: PolygonShape {//正方形
    var a:Double = 0
    init(a:Double){
        self.a = a
    }
    func getTotalSideLength() -> Double {
        return 4*a
    }
}

class Rectangle:PolygonShape {//长方形
    var a:Double = 0; var b:Double = 0
    init(a:Double, b:Double){
        self.a = a
        self.b = b
    }
    func getTotalSideLength() -> Double {
        return 2*(a+b)
    }
}

let triangle = Triangle(a:7,b:8, c:3)
print(triangle.getTotalSideLength())

let square = Square(a:5)
print(square.getTotalSideLength())

let rectangle = Rectangle(a:3,b:4)
print(rectangle.getTotalSideLength())
