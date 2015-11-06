class Person{
    var name : String!
    var age : String!
    var phoneNum : String = ""{
        willSet(num){
            print("phone number will set be \(num)")
        }
        didSet{
            print("phone number is \(oldValue) ")
        }
    }
    
    var s = "notSetSex"
    
    var sex : String {
        get{ return s }
        set{ s = newValue}
    }
    
    func sayhello(){
        print("hello \(self.name)")
    }
    
}

var k = Person()

k.name = "jack"
k.age = "12"
k.phoneNum = "1233435"
k.sex = "female"
k.sayhello()

