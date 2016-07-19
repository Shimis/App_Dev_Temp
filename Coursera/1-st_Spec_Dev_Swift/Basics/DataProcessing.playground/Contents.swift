//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "small_putin.jpeg")!

let rgbImage = RGBAImage(image: image)!

var totalRed = 0
var totalGreen = 0
var totalBlue = 0


//  ------- Calculate avg Blue/Green/Red value of all pixels -------

for y in 0..<rgbImage.height{
    for x in 0..<rgbImage.width{
        let index = y * rgbImage.width + x
        let pixel = rgbImage.pixels[index]
        totalBlue += Int(pixel.blue)
        totalRed += Int(pixel.red)
        totalGreen += Int(pixel.green)

    }
    
}


// ---- End calculating -----------------------

let pixelsCount = rgbImage.height * rgbImage.width
let avgBlue = 89
let avgRed = 116
let avgGreen = 94
let sum = avgBlue + avgGreen + avgRed

// --- Strong black & white filter ----------

for y in 0..<rgbImage.height{
        for x in 0..<rgbImage.width{
            let index = y * rgbImage.width + x
            var pixel = rgbImage.pixels[index]
            
            if (Int(pixel.red) + Int(pixel.blue) + Int(pixel.green) < sum) {
                pixel.green = 0
                pixel.red = 0
                pixel.blue = 0
                rgbImage.pixels[index] = pixel
            }
            
            
            
    }
}

// ---- End strong black & white filter ------

// --- Contrast filter ------

//for y in 0..<rgbImage.height{
//    for x in 0..<rgbImage.width{
//        let index = y * rgbImage.width + x
//        var pixel = rgbImage.pixels[index]
//        
//        var blueDelta = Int(pixel.blue) - avgBlue
//        var redDelta = Int(pixel.red) - avgRed
//        var greenDelta = Int(pixel.green) - avgGreen
//        
//        
//        pixel.green = UInt8(max(min(255, Int(pixel.green) + 2 * greenDelta),0))
//        pixel.red = UInt8(max(min(255, Int(pixel.red) + 2 * redDelta),0))
//        pixel.blue = UInt8(max(min(255, Int(pixel.blue) + 2 * blueDelta),0))
//        rgbImage.pixels[index] = pixel
//        
//        
//        
//    }
//}

// ----- End Contrast Filter ----------

// ----- Nagetive filter ------

//for y in 0..<rgbImage.height{
//    for x in 0..<rgbImage.width{
//        let index = y * rgbImage.width + x
//        var pixel = rgbImage.pixels[index]
//        
//        var blueDelta = Int(pixel.blue) - avgBlue
//        var redDelta = Int(pixel.red) - avgRed
//        var greenDelta = Int(pixel.green) - avgGreen
//        
//        
//        pixel.green = UInt8(max(min(255, Int(pixel.green) - 2 * greenDelta),0))
//        pixel.red = UInt8(max(min(255, Int(pixel.red) - 2 * redDelta),0))
//        pixel.blue = UInt8(max(min(255, Int(pixel.blue) - 2 * blueDelta),0))
//        rgbImage.pixels[index] = pixel
//        
//        
//        
//    }
//}

// ----- End Negative filter --------

// ------- Magic Tool -------

//for y in 0..<rgbImage.height{
//    for x in 0..<rgbImage.width{
//        let index = y * rgbImage.width + x
//        var pixel = rgbImage.pixels[index]
//        
//        var blueDelta = Int(pixel.blue) - avgBlue
//        var redDelta = Int(pixel.red) - avgRed
//        var greenDelta = Int(pixel.green) - avgGreen
//        var modifier = 2
//        
//        if (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) > sum){
//            modifier = 1
//        }
//        
//        pixel.green = UInt8(max(min(255, avgGreen + modifier * greenDelta),0))
//        pixel.red = UInt8(max(min(255, avgRed + modifier * redDelta),0))
//        pixel.blue = UInt8(max(min(255, avgBlue + modifier * blueDelta),0))
//        rgbImage.pixels[index] = pixel
//        
//        
//        
//    }
//}

// -------- End Magic Tool -----


let newImage = rgbImage.toUIImage()!

22 * 128 + 15

var r = -100

r = max(0,min(r,255))





