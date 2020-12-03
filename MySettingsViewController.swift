//
//  MySettingsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 10/27/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class MySettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    
    var MediaType = NSString()
    var followAlert = String()
    var followingTurns = String()
    var likefailAlert = String()
    var SwitchSegmentName = NSString()
    var tap = UITapGestureRecognizer()
    @IBOutlet weak var closeBTN: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    var isPopover = Bool()
   
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: YUTableView!
    
   
    @IBOutlet weak var topView: UIView!
    
    

    
    var closeOtherNodes: Bool!;
    var insertRowAnimation: UITableView.RowAnimation!;
    var deleteRowAnimation: UITableView.RowAnimation!;
    
    var allNodes : [YUTableViewNode]!;
    
   // var menuTitles = ["Notifications", "Sounds","My Team", "Settings", "Logout"]
    var menuTitles = ["Notifications", "Sounds", "View Profile", "Update Profile", "Logout"]
    var menuPictures = ["notificationsIcon.png", "SoundShadowIcon.png", "meIcon-1.png", "meIconEdit.png", "logoutIcon.png"]
    var menuNotifications = ["New Followers", "Receive Like/Fail", "Following Turns"]
    var menuNotificationsIMG = ["notificationsicon.png", "notificationsicon.png", "notificationsicon.png"]
    var notificationTypeArray = ["newfollower", "notify_likefail", "newfollower"]
    var menuNotificationsSwitchState = [String]()
    //["on", "off"]
    var menuSounds = ["Game Music"]
    var menuSoundsIMG = ["howtoIcon.png"]
    var menuSoundSwitchState = ["yes"]
    //var menuViewProfile
    //var menuPictures = ["howtoIcon.png","howtoIcon.png","howtoIcon.png","howtoIcon.png","howtoIcon.png"]
    var menuMyTeam = ["Manage Team", "Create User"]
    var menuMyTeamIMG = ["howtoIcon.png", "howtoIcon.png"]
    var menuSettingsIMG = ["howtoIcon.png", "howtoIcon.png"]
    var menuSettings = ["Notifications","Password"]
    var subMenuThree = [NSString]()

    
    
    
    
    var username = NSString()
    var userID = NSString()
    
    let picker = UIImagePickerController()
    
    var UserFirstName = NSString()
    var UserLastName = NSString()
    
    var deviceToken = Data()
    var token = Data()
    var ShootingPhoto = Bool()
    @IBOutlet weak var ViewProfile: UIView!
    
    @IBOutlet weak var ViewProfileTOP: NSLayoutConstraint!
    var DismissProfileView = Bool()
    
    var ProfilePictureAdded = Bool()
    var ShowingProfileView = Bool()
    @IBOutlet weak var ProfileFirstNameTXT: UITextField!
    
    @IBOutlet weak var ProfileLastNameTXT: UITextField!
 
    @IBOutlet weak var ProfileLoadLBL: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileCameraBTN: UIButton!
    @IBOutlet weak var ProfilePhotoBTN: UIButton!
    @IBOutlet weak var ProfileSubmitBTN: UIButton!
    @IBOutlet weak var dobTXT: UITextField!
    @IBOutlet weak var pickerDoneButton: UIButton!
    
    @IBOutlet weak var ProfileSkipBTN: UIButton!
    
    
    var ProfileImageFinal = String()
    var EditingDOB = Bool()
    
    @IBOutlet weak var dobPicker: UIDatePicker!
    var UserDOB = NSString()
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var dobPickerTOP: NSLayoutConstraint!
    var IsGameCenter = Bool()
    
    var MuteAudio = Bool()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let prefs = UserDefaults.standard
    
    @IBOutlet var GameAudioSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        closeOtherNodes = true
        insertRowAnimation = .right
        deleteRowAnimation = .left
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        
        if !ISLOGGEDIN {
            self.performSegue(withIdentifier: "logout", sender: self)
          followAlert = "on"
            likefailAlert = "on"
            followingTurns = "no"
        } else {
           followAlert =  prefs.value(forKey: "FOLLOWALERT") as! String
           likefailAlert = prefs.value(forKey: "LIKEFAILALERT") as! String
           followingTurns = prefs.value(forKey: "FOLLOWALERT") as! String
        }
        
        menuNotificationsSwitchState.removeAll()
        menuNotificationsSwitchState.append(followAlert)
        menuNotificationsSwitchState.append(likefailAlert)
        menuNotificationsSwitchState.append(followAlert)
        

        setTableProperties();
        
        
        let dateString = "Thursday, 10 May 1990"
        let df = DateFormatter()
        df.dateFormat = "eeee, dd MM yyyy"
        let date = df.date(from: dateString)
        if let unwrappedDate = date {
            dobPicker.setDate(unwrappedDate, animated: false)
        }
        
        dobView.layer.borderWidth = 1
        dobView.layer.borderColor = UIColor.darkGray.cgColor
        
        ProfileFirstNameTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        ProfileLastNameTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        dobTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        
        //dobPicker.setDate(NSDate(), animated: true)
        dobPicker.maximumDate = Date()
        dobPicker.datePickerMode = UIDatePicker.Mode.date
        pickerDoneButton.layer.cornerRadius = 5
        pickerDoneButton.layer.borderWidth = 1
        pickerDoneButton.layer.borderColor = UIColor.white.cgColor
        pickerDoneButton.addTarget(self, action: #selector(MySettingsViewController.dismissPicker), for: UIControl.Event.touchUpInside)
        
         picker.delegate = self
        
        
        MuteAudio = prefs.bool(forKey: "MuteGameAudio")
        GameAudioSwitch.setOn(!MuteAudio, animated: false)
        GameAudioSwitch.onTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
       // GameAudioSwitch.layer.borderWidth = 1
        // GameAudioSwitch.layer.borderColor = UIColor.whiteColor().CGColor
        
       // GameAudioSwitch.isR
        
        
        GameAudioSwitch.addTarget(self, action: #selector(MySettingsViewController.stateChanged(_:)), for: UIControl.Event.valueChanged)
        
        self.title = "My Settings"
        
        if isPopover {
            topView.isHidden = false
            closeBTN.isHidden = false
            
        } else {
            
               navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
            topView.isHidden = true
            closeBTN.isHidden = true
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
           
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //}
       // let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
      //  view.addGestureRecognizer(tap)
    }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(MySettingsViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.isEnabled = false
    
        if self.prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            
        } else  {
           
            username = ""
            userID = ""

            //restartMyGames.hidden = true
        }
        
      //  self.containerView.backgroundColor = UIColor.NewColors.menuColor
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
        // scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        scrollView.contentSize = containerView.bounds.size
        // scrollView.bounces = false
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        
  
    }
   /*
    @IBAction func AudioSwitch(sender: AnyObject) {
        
        if GameAudioSwitch.on {
            GameAudioSwitch.setOn(false, animated: true)
            MuteAudio = true
            prefs.setBool(MuteAudio, forKey: "MuteGameAudio")
        } else {
           GameAudioSwitch.setOn(true, animated: true)
            MuteAudio = false
             prefs.setBool(MuteAudio, forKey: "MuteGameAudio")
        }
        
    }
*/

    @objc func stateChanged(_ switchState: UISwitch) {
        if GameAudioSwitch.isOn {
            
            MuteAudio = true
            prefs.set(MuteAudio, forKey: "MuteGameAudio")
        } else {
            MuteAudio = false
            prefs.set(MuteAudio, forKey: "MuteGameAudio")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func DismissCreateIDBTN(_ sender: AnyObject) {
        
        self.tap.isEnabled = false
        
        if Reachability.isConnectedToNetwork() {
        
        UserFirstName = ProfileFirstNameTXT.text! as NSString
        UserLastName = ProfileLastNameTXT.text! as NSString
        //UserDOB = dobTXT.text!
        
            
        
        let GCReady = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
        
        /*
        
        //if self.user == "" {
        
        if !GCReady {
            
            
            
            dispatch_async(dispatch_get_main_queue(), {
                print("waited for Game center to catch up")
                
                
                print("couldn't creat user because game center username is blank")
                
                //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
                //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
                //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
                
                
                
                
                let Alert = SCLAlertView()
                Alert.addButton("Try Logging in again", action: {
                    
                    
                    
                    
                   // self.IsPlayerLoggedIn = self.LogIntoGameCenter()
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                       // self.actIndTwo.hidden = false
                      //  self.actIndTwo.startAnimating()
                        
                    //    self.user = self.GameLogin()
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            
                            let GCReadyTwo = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
                            
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                
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
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        let Alert2 = SCLAlertView()
                        
                        // if WasProfileUpdated {
                        Alert2.addButton("Ok", action: {
                            
                            
                            //self.greatJobLBL.text = "
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    
                                    
                                    self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
                                    
                                    self.ViewProfileTOP.constant = 936
                                    
                                    // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                    
                                    //   self.greatJobBOTTOM.constant = 15
                                    
                                    
                                })
                                
                                
                                
                                
                                if !self.DismissProfileView {
                                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                                        
                                        
                                      //  self.ViewWelcome3BTN.center.y = self.ViewWelcome3BTN.center.y - 100
                                        
                                    //    self.ViewWelcomeBTN3BOTTOM.constant = 0
                                        
                                   //     self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                                        
                                   //     self.greatJobBOTTOM.constant = 15
                                        
                                        
                                    })
                                }
                                
                                self.DismissProfileView = true
                                //  })
                                //   }
                            })
                            
                        })
                        
                        Alert2.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without creating your Username you will be unable to create a new game.", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                })
                
                Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "We're still having trouble logging you into game center.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                
                
            })
            
            
            
        } else {
            
            */
            
            
            
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
                
                
                
                
                let smallImage = ProfileImage.image!.resize(0.8)
                
                
                //let imageData = UIImageJPEGRepresentation(smallImage, 1.0)
                let imageData = smallImage.jpegData(compressionQuality: 1.0)
                
                ProfileImageFinal = imageData!.base64EncodedString(options: [])
                
                
                //  prefs.setValue(NewGamePictureData, forKey: "PICTUREDATAD")
                
            }
            
            
            if UserFirstName.isEqual(to: "") || UserLastName.isEqual(to: "") {
                let AC = JSController("Missing Info", MyMessage: "You forgot to enter your first name or last name.",Color: "Red")
                //  self.presentViewController(AC, animated: true, completion: nil)
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your first name or last name.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            } else {
                
                /*
                
                if UserDOB.isEqualToString("") {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Missing Info", subTitle: "You forgot to enter your date of birth", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                } else {
                    
                    */
                    
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
                    
            //    }
            }
            
    //    }
        
        UserDefaults.standard.set(true, forKey: "ProfileSet")
        
        } else {
            
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")

        
        if !ISLOGGEDIN {
            
           self.performSegue(withIdentifier: "logout", sender: self)
        } else {
           
            
        }
        
        
        
        if !ShowingProfileView {
            
            //print("Pre Que - View Did Appear, Game Center enabled = \(gameCenterEnabled)")
            
            DispatchQueue.main.async(execute: {
                
                //print("Main Que - View Did Appear, Game Center enabled = \(self.gameCenterEnabled)")
                
                //  })
                
                
                if (self.prefs.value(forKey: "deviceToken") != nil)  {
                    self.token  = self.prefs.value(forKey: "deviceToken") as! Data
                    print("deviceToken not nil")
                    print("token = \(self.token)")
                } else {
                    print("DeviceToken IS nil")
                }
                
                
                
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
        
        
        
        //var post = post_old.addingPercentEscapes(using: String.Encoding.utf8)!
        //var post = post_old.stringByAddingPercentEncodingWithAllowedCharacters(using: String.Encoding.utf8)!
        var post = post_old.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        //var post = String(UTF8String: post_old.cStringUsingEncoding(NSUTF8StringEncoding))!
        //var post = String(UTF8String: post_old.cStringUsingEncoding(NSUTF8StringEncoding))!
        //let str = String(UTF8String: strToDecode.cStringUsingEncoding(​NSUTF8StringEncoding))
        
        
        //post = ("\(post)&ImageData=\(ProfileImageFinal)")
        post = ("\(post)&ImageData=TBD")
        
        // progressHUD.removeFromSuperview()
        //  progressHUD = ProgressHUD(text: "Saving Game Data...")
        //  self.view.addSubview(progressHUD)
        
        
        print("NEW POST STRING 4: \(post)")
        
        
        /*
        &Player1Cell=\(Player1Cell)&Player2Cell=\(Player2Cell)&Player3Cell=\(Player3Cell)&Player4Cell=\(Player4Cell)&Player5Cell=\(Player5Cell)&Player6Cell=\(Player6Cell)&Player7Cell=\(Player7Cell)&Player8Cell=\(Player8Cell)&Player9Cell=\(Player9Cell)&Player10Cell=\(Player10Cell)
        */
       //NSLog("PostData: %@",post);
        
        let url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/UpdateUserProfile.php")!
        
        //let postData:Data = post?.data(using: String.Encoding.ascii)! ?? <#default value#>
        let postData:Data = (post?.data(using: String.Encoding.ascii))!
        
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
            
           //NSLog("Response code: %ld", res?.statusCode);
            
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                
               //NSLog("Response ==> %@", responseData);
                
                //var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                let PlayerGameID:NSString = jsonData.value(forKey: "playerid") as! NSString
                
                let uniqueID = PlayerGameID.description
                print("uniqueID = \(uniqueID)")
                
                //[jsonData[@"success"] integerValue];
                
               //NSLog("Success: %ld", success);
                
                if(success == 1)
                {
                    UpdatedPro = true
                   //NSLog("New Game SUCCESS");
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success!"
                    alertView.message = "User Profile Updated."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    
                    if ProfilePictureAdded {
                    
                    MediaType = "image"
                    
                    
                    if MediaType == "gif" {
                        
                        UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "gif")
                        
                    } else {
                        
                        print("SHOULD UPLOAD IMAGE NOW")
                       // print("BASE 64 DATA IS = \(base64Image)")
                        UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "image")
                    }

                    }
                    
                    // alertView.show()
                    
                    
                    
                    //  self.performSegueWithIdentifier("Turn_Complete", sender: self)
                    
                    //NEED TO ADD NSNotification to go back to Home
                    
                    
                } else if (success == 5){
                    
                    UpdatedPro = true
                    
                    if ProfilePictureAdded {
                        
                        MediaType = "image"
                        
                        
                        if MediaType == "gif" {
                            
                            UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "gif")
                            
                        } else {
                            
                            print("SHOULD UPLOAD IMAGE NOW")
                            // print("BASE 64 DATA IS = \(base64Image)")
                            UploadGameFileData(ProfileImageFinal as String, FileName: "player\(uniqueID)", Type: "image")
                        }
                        
                    }
                    
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
    
    
    @objc func DismissKeyboard(){
        
        view.endEditing(true)
    }
    
    @IBAction func SkipCreateIDBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            
            self.ViewProfile.center.y = self.ViewProfile.center.y + 1000
            
            self.ViewProfileTOP.constant = 936
            
            // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
            
            //   self.greatJobBOTTOM.constant = 15
            
            
        })
        
    }
    
    @IBAction func ViewUpdateProfile(_ sender: AnyObject) {
        
        
        
        if username.isEqual(to: "") {
            
             DispatchQueue.main.async(execute: {
            
           SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "We're having trouble getting your ID, please make sure you're logged into Game Center", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            })
            
        } else {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            
            self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
            
            self.ViewProfileTOP.constant = 0
            
            // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
            
            //   self.greatJobBOTTOM.constant = 15
            
            
        })
            
        }
        
    }
    
    func ViewMyProfile() {
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        
        if !ISLOGGEDIN {
       // if username.isEqualToString("") {
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "We're having trouble getting your ID, please make sure you're logged in", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        } else {
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                self.tap.isEnabled = true
                self.ViewProfile.center.y = self.ViewProfile.center.y - 1000
                
                self.ViewProfileTOP.constant = 0
                
                // self.greatJobLBL.center.y = self.greatJobLBL.center.y - 100
                
                //   self.greatJobBOTTOM.constant = 15
                
                
            })
            
        }
    }

    
    @IBAction func photoFromLibary(_ sender: AnyObject) {
        
        print("photo from library")
        self.picker.allowsEditing = false //2
        self.picker.sourceType = .photoLibrary //3
        self.picker.modalPresentationStyle = .popover
        self.present(self.picker, animated: true, completion: nil)//4
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
        
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
            picker.sourceType = UIImagePickerController.SourceType.camera
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
    
    @IBAction func dobTXTTouched(_ sender: AnyObject) {
        
        view.endEditing(true)
        
        
        DispatchQueue.main.async(execute: {
            
            if !self.EditingDOB {
                
                self.ProfileSubmitBTN.isEnabled = false
                self.ProfileSkipBTN.isEnabled = false
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.dobView.center.y = self.dobView.center.y - 1050
                    
                    self.dobPickerTOP.constant = 150
                    // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
                    // self.QuoteLabelTop.constant = 50
                    //   self.qbDoneBOTTOM.constant = self.QuoteBoxBottom.constant + 20
                    
                    // self.qbDoneBOTTOM.constant = -(self.view.frame.height) + 100
                })
                
                
                self.EditingDOB = true
                
                
                
            } else {
                print("Game Title Changed begin true")
                
                
            }
            print("bottom textfieldchange1")
        })
        
    }
    
    
    
    @IBAction func dobTXTDidBeingEdit(_ sender: AnyObject) {
        
        print("textFieldChange1")
        
        view.endEditing(true)
        
        // qbDoneBTN.hidden = false
        
        //EditingGameTitle = true
        DispatchQueue.main.async(execute: {
            
            print("Turned On EditingGameTitle")
            
            if !self.EditingDOB {
                
                self.ProfileSubmitBTN.isEnabled = false
                self.ProfileSkipBTN.isEnabled = false
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.dobView.center.y = self.dobView.center.y - 1050
                    
                    self.dobPickerTOP.constant = 150
                    // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
                    // self.QuoteLabelTop.constant = 50
                    //   self.qbDoneBOTTOM.constant = self.QuoteBoxBottom.constant + 20
                    
                    // self.qbDoneBOTTOM.constant = -(self.view.frame.height) + 100
                })
                
                
                self.EditingDOB = true
                
                
                
            } else {
                print("Game Title Changed begin true")
                
                
            }
            print("bottom textfieldchange1")
            
        })
        
        
    }
    @IBAction func closeDOB(_ sender: AnyObject) {
        dismissPicker()
        
    }
    
    @objc func dismissPicker ()
    {
        
        if EditingDOB {
            
            UIView.animate(withDuration: 0.4, animations: {
                
                self.dobView.center.y = self.dobView.center.y + 1050
                
                self.dobPickerTOP.constant = 1200
                
                // self.pickerContainer.frame = CGRectMake(0.0, 50, 320.0, 300.0)
                
                let dateFormatter = DateFormatter()
                let dateFormatterTWO = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                dateFormatterTWO.dateFormat = "yyyy-MM-dd"
                self.UserDOB = dateFormatterTWO.string(from: self.dobPicker.date) as NSString
                self.prefs.setValue(self.UserDOB, forKey: "DOBSQL")
                
                let tempDate = dateFormatter.string(from: self.dobPicker.date)
                self.prefs.setValue(tempDate, forKey: "DOBUI")
                
                print("UserDOb formater two = \(self.UserDOB)")
                
                self.dobTXT.text = dateFormatter.string(from: self.dobPicker.date)
                // self.selectedDate.setTitle(dateFormatter.stringFromDate(self.picker.date), forState: UIControl.State.Normal)
                
                
            })
            
            ProfileSubmitBTN.isEnabled = true
            ProfileSkipBTN.isEnabled = true
            
            EditingDOB = false
            
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
    
    func setTableProperties () {
        allNodes = createNodes();
        tableView.setNodes(allNodes);
        tableView.setDelegate(self);
        
        
        print("Close other nodes = \(closeOtherNodes)")
        tableView.allowOnlyOneActiveNodeInSameLevel = closeOtherNodes;
        tableView.insertRowAnimation = insertRowAnimation;
        tableView.deleteRowAnimation = deleteRowAnimation;
        tableView.animationCompetitionHandler = {
            print("Animation ended");
        }
    }

    func setTableViewSettings (closeOtherNodes: Bool, insertAnimation: UITableView.RowAnimation, deleteAnimation: UITableView.RowAnimation) {
        self.closeOtherNodes = closeOtherNodes;
        self.insertRowAnimation = insertAnimation;
        self.deleteRowAnimation = deleteAnimation;
    }
    
    func createNodes () -> [YUTableViewNode] {
        var nodes = [YUTableViewNode] ();
        for i in 0..<5 {
            var childNodes = [YUTableViewNode] ();
            
            switch menuTitles[i] {
                
            case "Notifications":
                
                for j in 0...2 {
                    
                    var grandChildNodes = [YUTableViewNode] ();
                    /*
                    for k in 1...3 {
                    let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
                    grandChildNodes.append(node);
                    }
                    */
                    let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuNotificationsIMG[j])", "label": "\(menuNotifications[j])", "switchState": "\(menuNotificationsSwitchState[j])"], cellIdentifier: "ComplexCell");
                    childNodes.append(node);
                }
                
            case "View Profile":
                print("View profile node")
            case "Update Profile":
                print("Update profile node")
            
            case "Sounds":
                
                var grandChildNodes = [YUTableViewNode] ();
                /*
                for k in 1...3 {
                let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
                grandChildNodes.append(node);
                }
                */
                let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuSoundsIMG[0])", "label": "\(menuSounds[0])", "switchState": "\(menuSoundSwitchState[0])"], cellIdentifier: "ComplexCell");
                childNodes.append(node);
                /*
                for j in 0...1 {
                    
                    var grandChildNodes = [YUTableViewNode] ();
                    /*
                    for k in 1...3 {
                    let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
                    grandChildNodes.append(node);
                    }
                    */
                    let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuMyTeamIMG[j])", "label": "\(menuSounds[j])"], cellIdentifier: "ComplexCell");
                    childNodes.append(node);
                }
                */
                
                
            case "My Team":
                
                for j in 0...1 {
                    
                    var grandChildNodes = [YUTableViewNode] ();
                    /*
                    for k in 1...3 {
                    let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
                    grandChildNodes.append(node);
                    }
                    */
                    //var node = [[String:AnyObject]]()
                    let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuMyTeamIMG[j])", "label": "\(menuMyTeam[j])"], cellIdentifier: "ComplexCell");
                    childNodes.append(node);
                }
                
                
            case "Settings":
                
                for j in 0...1 {
                    var grandChildNodes = [YUTableViewNode] ();
                    for k in 1...3 {
                        let node = YUTableViewNode (data: "\(i).\(j).\(k)" as AnyObject?, cellIdentifier: "BasicCell");
                        grandChildNodes.append(node);
                    }
                    
                    //var node = [[String:AnyObject]]()
                    
                    let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuSettingsIMG[j])", "label": "\(menuSettings[j])"], cellIdentifier: "ComplexCell");
                    childNodes.append(node);
                }
                
                print("settings node")
            case "Logout":
                print("logout node")
            case "Menu 5":
                print("menu 5 node")
            default:
                break
                
            }
            
            /*
            for j in 1...3 {
            var grandChildNodes = [YUTableViewNode] ();
            for k in 1...3 {
            let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
            grandChildNodes.append(node);
            }
            let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "cat", "label": "\(i).\(j)"], cellIdentifier: "ComplexCell");
            childNodes.append(node);
            }
            
            */
            
            //let node = YUTableViewNode(childNodes: childNodes, data: "\(i)", cellIdentifier: "BasicCell");
            let node = YUTableViewNode(childNodes: childNodes, data: ["img": "\(menuPictures[i])", "label": "\(menuTitles[i])"], cellIdentifier: "BasicCell");
            nodes.append (node);
        }
        return nodes;
    }
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
    
    self.dismiss(animated: true, completion: nil)
    }
    
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //<#code#>
        //  scrollView.alpha = 0.5
        //   centerScrollViewContents()
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if (bottomEdge >= scrollView.contentSize.height) {
            print("we are at the bottom")
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.alpha = 1.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        /*
        if scrollView.contentOffset.x == 0 {
        scrollView.scrollRectToVisible(CGRect(x: 2304.0, y: 0.0, width: 768, height: 365), animated: false)
        }
        else if scrollView.contentOffset.x == 3072 {
        scrollView.scrollRectToVisible(CGRect(x: 768.0, y: 0.0, width: 768, height: 365), animated: false)
        }
        */
        scrollView.alpha = 1
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 600)
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600)
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    
    @objc func SwitchChanged(_ sender: UISwitch!) {
        let Row = sender.tag
        print("the Switch row selected: \(sender.tag)")
        var switchState = String()
        
        var newState = String()
        
        print("Notify switches = \(menuNotificationsSwitchState)")
        
        switch SwitchSegmentName {
            
            
        case "Notifications":
            print("Notifications was selected")
            switch Row {
            case 0:
                print("notifications row 0")
                switchState = menuNotificationsSwitchState[Row]
                print("SwitchState is \(switchState)")
                //UpdateNotifications(userID, type: "newfollowers", status: "yes")
                
            case 1:
                let newRow = Row - 1
                print("notifications row \(newRow)")
                switchState = menuNotificationsSwitchState[newRow]
                print("SwitchState is \(switchState)")
                var newIndex = Row - 1
                //menuNotificationsSwitchState.removeAtIndex(newRow)
                
                if menuNotificationsSwitchState[newRow] == "yes" {
                    newState = "no"
                    prefs.setValue("no", forKey: "FOLLOWALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "no")
                } else {
                    newState = "yes"
                    prefs.setValue("yes", forKey: "FOLLOWALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "yes")
                }
                menuNotificationsSwitchState.remove(at: newRow)
                menuNotificationsSwitchState.insert(newState, at: newRow)
                
                allNodes = createNodes();
                tableView.setNodes(allNodes);
                
                
                
            case 2:
                let newRow = Row - 1
                print("notifications row \(newRow)")
                switchState = menuNotificationsSwitchState[newRow]
                print("SwitchState is \(switchState)")
                var newIndex = Row - 1
                
                
                if menuNotificationsSwitchState[newRow] == "yes" {
                    newState = "no"
                    prefs.setValue("no", forKey: "LIKEFAILALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "no")
                } else {
                    newState = "yes"
                    prefs.setValue("yes", forKey: "LIKEFAILALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "yes")
                }
                
                menuNotificationsSwitchState.remove(at: newRow)
                menuNotificationsSwitchState.insert(newState, at: newRow)
                
                
                allNodes = createNodes();
                tableView.setNodes(allNodes);
                
            case 3:
                let newRow = Row - 1
                print("notifications row \(newRow)")
                switchState = menuNotificationsSwitchState[newRow]
                print("SwitchState is \(switchState)")
                var newIndex = Row - 1
                //menuNotificationsSwitchState.removeAtIndex(newRow)
                
                if menuNotificationsSwitchState[newRow] == "yes" {
                    newState = "no"
                    prefs.setValue("no", forKey: "FOLLOWALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "no")
                } else {
                    newState = "yes"
                    prefs.setValue("yes", forKey: "FOLLOWALERT")
                    UpdateNotifications(userID, type: notificationTypeArray[newRow] as NSString, status: "yes")
                }
                menuNotificationsSwitchState.remove(at: newRow)
                menuNotificationsSwitchState.insert(newState, at: newRow)
                
                allNodes = createNodes();
                tableView.setNodes(allNodes);
                
                
                //switchState = menuNotificationsSwitchState[Row]
                //print("SwitchState is \(switchState)")
            default:
                break
            }
            
            //self.performSegueWithIdentifier("viewHome", sender: self)
        case "Sounds":
            switch Row {
            case 0:
                print("Sounds row 0")
                switchState = menuSoundSwitchState[0]
                print("SwitchState is \(switchState)")
            case 1:
                print("Sounds row 1")
                switchState = menuSoundSwitchState[0]
                print("SwitchState is \(switchState)")
            case 2:
                print("Sounds row 2")
                switchState = menuSoundSwitchState[0]
                print("SwitchState is \(switchState)")
            default:
                break
            }
            
        default:
            break
        }
       // print("Switch with tag \(Row) was touched"))
        /*
        if (self.resultSearchController.active) {
        
        GameSelected =  GameSearchArray[GameRowSelected].GameID
        
        } else  {
        GameSelected = GameIDInfo[GameRowSelected]
        
        }
        */
        //self.performSegueWithIdentifier("ShowComments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logout" {
        if let destination = segue.destination as? LoginViewController {
            print("Prepare dismissVC")
            
            destination.FromSettings = true
            
        }
    }
    
    }
    
}


extension MySettingsViewController: YUTableViewDelegate {
    /**  Called inside "cellForRowAtIndexPath:" method. Edit your cell in this funciton. */
    
    public func setContentsOfCell(_ cell: UITableViewCell, node: YUTableViewNode, indexPath: IndexPath) {
        if let customCell = cell as? CustomTableViewCell, let cellDic = node.data as? [String:String] {
            
            //var indexPatt =
            customCell.backgroundColor = UIColor.clear
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);
            customCell.mySwitch?.tag = (indexPath as NSIndexPath).row
            customCell.mySwitch?.addTarget(self, action: #selector(MySettingsViewController.SwitchChanged(_:)), for: .touchUpInside)
            
            if cellDic["switchState"] == "yes" {
                customCell.mySwitch?.setOn(true, animated: false)
            } else {
                customCell.mySwitch?.setOn(false, animated: false)
            }
            
            //  customCell.label!.font = UIFont.NewFonts.MenuFont
            
            //   customCell.label!.textColor = UIColor.NewColors.menuTextColor
            //customCell.selectionStyle = UITableViewCell.SelectionStyle.None
            
            // switch cellDic["label"] as! String {
            switch cellDic["label"]! as String  {
            case "3.0":
                print("3.0 selected")
            default:
                break
            }
            
        } else if let cell = cell as? BasicCell, let cellDic = node.data as? [String:String] {
            
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            //  cell.titleLBL?.text =
            cell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);
            cell.titleIMG.image = UIImage(named: cellDic["img"]!)
            cell.titleIMG.isHidden = false
            print("title image should be \(cellDic["img"]!)")
            // cell.titleLabel!.font = UIFont.NewFonts.MenuFont
            // cell.titleLabel!.textColor = UIColor.NewColors.menuTextColor
            
            print("cell node data \(node.data)")
            
            cell.nextArrowIMG.image = UIImage(named: "right arrow.png")
            
            //switch cellDic["label"] as! String {
            
            switch cellDic["label"]! as String {
                
            case "Notifications":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = false
            case "Logout":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = true
            case "My Profile":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = true
            default:
                print("arrow is NOT hidden")
                cell.nextArrowIMG.isHidden = false
            }
            
            
            
            
        } else {
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel!.text = node.data as? String;
            //cell.textLabel!.font = UIFont.NewFonts.MenuFont
            
            // (name: "Marker Felt", size: 15.0)
            
        }

    }

  
    /*
    func setContentsOfCell(_ cell: UITableViewCell, node: YUTableViewNode, indexPath: IndexPath) {
        
        if let customCell = cell as? CustomTableViewCell, let cellDic = node.data as? [String:String] {
            customCell.backgroundColor = UIColor.clear
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);
            customCell.mySwitch?.tag = (indexPath as NSIndexPath).row
            customCell.mySwitch?.addTarget(self, action: #selector(MySettingsViewController.SwitchChanged(_:)), for: .touchUpInside)
            
            if cellDic["switchState"] == "yes" {
               customCell.mySwitch?.setOn(true, animated: false)
            } else {
               customCell.mySwitch?.setOn(false, animated: false)
            }
           
          //  customCell.label!.font = UIFont.NewFonts.MenuFont
            
         //   customCell.label!.textColor = UIColor.NewColors.menuTextColor
            //customCell.selectionStyle = UITableViewCell.SelectionStyle.None
 
           // switch cellDic["label"] as! String {
            switch cellDic["label"]! as String  {
            case "3.0":
                print("3.0 selected")
            default:
                break
            }
            
        } else if let cell = cell as? BasicCell, let cellDic = node.data as? [String:String] {
            
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            //  cell.titleLBL?.text =
            cell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);
            cell.titleIMG.image = UIImage(named: cellDic["img"]!)
            cell.titleIMG.isHidden = false
            print("title image should be \(cellDic["img"]!)")
           // cell.titleLabel!.font = UIFont.NewFonts.MenuFont
           // cell.titleLabel!.textColor = UIColor.NewColors.menuTextColor
            
            print("cell node data \(node.data)")
            
            cell.nextArrowIMG.image = UIImage(named: "right arrow.png")
            
            //switch cellDic["label"] as! String {
                
            switch cellDic["label"]! as String {
            
            case "Notifications":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = false
            case "Logout":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = true
            case "My Profile":
                print("arrow is hidden")
                cell.nextArrowIMG.isHidden = true
            default:
                print("arrow is NOT hidden")
                cell.nextArrowIMG.isHidden = false
            }
            
            
            
            
        } else {
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel!.text = node.data as? String;
            //cell.textLabel!.font = UIFont.NewFonts.MenuFont
            
            // (name: "Marker Felt", size: 15.0)
            
        }
    }
    */
    func heightForNode(_ node: YUTableViewNode) -> CGFloat? {
        if node.cellIdentifier == "ComplexCell" {
            return 70.0;
        }
        
        if node.cellIdentifier == "BasicCell" {
           // return 108.0;
            return 68.0;
        }
        return nil;
    }
    
    func didSelectNode(_ node: YUTableViewNode, indexPath: IndexPath) {
        
        let cellDic = node.data as? [String:String]
        
        //   if !node.hasChildren () {
        
        //if let subtitle = node.data["label"] {
        
        print("Node data = \(node.data)")
        
        switch cellDic!["label"]! as String {
            
            
        case "Notifications":
            print("home cell was selected")
            self.SwitchSegmentName = "Notifications"
            //self.performSegueWithIdentifier("viewHome", sender: self)
        case "Sounds":
            self.SwitchSegmentName = "Sounds"
            
        case "Manage Team":
            print("manage team cell was selected")
         //   self.performSegueWithIdentifier("createUser", sender: self)
            
        case "Create User":
            print("home cell was selected")
            
        case "View Profile":
            
            
        self.performSegue(withIdentifier: "ViewProfile", sender: self)
            
        case "Update Profile":
            
            self.ViewMyProfile()
            
        break
            
        case "Logout":
            
            prefs.set(false, forKey: "ISLOGGEDIN")
            
            prefs.setValue("guest", forKey: "EMAIL")
            
            prefs.setValue("guest", forKey: "USERNAME")
            
            prefs.setValue("guest", forKey: "PLAYERID")

            
            DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "logout", sender: self)
                })
            
            
            // self.performSegueWithIdentifier("viewHome", sender: self)
            
        default:
            break
            
            
        }
        
        /*
        } else {
        print("node does not have children")
        /*
        switch node.data["titleLBL"] as! String {
        
        case "Home":
        print("home cell was selected")
        
        self.performSegueWithIdentifier("viewHome", sender: self)
        
        default:
        break
        
        
        }
        */
        
        }
        
        */
        
        /*
        if !node.hasChildren () {
        //   let alert = UIAlertView(title: "Row Selected", message: "Label: \(node.data as! String)", delegate: nil, cancelButtonTitle: "OK");
        //   alert.show();
        }
        */
        //   }
    }
}

