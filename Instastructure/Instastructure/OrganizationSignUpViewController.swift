//
//  SignUpViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/30/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class OrganizationSignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var organizationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignUp(sender: AnyObject) {
        // Initialize a user object
        let newUser = PFUser()
        
        // Set user properties
        newUser.username = usernameField.text
        newUser.email = emailField.text
        newUser.password = passwordField.text
        newUser["organization"] = organizationField.text
        newUser["admin"] = true
        
        // Call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Created a user :)")
                let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AdminViewController")
                self.presentViewController(vc, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                }
            }
        }
    }

    @IBAction func onBackgroundTap(sender: AnyObject) {
        self.view.endEditing(true)
    }

}
