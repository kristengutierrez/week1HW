//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr = [1,2,3,4,5]

var reversedarr = [AnyObject]()

for num in arr {
  reversedarr.insert(num, atIndex: 0)
}
println(reversedarr)
