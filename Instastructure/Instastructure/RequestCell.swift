//
//  RequestCell.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/29/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class RequestCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    var voteCount: Int?
    var voted = "neutral"
    
    var request: PFObject! {
        didSet {
            titleLabel.text = "\(request["title"]!) [\(request["state"])]"
            descriptionLabel.text = request["description"] as? String
            timeLabel.text = request["timestamp"] as? String
            
            voteCount = request["voteCount"] as? Int
            voteCountLabel.text = "\(voteCount!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onUpVote(sender: AnyObject) {
        if voted == "neutral" {
            voteCount! += 1
            voted = "up"
        } else if voted == "down" {
            voteCount! += 1
            voted = "neutral"
        }
        print("Upvoted")
        voteCountLabel.text = "\(voteCount!)"
        request["voteCount"] = voteCount
        request.saveInBackground()
    }

    @IBAction func onDownVote(sender: AnyObject) {
        if voted == "neutral" {
            voteCount! -= 1
            voted = "down"
            
        } else if voted == "up" {
            voteCount! -= 1
            voted = "neutral"
        }
        print("Downvoted")
        voteCountLabel.text = "\(voteCount!)"
        request["voteCount"] = voteCount
        request.saveInBackground()
    }
    
}
