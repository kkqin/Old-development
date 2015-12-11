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