/*


import UIKit

class MenuViewController: UIViewController, UIScrollViewDelegate {

@IBOutlet weak var containerView: UIView!

let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

@IBOutlet weak var scrollView: UIScrollView!



@IBOutlet weak var tableView: YUTableView!

var closeOtherNodes: Bool!;
var insertRowAnimation: UITableViewRowAnimation!;
var deleteRowAnimation: UITableViewRowAnimation!;

var allNodes : [YUTableViewNode]!;

var menuTitles = ["Home", "My Profile","My Team", "Settings", "Logout"]
var menuPictures = ["homeIcon","meIcon","teamMembers","settingsIcon","logoutIcon"]
var menuMyTeam = ["Manage Team", "Create User"]
var menuMyTeamIMG = ["teamMembers", "meIcon"]
var menuSettingsIMG = ["notificationsIcon", "meIcon"]
var menuSettings = ["Notifications","Password"]
var subMenuThree = [NSString]()




override func viewDidLoad() {
super.viewDidLoad()


self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

closeOtherNodes = true
insertRowAnimation = .Right
deleteRowAnimation = .Left



setTableProperties();


self.view.backgroundColor = UIColor.NewColors.menuColor

self.containerView.backgroundColor = UIColor.NewColors.menuColor

scrollView.scrollEnabled = true
scrollView.pagingEnabled = false
scrollView.delegate = self
// scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
scrollView.contentSize = containerView.bounds.size
// scrollView.bounces = false

scrollView.showsHorizontalScrollIndicator = false
scrollView.autoresizingMask = UIView.AutoresizingMask.FlexibleHeight

// Do any additional setup after loading the view.
}


func setTableProperties () {
allNodes = createNodes();
tableView.setNodes(allNodes);
tableView.setDelegate(self);


print("Close other nodes = \(closeOtherNodes)")
tableView.allowOnlyOneActiveNodeInSameLevel = closeOtherNodes;
tableView.insertRowAnimation = insertRowAnimation;
tableView.deleteRowAnimation = deleteRowAnimation;
tableView.animationCompetitionHandler = {
print("Animation ended");
}
}

func setTableViewSettings (closeOtherNodes closeOtherNodes: Bool, insertAnimation: UITableViewRowAnimation, deleteAnimation: UITableViewRowAnimation) {
self.closeOtherNodes = closeOtherNodes;
self.insertRowAnimation = insertAnimation;
self.deleteRowAnimation = deleteAnimation;
}

func createNodes () -> [YUTableViewNode] {
var nodes = [YUTableViewNode] ();
for i in 0..<5 {
var childNodes = [YUTableViewNode] ();

switch menuTitles[i] {

case "Home":
print("home node")

case "My Profile":
print("my profile node")

case "My Team":

for j in 0...1 {

var grandChildNodes = [YUTableViewNode] ();
/*
for k in 1...3 {
let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
grandChildNodes.append(node);
}
*/
let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuMyTeamIMG[j])", "label": "\(menuMyTeam[j])"], cellIdentifier: "ComplexCell");
childNodes.append(node);
}


