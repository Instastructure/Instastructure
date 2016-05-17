//
//  RequestViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/30/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import IQDropDownTextField

class RequestViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryField: IQDropDownTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cerulean = UIColor(netHex: 0x4484CE).CGColor
        
        // Title field
        titleField.layer.borderWidth = 1
        titleField.layer.borderColor = cerulean
        titleField.layer.cornerRadius = 5
        
        // Category field
        categoryField.layer.borderWidth = 1
        categoryField.layer.borderColor = cerulean
        categoryField.layer.cornerRadius = 5
        
        // Description
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = cerulean
        descriptionTextView.layer.cornerRadius = 5
        
        // Container
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = cerulean
        issueImageView.layer.cornerRadius = 5
        
        // Category field
        categoryField.itemList = ["--Select Category--","Elevators and Escalators","Plumbing","Lighting", "Outlets","Streets and Sidewalks","Staff","HVAC","Cafeteria","Other"]
        categoryField.isOptionalDropDown = false
        
        submitButton.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            if editedImage.imageAsset != nil {
                issueImageView.image = editedImage
            } else {
                issueImageView.image = originalImage
            }
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onImageTap(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        Request.submitRequest(issueImageView.image, withTitle: titleField.text, withDescription: descriptionTextView.text, withCategory: categoryField.selectedItem, withTimestamp: timestamp) { (success: Bool, error: NSError?) -> Void in
            self.titleField.text = nil
            self.descriptionTextView.text = nil
            self.issueImageView.image = nil
            self.categoryField.selectedItem = self.categoryField.itemList[0]
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @IBAction func onBackgroundTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
}
