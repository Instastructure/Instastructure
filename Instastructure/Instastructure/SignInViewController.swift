//
//  SignInViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/30/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Logged in :)")
                let admin = user!["admin"] as! Bool
                if (admin != true) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
                    self.presentViewController(vc, animated: true, completion: nil)
                } else {
                    let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("AdminNavigationController")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }

}
