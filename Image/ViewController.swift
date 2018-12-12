//
//  ViewController.swift
//  Image
//
//  Created by Megavision Technologies on 11/12/18.
//  Copyright © 2018 Megavision Technologies. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
    
   
    

    @IBAction func clickPicture(_ sender: UIButton) {
      //check if camera is availabe
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
       
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
       
        }
        else {
            print("Camera not available")
        }
    }
    
    @IBAction func browseGallery(_ sender: UIButton) {
        //check if photo gallery is accessible
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
        }
        else {
            print("Photo Library is not accessible")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

     //imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Error selecting image: \(info)")
        }
       
        imageView.image = selectedImage
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePicture(_ sender: UIButton) {
        let image = imageView.image
        let imageData = image!.jpegData(compressionQuality: 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)

        
        
        let alert = UIAlertController(title: "Image saved", message: "Image has been saved to Photo Library!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
