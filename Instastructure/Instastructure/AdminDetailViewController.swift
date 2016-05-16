//
//  AdminDetailViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 5/8/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class AdminDetailViewController: UIViewController {
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateControl: UISegmentedControl!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var request: PFObject!
    var state: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get state
        state = request?["state"] as? String
        stateLabel.text = state
        
        // Update segmented control index
        if state == "New" {
            stateControl.selectedSegmentIndex = 0
        } else if state == "Reviewed" {
            stateControl.selectedSegmentIndex = 1
        } else if state == "Fixing" {
            stateControl.selectedSegmentIndex = 2
        } else if state == "Done" {
            stateControl.selectedSegmentIndex = 3
        }
        
        // Get image
        let imageFile = request["media"] as! PFFile
        imageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.requestImageView.image = image
                }
            }
        }
        
        let cerulean = UIColor(netHex: 0x4484CE).CGColor
        
        requestImageView.layer.cornerRadius = 5
        deleteButton.layer.cornerRadius = 5
        
        noteField.layer.borderWidth = 1
        noteField.layer.borderColor = cerulean
        noteField.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStateChange(sender: AnyObject) {
        var stateNum = 0
        switch stateNum {
        case 0...3:
            stateNum = stateControl.selectedSegmentIndex
        default:
            stateNum = 0
        }
        
        // Update state
        if stateNum == 0 {
            state = "New"
        } else if stateNum == 1 {
            state = "Reviewed"
        } else if stateNum == 2 {
            state = "Fixing"
        } else if stateNum == 3 {
            state = "Done"
        }
        
        stateLabel.text = state
        
        // Save change
        request["state"] = state
        request.saveInBackground()
    }
    
    @IBAction func onUpdatePhoto(sender: AnyObject) {
        
    }
    
    @IBAction func onDelete(sender: AnyObject) {
        request.deleteInBackground()
        print("Request deleted")
        
        self.performSegueWithIdentifier("unwindToVC", sender: self)
        print("Unwound")
    }

}
