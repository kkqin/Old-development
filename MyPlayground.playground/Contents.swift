//: Playground - noun: a place where people can play

import UIKit
//var str = "fkit.orgabcxyz123crazyittianhijt"
//
//var Dic = [String:Int]()
//
//for key in str.characters{
//    if Dic[String(key)] != nil{
//        Dic[String(key)] = Dic[String(key)]!  + 1
//    }else{
//        Dic[String(key)] = 1
//    }
//}
//
//var maxkey:String!
//var maxVal = 1
//
//for (key, val) in Dic{
//    if val >= maxVal{
//        maxkey = key
//        maxVal = val
//    }
//}
//
//print(maxkey)
//print(maxVal) 

//class Person{
//    var name : String!
//    var age : String!
//    var phoneNum : String = ""{
//        willSet(num){
//            print("phone number will set be \(num)")
//        }
//        didSet{
//            print("phone number is \(oldValue) ")
//        }
//    }
//    
//    var s = "notSetSex"
//    
//    var sex : String {
//        get{ return s }
//        set{ s = newValue}
//    }
//    
//    func sayhello(){
//        print("hello \(self.name)")
//    }
//    
//}
//
//var k = Person()
//
//k.name = "jack"
//k.age = "12"
//k.phoneNum = "1233435"
//k.sex = "female"
//k.sayhello()

/////////////
struct EnglishDictionary {
   
    let wordsAndDefinitions = [
    "go" : "vi. 走;达到;运转;趋于",
    "come" : "vi. 来;开始;出现;发生;变成;到达",
    "Voltaire" : "n. 伏尔泰(法国启蒙思想家、哲学家、作家、历史学家)"
    ]
    
    subscript(index:Int) -> String{
       var arr = Array<String>()
        for i in wordsAndDefinitions.keys{
          arr.append(i)
        }
          
        return wordsAndDefinitions[arr[index]]!
    
    }
    
}

let word = EnglishDictionary()

for i in word.wordsAndDefinitions.keys{
    print(i)
}

print(word[2])

/////////编写一个Array扩展，使其能够计算集合的元素之和。 学号.zip文件名提交

var a : [Int] = [1, 3, 4, 5, 6, 7 ]

extension Array{
    
    func sum() -> Int{
        var total = 0
            for i in self{
                total += Int(i)
            }
        return total
    }
}

print(a.sum())
///例如 定义并实例化普通用户子类，管理员子类。 要求实现：继承、多态。 上传文件为“学号.zip

protocol Speak{
    func say()
}

class User {
    var name : String!
    var permission : String!
    
    init(){
        name = "notSet"
        permission = "defualt"
    }
    
    init(name:String, permission:String){
        self.name = name
        self.permission = permission
    }
    
}

class NormalUser:User, Speak{
    override init(name:String, permission:String){
        super.init(name: name, permission: permission)
    }
    
    func say(){
        print("I am a Normal User")
    }
}

class Admin:User, Speak{
    override init(name:String, permission:String){
        super.init(name: name, permission: permission)
    }
    
    func say(){
        print("I am a adminstr")
    }
}

var man = NormalUser(name: "Jack", permission: "low")
var woman = Admin(name: "Jane", permission: "high")
print("the \(man.name) permission is \(man.permission)")
print("the \(woman.name) permission is \(woman.permission)")
/////