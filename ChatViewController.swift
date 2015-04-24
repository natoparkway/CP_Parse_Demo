//
//  ChatViewController.swift
//  Chatter
//
//  Created by Nathaniel Okun on 4/23/15.
//  Copyright (c) 2015 Nathaniel Okun. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = [PFObject]()
    
    @IBAction func postMessage(sender: AnyObject) {
        var message = PFObject(className: "Message")
        message["text"] = messageText.text
        //message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock { (success, error: NSError?) -> Void in
            if success {
                println("object has been save")
            } else {
                println("object has not been saved")
            }
        }
    }
    
    func onTimer() {
        //Add code to be run periodically
        var query = PFQuery(className:"Message")    //Message is a class declared within parse
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.messages = objects as! [PFObject]
                self.tableView.reloadData()
            } else {
                //There was an error
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessageCell
        var dict = messages[indexPath.row]
        cell.messageLabel.text = dict["text"] as? String
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