case "Settings":

for j in 0...1 {
var grandChildNodes = [YUTableViewNode] ();
for k in 1...3 {
let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
grandChildNodes.append(node);
}
let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "\(menuSettingsIMG[j])", "label": "\(menuSettings[j])"], cellIdentifier: "ComplexCell");
childNodes.append(node);
}

print("settings node")
case "Logout":
print("logout node")
case "Menu 5":
print("menu 5 node")
default:
break

}

/*
for j in 1...3 {
var grandChildNodes = [YUTableViewNode] ();
for k in 1...3 {
let node = YUTableViewNode (data: "\(i).\(j).\(k)", cellIdentifier: "BasicCell");
grandChildNodes.append(node);
}
let node = YUTableViewNode(childNodes: grandChildNodes, data: ["img": "cat", "label": "\(i).\(j)"], cellIdentifier: "ComplexCell");
childNodes.append(node);
}

*/

//let node = YUTableViewNode(childNodes: childNodes, data: "\(i)", cellIdentifier: "BasicCell");
let node = YUTableViewNode(childNodes: childNodes, data: ["img": "\(menuPictures[i])", "label": "\(menuTitles[i])"], cellIdentifier: "BasicCell");
nodes.append (node);
}
return nodes;
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

func scrollViewDidScroll(scrollView: UIScrollView) {
//<#code#>
//  scrollView.alpha = 0.5
//   centerScrollViewContents()

let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
if (bottomEdge >= scrollView.contentSize.height) {
print("we are at the bottom")
}
}

