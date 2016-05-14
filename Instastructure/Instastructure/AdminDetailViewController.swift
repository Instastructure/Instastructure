//
//  AdminDetailViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 5/8/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit

class AdminDetailViewController: UIViewController {
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateControl: UISegmentedControl!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var requestImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpdatePhoto(sender: AnyObject) {
        
    }
    
    @IBAction func onDelete(sender: AnyObject) {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
