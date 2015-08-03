//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr = ["this","is","my","array"]

println(arr)

println(reverse(arr))

/* http://stackoverflow.com/questions/30762152/reversing-strings-in-an-array-with-swift */
var anotherArr = ["jack","george","captain","wendy"]
for (index, word) in enumerate(anotherArr) {
let reversed = reverse(word)
let letters = reversed.map({ String($0) })
let joined = "".join(letters)
anotherArr[index] = joined
}
anotherArr
