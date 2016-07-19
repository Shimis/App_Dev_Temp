//: Playground - noun: a place where people can play

//All About Optionals


import UIKit

var str:String? = "Hi"

if str!.characters.count > 2 {
 
    
    print(str)
}


if let defString = str {
    
    defString.characters.count
    
}
else{
    print("it's nil")
}

// Classes


func sortCups (firstStr: String,secondStr: String) -> Bool{
    if firstStr.characters.first?.hashValue > secondStr.characters.first?.hashValue{
        return true
        
    }else{
        return false
    }
    
}

class CupHolders {
    var cups:[String]? = nil
}

class Car {
    var cupHolders:CupHolders? = nil
}


let niceCar = Car()

niceCar.cupHolders = CupHolders()

niceCar.cupHolders?.cups = ["Sprite"]


if var cupHolders = niceCar.cupHolders {
    if var cups = cupHolders.cups{
        cups.append("Coke")
    }
    else {
        cupHolders.cups = ["Coke"]
    }
}

niceCar.cupHolders?.cups?.append("Coke")

niceCar.cupHolders?.cups?.sortInPlace(<)

niceCar.cupHolders?.cups

let defString = niceCar.cupHolders?.cups?[0]


// Closure Functions

func getMagic (thingly:String) -> String{
    
     return thingly
}


getMagic("Hello")

let newMagicFunc = getMagic

newMagicFunc("Hey")

class numbers{
    var b : Int = 3
}

var oNum = numbers()

let b = 3
var numFunc: (Int) -> Int = {
    (a: Int) -> Int in
        return a + oNum.b
}

numFunc (1)

oNum.b = 10

numFunc (1)


// Value types

struct Numbers {
    var n : Int
    init (n : Int){
        self.n = n
    }
}

var aNumber = Numbers(n:10)
var bNumber = aNumber

bNumber.n = 5

aNumber.n
bNumber.n


class ClassNumber {
    var n : Int
    init (n : Int){
        self.n = n
    }
}

var cNumber = ClassNumber (n:10)
var dNumber = cNumber

dNumber.n = 5

cNumber.n
dNumber.n


//CheatSheet

class SuperNumber: NSNumber{
    override func getValue(value: UnsafeMutablePointer<Void>) {
        super.getValue(value)
    }
}

extension NSNumber {
    func SuperGetter()->Int{
        return 10
    }
}

let sNumber = NSNumber(int: 5)

sNumber.SuperGetter()


protocol readable{
    func read()
}

class SuperString: NSString, readable {
    func read() {
        return
    }
}


enum TypeOfVeggies: String{
    case Carrots
    case Potatoes
    case Tomatoes
}

let carrot = TypeOfVeggies.Carrots
carrot.rawValue
carrot.hashValue








