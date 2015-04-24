//
//  LoginViewController.swift
//  Chatter
//
//  Created by Nathaniel Okun on 4/23/15.
//  Copyright (c) 2015 Nathaniel Okun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func displayAlert(title: String, withError error: String ) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailField.text, password: passwordField.text) { (user: PFUser?, error: NSError?) -> Void in
            if let errorString = error {
                let actualErrorString:String = "Error Message"
                //self.displayAlert("Could Not Log In", error: )
                self.displayAlert("blah", withError: actualErrorString)
            } else {
                self.performSegueWithIdentifier("toChat", sender: self)
            }
        }
    }
    
    @IBAction func signUpButtonClicked(sender: AnyObject) {
        var user = PFUser()
        user.username = emailField.text!
        user.password = passwordField.text!
        user.email = "annawangx@gmail.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        //println(errorString)
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            
            if let errorString = error {
                let actualErrorString:String = "asdf"
                //self.displayAlert("Could Not Log In", error: )
                self.displayAlert("blah", withError: actualErrorString)
            } else {
                self.performSegueWithIdentifier("toChat", sender: self)
            }
        }
    
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