func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
scrollView.alpha = 1.0
}

func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

/*
if scrollView.contentOffset.x == 0 {
scrollView.scrollRectToVisible(CGRect(x: 2304.0, y: 0.0, width: 768, height: 365), animated: false)
}
else if scrollView.contentOffset.x == 3072 {
scrollView.scrollRectToVisible(CGRect(x: 768.0, y: 0.0, width: 768, height: 365), animated: false)
}
*/
scrollView.alpha = 1
}

override func viewDidLayoutSubviews() {
scrollView.contentSize = CGSize(width: self.view.frame.width, height: 600)
self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600)
}

func centerScrollViewContents() {
let boundsSize = scrollView.bounds.size
var contentsFrame = containerView.frame

if contentsFrame.size.width < boundsSize.width {
contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
} else {
contentsFrame.origin.x = 0.0
}

if contentsFrame.size.height < boundsSize.height {
contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
} else {
contentsFrame.origin.y = 0.0
}

containerView.frame = contentsFrame
}

@IBAction func GoBackBTN(sender: AnyObject) {
print("Back button tapped")

/*
sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ViewController())
sideMenuViewController?.hideMenuViewController()
*/
self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: true)

}



@IBAction func logoutBTN(sender: AnyObject) {

prefs.setInteger(0, forKey: "ISLOGGEDIN")
prefs.synchronize()

self.performSegueWithIdentifier("login", sender: self)

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

extension MenuViewController: YUTableViewDelegate {
func setContentsOfCell(cell: UITableViewCell, node: YUTableViewNode, indexPath: NSIndexPath) {

if let customCell = cell as? CustomTableViewCell, let cellDic = node.data as? [String:String] {
customCell.backgroundColor = UIColor.clearColor()
customCell.selectionStyle = UITableViewCell.SelectionStyle.None
customCell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);
customCell.label!.font = UIFont.NewFonts.MenuFont

customCell.label!.textColor = UIColor.NewColors.menuTextColor
//customCell.selectionStyle = UITableViewCell.SelectionStyle.None

switch node.data["label"] as! String {

case "3.0":
print("3.0 selected")
default:
break
}

} else if let cell = cell as? BasicCell, let cellDic = node.data as? [String:String] {

cell.backgroundColor = UIColor.clearColor()
cell.selectionStyle = UITableViewCell.SelectionStyle.None
//  cell.titleLBL?.text =
cell.setLabel(cellDic["label"]!, andImage: cellDic["img"]!);

cell.titleLBL!.font = UIFont.NewFonts.MenuFont
cell.titleLBL!.textColor = UIColor.NewColors.menuTextColor

print("cell node data \(node.data)")

switch node.data["label"] as! String {
case "Home":
print("arrow is hidden")
cell.nextArrowIMG.hidden = true
case "Logout":
print("arrow is hidden")
cell.nextArrowIMG.hidden = true
case "My Profile":
print("arrow is hidden")
cell.nextArrowIMG.hidden = true
default:
print("arrow is NOT hidden")
cell.nextArrowIMG.hidden = false
}




} else {
cell.backgroundColor = UIColor.clearColor()
cell.selectionStyle = UITableViewCell.SelectionStyle.None
cell.textLabel!.text = node.data as? String;
//cell.textLabel!.font = UIFont.NewFonts.MenuFont

// (name: "Marker Felt", size: 15.0)

}
}
func heightForNode(node: YUTableViewNode) -> CGFloat? {
if node.cellIdentifier == "ComplexCell" {
return 70.0;
}

if node.cellIdentifier == "BasicCell" {
return 68.0;
}
return nil;
}

func didSelectNode(node: YUTableViewNode, indexPath: NSIndexPath) {



//   if !node.hasChildren () {

//if let subtitle = node.data["label"] {

print("Node data = \(node.data)")

switch node.data["label"] as! String {


case "Home":
print("home cell was selected")

self.performSegueWithIdentifier("viewHome", sender: self)

case "Logout":
print("home cell was selected")

self.performSegueWithIdentifier("login", sender: self)


case "Manage Team":
print("manage team cell was selected")
self.performSegueWithIdentifier("createUser", sender: self)

case "Create User":
print("home cell was selected")

self.performSegueWithIdentifier("createNewUser", sender: self)

// self.performSegueWithIdentifier("viewHome", sender: self)

default:
break


}

/*
} else {
print("node does not have children")
/*
switch node.data["titleLBL"] as! String {

case "Home":
print("home cell was selected")

self.performSegueWithIdentifier("viewHome", sender: self)

default:
break


}
*/

}

*/

/*
if !node.hasChildren () {
//   let alert = UIAlertView(title: "Row Selected", message: "Label: \(node.data as! String)", delegate: nil, cancelButtonTitle: "OK");
//   alert.show();
}
*/
//   }
}
}

*/
