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

