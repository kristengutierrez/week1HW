//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//MONDAY//

var arr = [1,2,3,4,5]

var reversedarr = [AnyObject]()

for num in arr {
  reversedarr.insert(num, atIndex: 0)
}
println(reversedarr)

//TUESDAY//

var numbers = [Int]()
numbers += 1...100

for number in numbers {
  switch number{
  case _ where number % 3 == 0 && number % 5 == 0:
    println("FizzBuzz")
  case _ where number % 3 == 0:
    println("Fizz")
  case _ where number % 5 == 0:
    println("Buzz")
  default:
    println(number)
    }
}

//WEDNESDAY//

var myString = "hi one hi two hi hi three hi four five hi"

var newArray = myString.componentsSeparatedByString("hi")
var numberss = (newArray.count - 1)
println(numberss)


//THURSDAY//

// var newString = myString.componentsSeparatedByCharactersInSet(separator: NSCharacterSet.self)
var yeah = myString.stringByReplacingOccurrencesOfString("i", withString: "", options: nil, range: nil)


//http://waynewbishop.com/swift/stacks-queues/ learning how to implement queues
//

class QNode<T> {
  var key: T?
  var next: QNode?
}


public class Queue<T> {
  private var top : QNode<T>! = QNode<T>()
  func enQueue(var key: T) {
    if (top == nil) {
      top = QNode<T>()
    }
    if (top.key == nil) {
      top.key = key
      return
    }
  
  var item: QNode<T> = QNode<T>()
  var current: QNode<T> = top
  while (current.next != nil) {
    current = current.next!
  }
  item.key = key
  current.next = item
  }
  func deQueue() -> T? {
    let topItem: T? = self.top?.key
    if (topItem == nil){
      return nil
    }
    var queueItem: T? = top.key!
    if let nextItem = top.next {
      top = nextItem
    } else {
      top = nil
    }
    return queueItem
  }
}




