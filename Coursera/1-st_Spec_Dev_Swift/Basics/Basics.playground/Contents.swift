//: Playground - noun: a place where people can play



//
// Arrays
//


import UIKit

var animals = ["cat", "dog", "cow"]

var myanimals = [
    "cat": "Maffin",
    "dog": "Aina",
    "cow": "Murka"
]

myanimals["cat"]

for animal in animals{
    myanimals[animal]
    
}




func foo (name: String, weight: Int) ->String{
    
    switch name{
    case "Maffin" : return "Maffins weight: "
    default : return "Not you"
    }
    
//return "Best "+f_var
}

foo("Maffin", weight: 10)
foo("Alex", weight: 70)


//
// 2D Arrays
//


var image = [
    [5,44,11],
    [12,18,53],
    [32,27,18]

]




func raiseImage (inout  inImage image:[[Int]], to number:Int){
    
    for i in 0..<image.count{
        for j in 0..<image[i].count{
            
            if image[i][j]<=number {
                image[i][j] = 0
            }
            
    
        }
    }
}


image

raiseImage(inImage: &image, to: 17)


image

let array: [Int] = []




