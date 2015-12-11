/////////编写一个Array扩展，使其能够计算集合的元素之和。
var a : [Int] = [1, 3, 4, 5, 6, 7 ]

extension CollectionType where Generator.Element == Int{
    
    func sum() -> Int{
        var total = 0
            for i in self{
                total += i
            }
        return total
    }
}

print(a.sum())
