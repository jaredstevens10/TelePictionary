//
//  VCExtension.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 11/30/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import AVFoundation
import MediaPlayer

extension ViewController {

    @IBAction func photoFromLibary(_ sender: AnyObject) {
        
print("photo from library")
            self.picker.allowsEditing = false //2
            self.picker.sourceType = .photoLibrary //3
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)//4
 
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        ShowingProfileView = true
        
        ProfileImage.contentMode = .scaleAspectFit //3
        // myImageView.image = chosenImage
        ProfileImage.image = chosenImage//4
        ProfilePictureAdded = true
        //  (StartSegment.subviews[0] ).tintColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
        
        print("Picture add = \(ProfilePictureAdded)")

        
       print("image picked")
        
        if UserFirstName.isEqual(to: "") || UserLastName.isEqual(to: "") {
            
            ProfileLoadLBL.text = "Waiting for input..."
            
        } else {
            
            ProfileLoadLBL.text = "Tap 'Submit' to continue"
        }

        
        self.dismiss(animated: true, completion: nil)
            
            /*{
            if self.ShootingPhoto {
                
                print("CAMERA DISMISSED")
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    
                    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
                    
                    self.ViewProfileTOP.constant = 0
                    
                    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                    
                    //   self.greatJobBOTTOM.constant = 15
                    
                    
                })
            }

        })
    */
    //5
        
        
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        ShowingProfileView = true
        
        
        
