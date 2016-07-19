import UIKit

public class ImageProcessor {
    public var photo : RGBAImage
    public let originalPhoto : UIImage
    let avgBlue: Int
    let avgRed : Int
    let avgGreen : Int
    let sumAvgColors : Int
    let pixelscount : Int
    let changedPhoto : RGBAImage
    
    required public init (photo: UIImage){
        self.photo = RGBAImage(image: photo)!
        self.originalPhoto = photo
        self.pixelscount = self.photo.height * self.photo.width
        var totalBlue = 0
        var totalRed = 0
        var totalGreen = 0
        for y in 0..<self.photo.height{
            for x in 0..<self.photo.width{
                let index = y * self.photo.width + x
                let pixel = self.photo.pixels[index]
                totalBlue += Int(pixel.blue)
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
            }
            
        }
        self.changedPhoto = self.photo
        self.avgBlue = totalBlue/pixelscount
        self.avgRed = totalRed/pixelscount
        self.avgGreen  = totalGreen/pixelscount
        self.sumAvgColors = avgBlue + avgGreen + avgRed
        
    }
    
    func toNegativeFilter (value : Double) -> RGBAImage {
        for y in 0..<photo.height{
            for x in 0..<photo.width{
                let index = y * photo.width + x
                var pixel = photo.pixels[index]
                
                let blueDelta = Int(pixel.blue) - avgBlue
                let greenDelta = Int(pixel.green) - avgGreen
                let redDelta = Int(pixel.red) - avgRed
                
                pixel.green = UInt8(max(min(255, Int(pixel.green) - Int(value) * greenDelta),0))
                pixel.red = UInt8(max(min(255, Int(pixel.red) - Int(value) * redDelta),0))
                pixel.blue = UInt8(max(min(255, Int(pixel.blue) - Int(value) * blueDelta),0))
                photo.pixels[index] = pixel
                
            }
        }
        return photo
        
    }
    
    func changeContrast (value : Double) -> RGBAImage {
        for y in 0..<photo.height{
            for x in 0..<photo.width{
                let index = y * photo.width + x
                var pixel = photo.pixels[index]
                
                let blueDelta = Int(pixel.blue) - avgBlue
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                
                
                pixel.green = UInt8(max(min(255, Int(pixel.green) + Int(value) * greenDelta),0))
                pixel.red = UInt8(max(min(255, Int(pixel.red) + Int(value) * redDelta),0))
                pixel.blue = UInt8(max(min(255, Int(pixel.blue) + Int(value) * blueDelta),0))
                photo.pixels[index] = pixel
                
            }
        }
        return photo
        
        
    }
    
    func magicTool (value : Double) -> RGBAImage {
        for y in 0..<photo.height{
            for x in 0..<photo.width{
                let index = y * photo.width + x
                var pixel = photo.pixels[index]
                
                let blueDelta = Int(pixel.blue) - avgBlue
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                var modifier = value
                
                if (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) > sumAvgColors){
                    modifier = 1
                }
                
                pixel.green = UInt8(max(min(255, avgGreen + Int(modifier) * greenDelta),0))
                pixel.red = UInt8(max(min(255, avgRed + Int(modifier) * redDelta),0))
                pixel.blue = UInt8(max(min(255, avgBlue + Int(modifier) * blueDelta),0))
                photo.pixels[index] = pixel
                
            }
        }
        return photo
    }
    func toSepia (value : Double) ->RGBAImage {
        for y in 0..<photo.height{
            for x in 0..<photo.width{
                let index = y * photo.width + x
                var pixel = photo.pixels[index]
                
                let green = Double(pixel.green) * (0.684 + value) + Double(pixel.red) * 0.349 + Double(pixel.blue) * 0.168
                let red = Double(pixel.green) * 0.769 + Double(pixel.red) * (0.393 + value) + Double(pixel.blue) * 0.189
                let blue = Double(pixel.green) * 0.534 + Double(pixel.red) * 0.272 + Double(pixel.blue) * (0.131 + value)
                
                pixel.green = UInt8(max(min(255, green),0))
                pixel.red = UInt8(max(min(255, red),0))
                pixel.blue = UInt8(max(min(255, blue),0))
                photo.pixels[index] = pixel
                
            }
        }
        return photo
        
        
        
        
        
    }
    
    func greyScale (value : Double) -> RGBAImage{
        
        for y in 0..<photo.height{
            for x in 0..<photo.width{
                let index = y * photo.width + x
                var pixel = photo.pixels[index]
                
                let green = Int(pixel.green) + Int(pixel.red) + Int(pixel.blue)
                let red = Int(pixel.green) + Int(pixel.red) + Int(pixel.blue)
                let blue = Int(pixel.green) + Int(pixel.red) + Int(pixel.blue)
                
                pixel.green = UInt8(max(min(255, green/Int(value)),0))
                pixel.red = UInt8(max(min(255, red/Int(value)),0))
                pixel.blue = UInt8(max(min(255, blue/Int(value)),0))
                photo.pixels[index] = pixel
                
            }
        }
        return photo
        
        
    }
    
    func cancelFilter () -> RGBAImage{
        photo = RGBAImage(image: originalPhoto)!
        return photo
    }
    
    public func applyFilter(name:String, value:Double)->RGBAImage{
        switch name {
            case "greyScale" :
                return self.greyScale(value)
            case "negative" :
                return self.toNegativeFilter(value)
            case "magicTool" :
                return self.magicTool(value)
            case "sepia" :
                return self.toSepia(value)
            case "contrast" :
                return self.changeContrast(value)
        case "cancel" :
            return self.cancelFilter()
        default : return self.photo
            
        }
        
        
    }
    
    
    
}
