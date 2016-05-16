//
//  AdminViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 5/7/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var requests: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 320
        
        doQuery()
        
        tableView.reloadData()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        doQuery()
        tableView.reloadData()
    }
    
    func doQuery() {
        // construct PFQuery
        let query = PFQuery(className: "Request")
        query.orderByDescending("createdAt")
        query.whereKey("organization", equalTo: PFUser.currentUser()!["organization"])
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.requests = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let requests = requests {
            return requests.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath: indexPath) as! RequestCell
        cell.request = requests![indexPath.row]
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        doQuery()
        
        // Hide the RefreshControl
        refreshControl.endRefreshing()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StarterNavigationController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "adminDetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let request = requests![indexPath!.row]
            
            let adminDetailViewController = segue.destinationViewController as! AdminDetailViewController
            adminDetailViewController.request = request
            
            print("Admin detail segue preparation called")
        }
     
    }
    
}
