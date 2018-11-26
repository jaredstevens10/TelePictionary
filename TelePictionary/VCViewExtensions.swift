//
//  VCViewExtensions.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 1/14/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import AVFoundation
import MediaPlayer

extension ViewController {


@IBAction func View1CloseBTN(_ sender: AnyObject) {
    
    let DeviceH = self.view.frame.height
    let middleScreenY = DeviceH / 2
    let middleY = middleScreenY - 200
    
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
        
        self.ViewWelcomeHolder.center.y = self.ViewWelcomeHolder.center.y + 1050
        self.ViewWelcomeHolderTOP.constant = 1000
        
    })
    
    self.menuButton.isEnabled = true
    self.helpBTN.isEnabled = true
    self.revealViewController().panGestureRecognizer().isEnabled = true
    
}


@IBAction func GameCenterTryAgainBTN(_ sender: AnyObject) {
    
    LogIntoGameCenter()
    
    DispatchQueue.main.async(execute: {
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Game Center Error", subTitle: "Looks like the game center is having issues, try closing Pics & Quotes and reopening it.  If that doesn't help, go to the Game Center App and log in directly.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    })
    
    /*
    var localPlayer = GKLocalPlayer.localPlayer()
    localPlayer.authenticateHandler = {(viewController : UIViewController?, error : NSError?) -> Void in
    if viewController != nil {
    self.presentViewController(viewController!, animated: true, completion: nil)
    }else{
    
    print((GKLocalPlayer.localPlayer().authenticated))
    print("GKLocalPlayer name = \(GKLocalPlayer.localPlayer().alias)")
    }
    }
    */
    
}


@IBAction func ExplainPQ(_ sender: AnyObject) {
    
    PQExplained = true
    print("PQ Explained = \(PQExplained)")
    self.performSegue(withIdentifier: "First_Load", sender: self)
    
    //let AC = JSController("", MyMessage: "Come on back when you're done learning about Pics & Quotes - Pixie",Color: "Red")
    // self.presentViewController(AC, animated: true, completion: {
    
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
        
        
        self.ViewWelcome2BTN.center.y = self.ViewWelcome2BTN.center.y - 100
        self.keepGoingBTNTOP.constant = 0
        self.understandLBL.center.y = self.understandLBL.center.y - 100
        self.understandLBLTOP.constant = 15
        //  })
        
        
    })
    
}


@IBAction func GoToWelcomeView2(_ sender: AnyObject) {
    
    // if ViewingWelcome1 {
    
    print("FLIPPING TO ViewWelcome2 NOW")
    
    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
    
    UIView.transition(from: self.ViewWelcome1, to: self.ViewWelcome2, duration: 0.8, options: animationOptions, completion: nil)
    
    /*
    } else {
    
    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews]
    
    
    UIView.transitionFromView(self.View2Quote, toView: self.ImageView, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    */
}



