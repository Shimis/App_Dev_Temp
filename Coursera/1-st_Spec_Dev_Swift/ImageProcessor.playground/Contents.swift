//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "putin.jpeg")

// Process the image!



var putinPhoto = ImageProcessor(photo: image!)



putinPhoto.applyFilter("negative", value: 2).toUIImage()

putinPhoto.applyFilter("cancel", value: 0).toUIImage()

putinPhoto.applyFilter("greyScale", value: 2).toUIImage()
putinPhoto.applyFilter("cancel", value: 0).toUIImage()
putinPhoto.applyFilter("magicTool", value: 2).toUIImage()
putinPhoto.applyFilter("cancel", value: 0).toUIImage()
putinPhoto.applyFilter("sepia", value: 0.1).toUIImage()
putinPhoto.applyFilter("cancel", value: 0).toUIImage()
putinPhoto.applyFilter("contrast", value: 2).toUIImage()

//putinPhoto.originalPhoto.toUIImage()
