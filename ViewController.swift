//
//  ViewController.swift
//  Meme1
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate,
UINavigationControllerDelegate , UITextFieldDelegate  {
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var textUp: UITextField!
    @IBOutlet weak var textButtom: UITextField!
     @IBOutlet weak var PickImageView: UIImageView!
    
    
   
    
   //----------------------------------
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3,
        NSBackgroundColorAttributeName: UIColor.clearColor()
    ]
//----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
   imagePicker.delegate = self
        //view.backgroundColor = UIColor.grayColor()
        setupInitialView()
    }
    
    
    
    
    
    
    //----------------------------------------
    func setupTextFieldWithDefaultSettings(textField: UITextField, withText text: String) {
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.text = text
        textField.borderStyle = .None
    }
      //--------------------------------------
    func setupInitialView() {
        
        //reset Image Picker View
        PickImageView.image = nil
        
        setupTextFieldWithDefaultSettings(textUp, withText: "TOP")
        setupTextFieldWithDefaultSettings(textButtom, withText: "BOTTOM")
        
        
        
    }
    
    func generateMemedImage() -> UIImage {
        
       
        
        //Render view as an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return memedImage
    }
    @IBAction func PikanView(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func shootPhoto(sender: AnyObject) {
         imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
       
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        }else{
            print("no camera")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            PickImageView.contentMode = .ScaleAspectFit
            PickImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

    @IBAction func save(sender: AnyObject) {
        let imageData = UIImagePNGRepresentation(PickImageView.image!)
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)

    }
    
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
    func save() {
        let memedImage = generateMemedImage()
        _ = Meme(topText: textUp.text!, bottomText: textButtom.text!, originalImage: PickImageView.image!, memedImage: memedImage)
    }
    //MARK: -Method for generating the meme
        }
             






