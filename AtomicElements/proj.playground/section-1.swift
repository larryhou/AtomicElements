// Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "4.png")

var list = ["name","larryhou","age","12"]
list.map
{
    $0.substringToIndex(advance($0.startIndex, 1))
}