        dismiss(animated: true, completion: nil)
        print("image picker cancelled")
        
        
        
        
    }
    
    @IBAction func shootPhoto(_ sender: AnyObject)  {

    if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.cameraCaptureMode = .photo
    present(picker, animated: true, completion: nil)
    // mainImageView.image =
        
        self.ShootingPhoto = true
        self.ShowingProfileView = true
    } else {
    noCamera()
    }
    
       }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
 
    
    
    func keyboardWillHide(_ notification: Notification) {
        UserFirstName = ProfileFirstNameTXT.text! as NSString
        UserLastName = ProfileLastNameTXT.text! as NSString

        
        print("KEYBOARD WILL HIDE")
         if UserFirstName.isEqual(to: "") || UserLastName.isEqual(to: "") {
          
            ProfileLoadLBL.text = "Waiting for input..."
        
         } else {
            
            ProfileLoadLBL.text = "Insert Profile Pic?"
        }
        
        
        var info = (notification as NSNotification).userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            // self.QuoteBoxBottom.constant = (keyboardFrame.size.height - 120) + 20
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.doneBTNBOTTOM.constant = 10
        })

        
   
    }
    
     func keyboardWasShown(_ notification: Notification) {
        
        print("KEYBOARD SHOWING")
        
     var info = (notification as NSNotification).userInfo!
     
     let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
     
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
           // self.QuoteBoxBottom.constant = (keyboardFrame.size.height - 120) + 20
            //self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = (keyboardFrame.size.height + 5) + self.GameTitleTXT.frame.size.height
            
            self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 5
        })

        
        
    }
    
    @IBAction func SkipCreateIDBTN(_ sender: AnyObject) {
        
        UserFirstName = ProfileFirstNameTXT.text! as NSString
        UserLastName = ProfileLastNameTXT.text! as NSString
        
        
        
        UserDefaults.standard.set(true, forKey: "ProfileSet")
        
        
       
            
            ProfileImageFinal = ""
            
            
            //  prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
            
        
        if UserFirstName.isEqual(to: "") || UserLastName.isEqual(to: "") {
            
            
            let AC = JSController("Uh Oh...", MyMessage: "You don't have to add a profile image, but without your name your friends may have a hard time knowing it's you.",Color: "Red")
           // self.presentViewController(AC, animated: true, completion: nil)
            
            DispatchQueue.main.async(execute: {

             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh Oh...", subTitle: "You don't have to add a profile image, but without your name your friends may have a hard time knowing it's you.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        } else {
        
        
            
            
            let DeviceH = self.view.frame.height
            let middleScreenY = DeviceH / 2
            let middleY = middleScreenY - 200
            
            
            let WasProfileUpdated = UpdateUserProfile()
          
            
            if WasProfileUpdated {
                
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    
                    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
                    
                    self.ViewProfileTOP.constant = 936
                    
                    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                    
                    //   self.greatJobBOTTOM.constant = 15
                    
                    
                })
                
                
                
                
                if !DismissProfileView {
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
                        
                        self.ViewWelcomeBTN3BOTTOM.constant = 0
                        
                        self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                        
                        self.greatJobBOTTOM.constant = 15
                        
                        
                    })
                }
                DismissProfileView = true
                //  })
            }
            
        }
            /*else {
                let AC = JSController("Error Saving", MyMessage: "Error saving profile, please try again.",Color: "Red")
                self.presentViewController(AC, animated: true, completion: nil)
                
            }
*/
        
    }
    
    @IBAction func DismissCreateIDBTN(_ sender: AnyObject) {
        
        UserFirstName = ProfileFirstNameTXT.text! as NSString
        UserLastName = ProfileLastNameTXT.text! as NSString
        //UserDOB = dobTXT.text!
        
        
        let GCReady = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
        
        
        
        //if self.user == "" {
        
        if !GCReady {
            
            
            
            DispatchQueue.main.async(execute: {
            print("waited for Game center to catch up")
                
                
            print("couldn't creat user because game center username is blank")
            
            //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
            //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
            //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
            
            
            
            
            let Alert = SCLAlertView()
            Alert.addButton("Try Logging in again", action: {
                
                
                
                
                self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                
                
                DispatchQueue.main.async(execute: {
                    self.actIndTwo.isHidden = false
                    self.actIndTwo.startAnimating()
                    
                    self.user = self.GameLogin()
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        let GCReadyTwo = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            if !GCReadyTwo {
                                
                                // if self.user == "" {
                                print("User is still blank")
                                
                               // self.actIndTwo.hidden = true
                               // self.actIndTwo.stopAnimating()
                                
                                
                            } else {
                                
                              //  self.actIndTwo.hidden = true
                              //  self.actIndTwo.stopAnimating()
                                /*
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    if !self.ShowingProfileView {
                                        
                                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                                            
                                            
                                            self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
                                            
                                            self.ViewProfileTOP.constant = -64
                                            
                                            // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                            
                                            //   self.greatJobBOTTOM.constant = 15
                                            
                                            
                                        })
                                        
                                        self.ShowingProfileView = true
                                    }
                                    
                                })
                                
                                */
                                
                            }
                            
                        })
                        
                    })
                    
                })
                
            })
            
            Alert.addButton("Try again later", action: {
                
                
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
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "We're still having trouble logging you into game center.  Please log in now", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        })
        
            
            
        } else {
        
        
        
       
        
        if !ProfilePictureAdded  {
            
            //let AC = JSController("Missing Image or Quote", MyMessage: "You forgot to enter your first quote or select an image.",Color: "Red")
            //  self.presentViewController(AC, animated: true, completion: nil)
            
            //alertView.show()
            //  exit(0)
            //return
            
        } else {
            
            
            print("Converting Picture")
            
            UIGraphicsBeginImageContext(ProfileImage.bounds.size)
            ProfileImage.image?.draw(in: CGRect(x: 0, y: 0,
                width: ProfileImage.frame.size.width, height: ProfileImage.frame.size.height))
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            
            
            let smallImage = ProfileImage.image!.resize(0.5)
            
            
            let imageData = UIImageJPEGRepresentation(smallImage, 0.6)
            
            ProfileImageFinal = imageData!.base64EncodedString(options: []) as NSString
            
            
            //  prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
            
        }
        
        
        if UserFirstName.isEqual(to: "") || UserLastName.isEqual(to: "") {
            let AC = JSController("Missing Info", MyMessage: "You forgot to enter your first name or last name.",Color: "Red")
          //  self.presentViewController(AC, animated: true, completion: nil)
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your first name or last name.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        } else {
        
            
        if UserDOB.isEqual(to: "") {
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your date of birth", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            } else {
            
            

//self.SaveMyProfile()
           
            DispatchQueue.main.async(execute: {
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Submit", action: {
                     self.SaveMyProfile()
                })
               
                theAlert.addButton("View Agreement", action: {
                    self.ShowingProfileView = true
                     DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "ViewEULA", sender: self)
                        
                    })
                    
                    })
                
                
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "User Agreement", subTitle: "With creating your user profile you are accepting the end user agreeement", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
            
        }
     }
            
    }
        
        UserDefaults.standard.set(true, forKey: "ProfileSet")
        
        
  }
    
    @IBAction func ViewEULA(_ sender: AnyObject) {
        
        self.ShowingProfileView = true
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "ViewEULA", sender: self)
            
        })

    }
    
    
    func SaveMyProfile() {
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        let WasProfileUpdated = UpdateUserProfile()
        /*
        print("setting up user ID with game center")
        user = GameLogin()
        print("The NEW Player Name is \(user)")
        
        
        if user == "" {
        print("couldn't creat user because game center username is blank")
        } else {
        print("created username for game")
        }
        */
        // let AC = JSController("", MyMessage: "Coming Soon",Color: "Red")
        
        
        //  self.presentViewController(AC, animated: true, completion: {
        
        if WasProfileUpdated {
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                
                self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
                
                self.ViewProfileTOP.constant = 936
                
                // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                
                //   self.greatJobBOTTOM.constant = 15
                
                
            })
            
            
            
            
            if !DismissProfileView {
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    
                    self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
                    
                    self.ViewWelcomeBTN3BOTTOM.constant = 0
                    
                    self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                    
                    self.greatJobBOTTOM.constant = 15
                    
                    
                })
            }
            self.menuButton.isEnabled = true
            self.revealViewController().panGestureRecognizer().isEnabled = true
            ShowingProfileView = false
            DismissProfileView = true
            //  })
        } else {
            let AC = JSController("Error Saving", MyMessage: "Error saving profile, please try again.",Color: "Red")
            //  self.presentViewController(AC, animated: true, completion: nil)
            
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error Saving", subTitle: "Error saving profile, please try again.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }
        
    }
    
    func UpdateUserProfile() -> Bool {
        var ProfileUsername = NSString()
        var ProfileUserID = NSString()
        
        var ProfileToken = Data()
        
        var UpdatedPro = Bool()
     
        ProfileToken  = prefs.value(forKey: "deviceToken") as! Data
           // print("deviceToken not nil")
            print("token = \(token)")
       
        
       // let Token = ProfileToken
        let TokenNew2 = ProfileToken.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")

        
        if (prefs.value(forKey: "USERNAME") != nil)
        {
            ProfileUsername = (self.prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            ProfileUserID = (self.prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString            //   myID = prefs.valueForKey("PLAYERID") as! NSString as String
            print("Myid = \(ProfileUserID)")
            print("username not nil")
        }
        let email = "test123@\(ServerInfo.sharedInstance)"
        let privacy = "no"
        let password = "NA"
        
        let post_old = "username=\(ProfileUsername)&playerid=\(ProfileUserID)&firstname=\(UserFirstName)&lastname=\(UserLastName)&token=\(TokenNew)email=\(email)&privacy=\(privacy)&password=\(password)&dob=\(self.UserDOB)"
        
        print("POST OLD DATA = \(post_old)")
        
        
        
        var post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!
        

        
        post = ("\(post)&ImageData=\(ProfileImageFinal)")
        

    // progressHUD.removeFromSuperview()
    //  progressHUD = ProgressHUD(text: "Saving Game Data...")
    //  self.view.addSubview(progressHUD)
    
    
    print("NEW POST STRING 3: \(post)")
    
    
    /*
    &Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
    */
    //NSLog("PostData: %@",post);
    
    let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateUserProfile.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
    // var postData:NSData = post.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    var urlData: Data?
    do {
    urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
    reponseError = error
    urlData = nil
    }
    
    if ( urlData != nil ) {
    let res = response as! HTTPURLResponse!;
    
  //  //NSLog("Response code: %ld", res?.statusCode);
    
    if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
    {
    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
    
    //NSLog("Response ==> %@", responseData);
    
    //var error: NSError?
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    
    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
    
    //[jsonData[@"success"] integerValue];
    
    //NSLog("Success: %ld", success);
        
        
    
    if(success == 1)
    {
        UpdatedPro = true
    //NSLog("New Game SUCCESS");
        
        
    var json = JSON(jsonData)
        
    let isFun = json["isFun"].stringValue
        
        print("IS FUN = \(isFun)")
        prefs.setValue(isFun, forKey: "ISFUN")
    //self.dismissViewControllerAnimated(true, completion: nil)
    
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Success!"
    alertView.message = "User Profile Updated."
    alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    // alertView.show()
    
    
    
    //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
    
    //NEED TO ADD NSNotification to go back to Home
    
    
    } else if (success == 5){
        
         UpdatedPro = true
        
    } else {
         UpdatedPro = false
    var error_msg:NSString
    
    if jsonData["error_message"] as? NSString != nil {
    error_msg = jsonData["error_message"] as! NSString
    } else {
    error_msg = "Unknown Error"
    }
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Sign Up Failed!"
    alertView.message = error_msg as String
    alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    //  alertView.show()
        print("error message = \(error_msg)")
    
    }
    
    } else {
         UpdatedPro = false
        
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Sign Up Failed!"
    alertView.message = "Connection Failed"
    alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    //   alertView.show()
    }
    }  else {
         UpdatedPro = false
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Sign in Failed!"
    alertView.message = "Connection Failure"
    if let error = reponseError {
    alertView.message = (error.localizedDescription)
    }
    alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    //  alertView.show()
    }
    // }
    
   return UpdatedPro
    
}
    
    
    func DismissKeyboard(){
      
        view.endEditing(true)
    }


    func RemindPoints() {
        
        var ShowReminder = Bool()
        
        if (self.prefs.integer(forKey: "REMINDLAUNCHES") != 0) {
            
            print("REMIND LAUNCHES NOT NIL")
            
            var RemindLaunches = self.prefs.integer(forKey: "REMINDLAUNCHES")
            if RemindLaunches > 2 {
                
               ShowReminder = true
               self.prefs.set(1, forKey: "REMINDLAUNCHES")
            } else {
                print("ALERT REMINDER = false")
                RemindLaunches += 1
                self.prefs.set(RemindLaunches, forKey: "REMINDLAUNCHES")
            }
            
            
        } else {
            
            print("REMIND LAUNCHES IS 0")
            
        self.prefs.set(1, forKey: "REMINDLAUNCHES")
        }
        
        
        if ShowReminder {
            
            print("Showing Alert Reminder")
        
        
        let MessageArray = ["Earn Pixie Points starting new games!","Use your Pixie Points to import photos during your 'Drawing Turn'","Want more Pixie Points, don't forget to 'Like' and 'Fail' each turn as you view completed games","Use your Pixie Points to import Audio Clips during your 'Quote Turn'","Invite your friends on facebook and Earn Pixie Points","Earn Pixie Points by sharing completed games","You can create PUBLIC Games for anyone to play!","Want to take a turn now? Check out the PUBLIC Games","Add Images/Audio to your pencil box and use them anytime!"]
       // MessageArray.append
        
        let RemindString = MessageArray.randomItem()
        DispatchQueue.main.async(execute: {

        let myRemindView:RemindPointsView = UINib(nibName: "RemindPoints", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RemindPointsView

        myRemindView.remindLBL?.text = RemindString
            
            let DeviceH = self.view.frame.height
            //let halfH = DeviceH / 2;
            let DeviceW = self.view.frame.width
            //let WLess10 = DeviceW - 10;
            let startX = (DeviceW / 2) - 125;
            let startY = (DeviceH / 2) - 125;
            
            
            myRemindView.alpha = 0.0
            myRemindView.theView.layer.cornerRadius = 10
            myRemindView.theView.layer.masksToBounds = true
            myRemindView.theView.clipsToBounds = true
            myRemindView.frame = UIScreen.main.bounds

            self.view.addSubview(myRemindView)
            
            
            UIView.animate(withDuration: 0.25, animations: {
                myRemindView.alpha = 1.0
            })
            
        
            })
        
    }
    
        /*
        dispatch_async(dispatch_get_main_queue(), {
            var view = RemindPointsView.instanceFromNib()
            view.alpha = 0.0
            self.view.addSubview(view)
            
            UIView.animateWithDuration(0.25, animations: {
                view.alpha = 1.0
            })

        })
        */
    }
    
    //}
    
    
    
    
    func theShortCut () {
        
        
        print("SHOWING THE SHORTCUT FUNCTION")
        

    let shortcutKey = self.prefs.value(forKey: "SHORTCUT")
    print("1 VC View did appear - Value for Shortcut = \(shortcutKey)")
    
    
    if (self.prefs.value(forKey: "SHORTCUT") != nil) {
    let shortcutKey = self.prefs.value(forKey: "SHORTCUT")
    print("2 VC View did appear - Value for Shortcut = \(shortcutKey)")
    
    // var shortcutKeyNEW = shortcutKey?.description
    
    switch (shortcutKey! as AnyObject).description {
    
    case "NEWGAME":
    //self.prefs.setValue("", forKey: "SHORTCUT")
    print("going to new games from new Switch")
    print("going to new games from new Switch")
    if let viewControllers = self.navigationController?.viewControllers {
        print("view controller is navigation controller")
        for viewController in viewControllers {
            if viewController.isKind(of: ViewController.self) {
                print("is kind of class")
                
                self.prefs.setValue("", forKey: "SHORTCUT")
                self.GoToNewGame()
                
            } else {
              self.prefs.setValue("", forKey: "SHORTCUT")
            }
            
            /*
            else {
            print("go to root view controller")
            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
            
            }
            
            */
        }
        
        self.prefs.setValue("", forKey: "SHORTCUT")
        
        }
    
    case "MYGAMES":
    self.prefs.setValue("", forKey: "SHORTCUT")
        print("going to new games from new Switch")
        if let viewControllers = self.navigationController?.viewControllers {
            print("view controller is navigation controller")
            for viewController in viewControllers {
                if viewController.isKind(of: ViewController.self) {
                    print("is kind of class")
                    
                    self.prefs.setValue("", forKey: "SHORTCUT")
                    self.GoToMyGames()
                    
                } else {
                    self.prefs.setValue("", forKey: "SHORTCUT")
                }
                
                /*
                    else {
                    print("go to root view controller")
                    UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                    
                }

*/
            }
            
            self.prefs.setValue("", forKey: "SHORTCUT")
            
            
        }
        
        /*
        else {
            print("else showing")
            
            self.navigationController?.popToRootViewControllerAnimated(false)
            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: {
                self.GoToMyGames()
                
            })
        }
        
        
        //    dispatch_async(dispatch_get_main_queue(), {
        
        dispatch_async(dispatch_get_main_queue(), {
            //  self.dismissViewControllerAnimated(false, completion: nil)
            //self.StartSuggestedGame(QuoteExample, username: self.username, userid: self.userID)
            self.GoToMyGames()
        })
        
        */
    
    case "LEADERBOARDS":
    print("go to leaders")
     self.prefs.setValue("", forKey: "SHORTCUT")
    print("going to new games from new Switch")
    if let viewControllers = self.navigationController?.viewControllers {
        print("view controller is navigation controller")
        for viewController in viewControllers {
            if viewController.isKind(of: ViewController.self) {
                print("is kind of class")
                
                self.prefs.setValue("", forKey: "SHORTCUT")
                self.GoToLeaders()
                
            } else {
                self.prefs.setValue("", forKey: "SHORTCUT")
            }
            
            /*
            else {
            print("go to root view controller")
            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
            
            }
            
            */
        }
        self.prefs.setValue("", forKey: "SHORTCUT")
        
        }
        
    
    default:
    break
    self.prefs.setValue("", forKey: "SHORTCUT")
    
    }
    
    
    }
    
    
}
    

}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}


/*
extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
*/
