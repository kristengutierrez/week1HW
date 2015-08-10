//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr = [Int]()
arr += 1...100
let x = 3
let y = 5
for number in arr {
  if number == (x * 3) {
println("Fizz")
} else if number == (y * 5) {
  println("Buzz")
  } else if (x * 3) == (y * 5) {
    println("FizzBuzz")
  } else {
    println(number)
}
}







//for i in arr {
//var num: ( x : Int, y : Int) -> (Int) in
//  return
//}

//let x = 3

//var num: ( x : Int = 3, y : Int = 5) -> (Int) in
//for i in arr {
//  x * i
//}
//return



//for i in arr {
//  let fizz = (x * i)
//}


//switch arr {
//case let (x, y) where x = 3:
//let fizz = (x * arr.indexPath)
//println(fizz)
//case let (x, y) where y = 5:
//let buzz = (y * arr.indexPath)
//println(buzz)
//case (x, y) where fizz = buzz:
//  let fizzbuzz =
//println(fizzbuzz)
//}
