////编写一个String扩展，使其能统计元音、辅音、其它字符的个数。 学号.zip 文件提交

extension String{
    func vowel() -> Int{
        var vo = 0
        
        for i in self.characters{
            switch i {
            case "a","e","o","u","i": vo++
            default:vo
            }
        }
    return vo
    }
    
    func consonant() -> Int{
        var vo = 0
        for i in self.characters{
            switch i {
            case "a","e","o","u","i": vo
            case "a"..."z":vo++
            default: vo
            }
        }
        return vo
    }
    
    func others() -> Int{
        var vo = 0
        for i in self.characters{
            switch i {
            case "a","e","o","u","i": vo
            case "a"..."z":vo
            default: vo++
            }
        }
        return vo
    }
    
}

let str = "12asdas7a ,x klwe"
print(str.others())
print(str.vowel())
print(str.consonant())

////

