//
//  ViewController.swift
//  Filetener
//
//  Created by Alexander Larionov on 14.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import UIKit

class Stage {
    var filters : [String : Double]
    var currentStage : String
    init(){
        self.filters = ["greyScale":0,"negative":0,"magicTool":0,"sepia":0,"contrast":0]
        self.currentStage = ""
    }
}


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image : UIImage?
    var photo : ImageProcessor?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let transitionLeft : CATransition = CATransition()
    var isFiltered : Bool = false
    let returnButImage : UIImage = UIImage(named: "return")!
    let cancelButImage : UIImage = UIImage(named: "back_icon")!
    var filterStage : Stage = Stage()
    
    
    @IBOutlet weak var originalImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = UIImage(named:"soup")
        photo = ImageProcessor(photo:image!)
        SecondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        SecondaryMenu.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    

    
    // Seconadary Menu
    
    @IBOutlet weak var cancelFilterBut: UIButton!
    @IBOutlet weak var topMenu: UIView!
    @IBOutlet var SecondaryMenu: UIView!
    @IBOutlet weak var SepiaBut: UIButton!
    @IBOutlet weak var ImageToggle: UIButton!
    @IBOutlet weak var NegativeBut: UIButton!
    @IBOutlet weak var MagicTool: UIButton!
    @IBOutlet weak var GreyScale: UIButton!
    @IBOutlet weak var filterSlider: UISlider!
    
    
    @IBAction func CancelAllFilters(sender: AnyObject) {
        self.ImageView.image = photo!.applyFilter("cancel", value: 2).toUIImage()
        filterStage = Stage.init()
        self.isFiltered = false
        self.CancelBut.enabled = false
        self.cancelFilterBut.enabled = false
        filterSlider.maximumValue = 3
        filterSlider.minimumValue = 1
        filterSlider.value = 1
        
    }

    @IBAction func GreyScaleAction(sender: UIButton) {
        tapOnFilterBut("greyScale")
    }
    
    
    @IBAction func NegativeButAction(sender: UIButton) {
        tapOnFilterBut("negative")
    }
    
    @IBAction func MagicToolAction(sender: UIButton) {
        tapOnFilterBut("magicTool")
    }
    
    
    @IBAction func ButToSepia(sender: UIButton) {
        tapOnFilterBut("sepia")
        
    }
    
    @IBAction func ContrastAction(sender: AnyObject) {
        tapOnFilterBut("contrast")
        
    }
    
    
    @IBAction func slideFilter(sender: AnyObject) {
        let slidervalue = Double(filterSlider.value)
        self.ImageView.image = photo!.applyFilter(filterStage.currentStage, value: slidervalue).toUIImage()
        filterStage.filters[filterStage.currentStage] = Double(filterSlider.value)
    }
    
    
    
    //FilterStaging
    
    func tapOnFilterBut(filter : String){
        if (filter != "sepia"){
            if(filterStage.filters[filter]==0){
                self.ImageView.image = photo!.applyFilter(filter, value: 1).toUIImage()
                filterStage.filters[filter] = 1.0
                filterSlider.maximumValue = 3
                filterSlider.minimumValue = 1
            }else{
                filterSlider.maximumValue = 3
                filterSlider.minimumValue = 1
                
            }
        }else{
            if(filterStage.filters[filter]==0){
                self.ImageView.image = photo!.applyFilter(filter, value: 0.1).toUIImage()
                filterStage.filters[filter] = 0.1
                filterSlider.maximumValue = 0.3
                filterSlider.minimumValue = 0.1
            }else{
                filterSlider.maximumValue = 0.3
                filterSlider.minimumValue = 0.1
            }
        }
        self.isFiltered = true
        self.CancelBut.enabled = true
        self.cancelFilterBut.enabled = true
        filterStage.currentStage = filter
        filterSlider.setValue(Float(filterStage.filters[filter]!), animated: true)

    }

    
    
    
    
    // Nav Bar
    
    //Main Scene
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var CancelBut: UIButton!
    @IBOutlet weak var FilterBut: UIButton!
    @IBOutlet weak var MainMenu: UIView!
    
    
    
    
    // Main Menu
    
    // Photo Button Action Sheet
    
    @IBAction func onNewPhoto(sender: AnyObject) {
         let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default,
            handler: { action in
                self.showCamera()
            }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default,
            handler: { action in
                self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        self.presentViewController(cameraPicker, animated: true, completion: nil)
        
        
        
    }
    
    func showAlbum() {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(albumPicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            
            var size = CGSize(width: 200, height: 200)
            var imageIcon = RBSquareImageTo(image, size: size)
            
            
            var smallIcon = ImageProcessor(photo: imageIcon)
            
            
            
            
            
            let sepiaPhoto = smallIcon.applyFilter("sepia", value: 0.1).toUIImage()
            
            
            smallIcon = ImageProcessor(photo: imageIcon)
            let negativePhoto = smallIcon.applyFilter("negative", value: 2).toUIImage()
            
            smallIcon = ImageProcessor(photo: imageIcon)
            let greyScalePhoto = smallIcon.applyFilter("greyScale", value: 2).toUIImage()
            
            smallIcon = ImageProcessor(photo: imageIcon)
            let magicPhoto = smallIcon.applyFilter("magicTool", value: 2).toUIImage()
            
            
            smallIcon = ImageProcessor(photo: imageIcon)
            let contrastPhoto = smallIcon.applyFilter("contrast", value: 1).toUIImage()
            
            self.SepiaBut.setImage(sepiaPhoto, forState: .Normal)
            self.NegativeBut.setImage(negativePhoto, forState: .Normal)
            self.GreyScale.setImage(greyScalePhoto, forState: .Normal)
            self.MagicTool.setImage(magicPhoto, forState: .Normal)
            self.ImageToggle.setImage(contrastPhoto, forState: .Normal)
            
            
            
            
            size = CGSize(width: 600, height: 600)
            imageIcon = RBSquareImageTo(image, size: size)
            self.originalImage.image = imageIcon
            self.photo = ImageProcessor(photo: imageIcon)
            ImageView.image = imageIcon

            
        }
        
        
        
    }
    

    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //Share Button
    
    @IBAction func onShare(sender: AnyObject) {
        let activitySheet = UIActivityViewController(activityItems: [ImageView.image!], applicationActivities: nil)
        self.presentViewController(activitySheet, animated: true, completion: nil)
        
        
    }
    
    
    //Cancel Button
    
    @IBAction func CancelAction(sender: UIButton) {
        
        if isFiltered{
            showOriginalImage()
            self.CancelBut.setImage(self.returnButImage, forState: .Normal)
            self.isFiltered = false
        }else{
            showFiltredImage()
            self.CancelBut.setImage(self.cancelButImage, forState: .Normal)
            self.isFiltered = true
        }
        
    }
    
   
    @IBAction func onFilterTap(sender: UIButton) {
        if (sender.selected){
            hideSecondaryMenu()
            sender.selected = false
            
        }else{
            ShowSecondaryMenu()
            sender.selected = true
        }
        
    }
    
    
    
    
    
    func ShowSecondaryMenu(){
        
        self.SecondaryMenu.hidden = false
        self.topMenu.hidden = false
        
        self.SecondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.SecondaryMenu.alpha = 1
            self.topMenu.alpha = 1
        }
        
        
    }
    
    func hideSecondaryMenu(){
        
        UIView.animateWithDuration(0.4, animations: {
            self.SecondaryMenu.alpha = 0
            self.topMenu.alpha = 0
            } ){ completed in
                if completed == true{
                    self.SecondaryMenu.hidden = true
                    self.topMenu.hidden = true
                }
               
        }
    }
    
    
    //Image Toggling
    
    @IBAction func holdImage(sender: AnyObject) {
        if isFiltered{
            showOriginalImage()
        }else{
            showFiltredImage()
        }
        
        
    }
    
    @IBAction func upImage(sender: AnyObject) {
        if isFiltered{
         showFiltredImage()
        }else{
          showOriginalImage()  
        }
            
        
    }
    
    
    func showOriginalImage () {
        self.originalImage.hidden = false
        UIView.animateWithDuration(0.7) {
            self.ImageView.alpha = 0
        }
        
    }
    
    func showFiltredImage(){
     
        UIView.animateWithDuration(0.7, animations: {
            self.ImageView.alpha = 1
            } ){ completed in
                if completed == true{
                    self.originalImage.hidden = true
                }
                
        }
        
        
    }
    
    
    
    
    

}

