//
//  TurnCompleteViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/19/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class TurnCompleteViewController: UIViewController, FBSDKLoginButtonDelegate {
    /*!
     @abstract Sent to the delegate when the button was used to login.
     @param loginButton the sender
     @param result The results of the login
     @param error The error (if any) from the login
     */
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    print("Test Login")
    }


    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (FBSDKAccessToken.current() != nil)
        {
            print("FB Already logged in")
            
        } else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            //  loginView.delegate = self
        }
        
        
        /*if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        */
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func menuButton(_ sender: AnyObject) {
        if self.revealViewController() == nil {
        self.performSegue(withIdentifier: "goto_menu", sender: self)
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
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Userlogged in")
        if ((error) != nil)
        {
            //process error
        } else if result.isCancelled {
            //handle Cancel
        } else {
            if result.grantedPermissions.contains("email")
            {
                //get the email info
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: {(connection, result, error) -> Void in
            if (error != nil)
            {
                print("Error: \(error)")
            } else {
                print("fetched user: \(result)")
                let userName : NSString = graphRequest.value(forKey: "name") as! NSString
            //    let userName : NSString = result.value(forKey: "name") as! NSString
                print("User name is: \(userName)")
                let userEmail : NSString = graphRequest.value(forKey: "email") as! NSString
               // let userEmail : NSString = result.value(forKey: "email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }

}
