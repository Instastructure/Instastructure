//
//  DetailViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 5/15/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var notesLabel: UILabel!
    
    var request: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = request["title"] as? String
        stateLabel.text = request["state"] as? String
        authorLabel.text = "Best Author Ever"
        descriptionLabel.text = request["description"] as? String
        timestampLabel.text = request["timestamp"] as? String
        notesLabel.text = ""
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