@IBAction func GoToWelcomeView3(_ sender: AnyObject) {
    
    
    // if ViewingWelcome1 {
    
    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
    
    
    UIView.transition(from: self.ViewWelcome2, to: self.ViewWelcome3, duration: 0.8, options: animationOptions, completion: nil)
    
    /*
    } else {
    
    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews]
    
    
    UIView.transitionFromView(self.View2Quote, toView: self.ImageView, duration: 0.8, options: animationOptions, completion: nil)
    }
    
    */
    
    UserDefaults.standard.set(true, forKey: "FirstLaunch")
   
}
    
    func ShowIDViewNow() {
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        print("setting up user ID with game center")
        
        // if self.gameCenterEnabled {
        
        //user = GameLogin()
        
        print("The NEW Player Name is \(user)")
        
        
        DispatchQueue.main.async(execute: {
            
            print("user is = \(self.user)")
            
            
            
            
            let GCReady = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
            
            
            
            //if self.user == "" {
            
            if !GCReady {
                print("couldn't creat user because game center username is blank")
                
                //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
                //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
                
                
                
                
                let Alert = SCLAlertView()
                Alert.addButton("Log in Now", action: {
                    
                    
                    self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.actIndTwo.isHidden = false
                        self.actIndTwo.startAnimating()
                        
                        self.user = self.GameLogin()
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            var GCReadyTwo = Bool()
                            
                            

                            GCReadyTwo = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
                            
                            print("GCReadyTwo = \(GCReadyTwo)")
                            
                            DispatchQueue.main.async(execute: {
                                
                                if !GCReadyTwo {
                                    
                                    // if self.user == "" {
                                    print("User is still blank")
                                    
                                    self.actIndTwo.isHidden = true
                                    self.actIndTwo.stopAnimating()
                                    
                                    
                                } else {
                                    
                                    self.actIndTwo.isHidden = true
                                    self.actIndTwo.stopAnimating()
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        if !self.ShowingProfileView {
                                            
                                            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                                                
                                                
                                                self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
                                                
                                                self.ViewProfileTOP.constant = -64
                                                
                                                // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                                
                                                //   self.greatJobBOTTOM.constant = 15
                                                
                                                
                                            })
                                            
                                            self.ShowingProfileView = true
                                        }
                                        
                                    })
                                    
                                }
                                
                            })
                            
                        })
                        
                    })
                    
                })
                
                Alert.addButton("Later", action: {
                    
                    print("log in later")
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        let Alert2 = SCLAlertView()
                        
                        // if WasProfileUpdated {
                        Alert2.addButton("Ok", action: {
                            
                            
                            //self.greatJobLBL.text = "
                            DispatchQueue.main.async(execute: {
                                
                                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                                    
                                    
                                    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
                                    
                                    self.ViewProfileTOP.constant = 936
                                    
                                    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                    
                                    //   self.greatJobBOTTOM.constant = 15
                                    
                                    
                                })
                                
                                
                                
                                
                                if !self.DismissProfileView {
                                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                                        
                                        
                                        self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
                                        
                                        self.ViewWelcomeBTN3BOTTOM.constant = 0
                                        
                                        self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                        
                                        self.greatJobBOTTOM.constant = 15
                                        
                                        
                                    })
                                }
                                
                                self.DismissProfileView = true
                                //  })
                                //   }
                            })
                            
                        })
                        
                        Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without creating your Username you will be unable to create a new game.", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                })
                
                Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to create your Username.  Please log in now", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
                
                
                
                
            } else {
                print("created username for game")
                
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    
                    self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
                    
                    self.ViewProfileTOP.constant = -64
                    
                    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                    
                    //   self.greatJobBOTTOM.constant = 15
                    
                    
                })
                
                self.TryAgain = false
                
            }
            
        })
        
        
        
        
    }
    
    @IBAction func ShowCreateIDBTN(_ sender: AnyObject) {
        
        TryAgain = true
        
        ShowIDViewNow()
      
    }



func rateMe() {
    
    print("Showing Rate Me box")
    
    let neverRate = prefs.bool(forKey: "neverRate")
    
    var numLaunches = prefs.integer(forKey: "numLaunches") + 1
    
    if (!neverRate && (numLaunches == iMinSessions || numLaunches >= (iMinSessions + iTryAgainSessions + 1 ))) {
        showRateMe()
        numLaunches = iMinSessions + 1
    }
    
    prefs.set(numLaunches, forKey: "numLaunches")
    print("Number of Launches = \(numLaunches)")
}


func showRateMe() {
    
    
    DispatchQueue.main.async(execute: {
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Rate Pics & Quotes", action: {
           // UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/1023231287")!)
            
            DispatchQueue.main.async(execute: {
            
        UIApplication.shared.openURL(URL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1023231287&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")!)
                
                })
            
            
            // actionSheetController.dismissViewControllerAnimated(true, completion: {
            theAlert.dismiss(animated: true, completion: {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "20", levelpoints: "50")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points = \(numPoints)")
                    
                    //  let AC = JSController("Pixie Points..", MyMessage: "Thanks for Rating Pics & Quotes, to say thanks you've earned 50 Pixie Points and 20 Tokens.",Color: "Green")
                    //  self.presentViewController(AC, animated: true, completion: nil)
                    
                    DispatchQueue.main.async(execute: {
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points", subTitle: "Here's 50 Pixie Points and 20 Tokens, thanks!", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                })
                
            })
        })
        
        theAlert.addButton("Maybe Later", action: {
            
            let numLaunches = 0
            
            self.prefs.set(numLaunches, forKey: "numLaunches")
            
        })
        
        
        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Rate Our App", subTitle: "Thank you for playing Pics & Quotes", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    })
    
}

}
