//
//  AppDelegate.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/28/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instastructure"
                configuration.clientKey = "fhq97wyefwihf987qhw3087efyq30w"
                configuration.server = "https://instastructure.herokuapp.com/parse"
            })
        )
        
        // Force logout for debugging
        // PFUser.logOut()
        
        if PFUser.currentUser() != nil {
            // if there is a logged in user then load the home view controller
            print("There is a current user")
            let vc: UIViewController?
            let user = PFUser.currentUser()
            let admin = user!["admin"] as! Bool
            if (admin != true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
            } else {
                let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                vc = storyboard.instantiateViewControllerWithIdentifier("AdminNavigationController")
            }
            
            window?.rootViewController = vc
        }
        
        // TabBar color customization
        let aluminumColor = UIColor(netHex: 0xD9D9D9)
        let lightColor = UIColor(netHex: 0xf9cf00)
        //let ceruleanColor = UIColor(netHex: 0x4484ce)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: aluminumColor], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: lightColor], forState:.Selected)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

