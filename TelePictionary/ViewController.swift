//
//  ViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/8/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



//@available(iOS 9.0, *)
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GKGameCenterControllerDelegate {
    
    var TryAgain = Bool()
    
    @IBOutlet weak var ProfileSkipBTN: UIButton!
    
    @IBOutlet weak var dobnewLBL: UILabel!
    @IBOutlet weak var dobPicker: UIDatePicker!
    var UserDOB = NSString()
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var dobPickerTOP: NSLayoutConstraint!
    var IsGameCenter = Bool()
    @IBOutlet weak var doItLaterBTN: UIButton!
    var IsHandlingAlertMessage = Bool()
    var GCErrorViewShowing = Bool()
    var StartedAGame = Bool()
    var PlayerIsLoggedInToGameCenter = Bool()
    var ShootingPhoto = Bool()
    var ShowingProfileView = Bool()
    @IBOutlet weak var actIndTwo: UIActivityIndicatorView!
    var EditingDOB = Bool()
    @IBOutlet weak var PixieWavingView: UIImageView!
    @IBOutlet weak var LeaderboardsViewBOTTOM: NSLayoutConstraint!
    @IBOutlet weak var GCErrorSubView: UIView!
    @IBOutlet weak var GameCenterErrorHolder: UIView!
    @IBOutlet weak var GCErrorSubViewHolder: UIView!
    @IBOutlet weak var LeaderBoardsView: UIView!
    
    var leaderboardIdentifier: String? = nil
    var gameCenterEnabled: Bool = false
    var ShowSettingsNotice = Bool()
    
    var IsPlayerLoggedIn = Bool()
    
    var ProfileImageFinal = NSString()
    var ProfilePictureAdded = Bool()
    let picker = UIImagePickerController()
    
    var UserFirstName = NSString()
    var UserLastName = NSString()
    
    @IBOutlet weak var doneBTN: UIButton!
    @IBOutlet weak var doneBTNBOTTOM: NSLayoutConstraint!
    var DismissProfileView = Bool()
    @IBOutlet weak var ViewProfile: UIView!
    
    @IBOutlet weak var ViewProfileTOP: NSLayoutConstraint!
    @IBOutlet weak var ProfileFirstNameTXT: UITextField!
    @IBOutlet weak var ProfileLastNameTXT: UITextField!
    @IBOutlet weak var ProfileLoadLBL: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileCameraBTN: UIButton!
    @IBOutlet weak var ProfilePhotoBTN: UIButton!
    @IBOutlet weak var ProfileSubmitBTN: UIButton!
    
    @IBOutlet weak var dobTXT: UITextField!
    
    var NewLikesArray = [Int]()
    var musicPlayer: AVAudioPlayer!
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    //let url = NSBundle.mainBundle().URLForResource("ComedicFun", withExtension: ".mp3")
    
    var url: URL!

    
    var PQExplained = Bool()
    var IDCreated = Bool()
    
    var GameIDArray = [NSString]()
    var VolumeMute = Bool()
    @IBOutlet var HowToView: UIView!
    @IBOutlet var MyFriendsView: UIView!
    var userLevel = Int()
    var userTokens = Int()
    @IBOutlet var MyGamesView: UIView!
    @IBOutlet var NewGameView: UIView!
    @IBOutlet var HowToW: NSLayoutConstraint!
    
    @IBOutlet var MyFriendsW: NSLayoutConstraint!
    @IBOutlet var NewGameH: NSLayoutConstraint!
    @IBOutlet var MyGamesH: NSLayoutConstraint!
    @IBOutlet weak var GCErrorViewTOP: NSLayoutConstraint!
    @IBOutlet weak var ViewWelcome2Explain: UIButton!
    @IBOutlet weak var ViewWelcome3CreateID: UIButton!
    @IBOutlet weak var ViewWelcome3BTN: UIButton!
    @IBOutlet weak var ViewWelcome2BTN: UIButton!
    
    @IBOutlet var MyFriendsH: NSLayoutConstraint!
    
   // @IBOutlet var MyFriendsH_LBL: NSLayoutConstraint!
    @IBOutlet var HowToH: NSLayoutConstraint!
    
  //  @IBOutlet var HowToH_LBL: NSLayoutConstraint!
    @IBOutlet var ActInd: UIActivityIndicatorView!
    
    @IBOutlet weak var redLeft: NSLayoutConstraint!
    @IBOutlet weak var yellowTop: NSLayoutConstraint!
    @IBOutlet weak var heartTOP: NSLayoutConstraint!
    @IBOutlet weak var keepGoingBTNTOP: NSLayoutConstraint!
    @IBOutlet weak var understandLBLTOP: NSLayoutConstraint!
    @IBOutlet weak var redPencil: UIImageView!
    @IBOutlet weak var bluePencil: UIImageView!
    @IBOutlet weak var TurnsAvailableLBL: UILabel!
    @IBOutlet weak var TurnsAvailableTOP: NSLayoutConstraint!
    //MyTurnsAvailable.php
    @IBOutlet var VolumeBTN: UIBarButtonItem!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var heartViewLBL: UILabel!
    @IBOutlet weak var heartViewImage: UIImageView!
    @IBOutlet weak var heartViewBTN: UIButton!
    @IBOutlet weak var helpBTN: UIBarButtonItem!
   // @IBOutlet weak var yellowPencil: UIImageView!
    
    var defaultCFUN = Bool()
    var gcEnabled = Bool()
    var user = NSString()
    var welcometxt = NSString()
    var numPoints = Int()
    var Total_Likes = Int()
    var NotfirstLaunch = false
    var localPlayer = GKLocalPlayer.localPlayer()
    var SuggestedQuote = NSString()
    var SuggestedUserName = NSString()
    var SuggestedUserID = NSString()
    var SuggestedRating = NSString()
    var SuggestedTitle = NSString()
    var SuggestedPlayers = Int()
    var SuggestedTurnTime = NSString()
    var SuggestedFirstTurn = NSString()
    var SuggestedNewGameImage = UIImage()

    var SuggestedNewGamePictureData = NSString()
    var AlreadyLoaded = Bool()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var mygamesBTN: UIButton!
    @IBOutlet weak var ViewWelcomeBTN3BOTTOM: NSLayoutConstraint!
    @IBOutlet weak var greatJobBOTTOM: NSLayoutConstraint!
    @IBOutlet weak var greatJobLBL: UILabel!
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var howtoButton: UIButton!
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet weak var blueRight: NSLayoutConstraint!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var userID = NSString()
    var username = NSString()
    var Email = NSString()
    var player = NSString()
    var playerid = NSString()
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var understandLBL: UILabel!
    var password = NSString()
    var deviceToken = Data()
    var token = Data()
    var Params: NSString!
    var GameID = NSString()
    var TurnNumber = NSString()
    var GameType = NSString()
    var GameBY = NSString()
    var myID = NSString()
    var GameSegue = "Take_My_Turn"
    
    var ImportedFileURL = NSString()
    
    // CHANGE BACK TO 6
    var iMinSessions = 20
    var iTryAgainSessions = 20
    
    var iMinSessionsSettings = 5
    var iTryAgainSessionsSettings = 5
    
   // var numLaunches = prefs.integerForKey("numLaunches") + 1
  
    
    
    @IBOutlet weak var ViewLoad1MSG: UILabel!
    @IBOutlet weak var ViewWelcomeHolderTOP: NSLayoutConstraint!
    @IBOutlet weak var ViewWelcomeHolder: UIView!
    @IBOutlet weak var SubViewWelcome: UIView!
    @IBOutlet weak var ViewWelcome2: UIView!
    @IBOutlet weak var ViewWelcome3: UIView!
    @IBOutlet weak var ViewWelcome1: UIView!
    @IBOutlet weak var ViewLoadHolder: UIView!
    @IBOutlet weak var ViewLoadHolderTOP: NSLayoutConstraint!
    @IBOutlet weak var SubViewLoad: UIView!
    @IBOutlet weak var ViewWelcome1BTN: UIButton!
    @IBOutlet weak var pickerDoneButton: UIButton!
    @IBOutlet weak var ViewLoad1: UIView!
    @IBOutlet weak var ViewLoad2: UIView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let isNo = "no"
        prefs.setValue(isNo, forKey: "ISFUN")
        
        TryAgain = true
        
        
        let dateString = "Thursday, 10 May 1990"
        let df = DateFormatter()
        df.dateFormat = "eeee, dd MM yyyy"
        let date = df.date(from: dateString)
        if let unwrappedDate = date {
            dobPicker.setDate(unwrappedDate, animated: false)
        }
        
        dobView.layer.borderWidth = 1
        dobView.layer.borderColor = UIColor.darkGray.cgColor
        dobnewLBL.backgroundColor = UIColor.white
        dobnewLBL.clipsToBounds = true
        dobnewLBL.layer.cornerRadius = 5
        dobnewLBL.text = "date of birth"
        
        let tapLBL:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dobLBLAction(_:)))
        dobnewLBL.addGestureRecognizer(tapLBL)
       // tapLBL.delegate = self
        
        ProfileFirstNameTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        ProfileLastNameTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        dobTXT.font = UIFont(name: "DK Cool Crayon", size: 14.0)
        
        //dobPicker.setDate(NSDate(), animated: true)
        dobPicker.maximumDate = Date()
        dobPicker.datePickerMode = UIDatePickerMode.date
        pickerDoneButton.layer.cornerRadius = 5
        pickerDoneButton.layer.borderWidth = 1
        pickerDoneButton.layer.borderColor = UIColor.white.cgColor
        pickerDoneButton.addTarget(self, action: #selector(ViewController.dismissPicker), for: UIControlEvents.touchUpInside)
        
        self.actIndTwo.isHidden = true
        mygamesBTN.isEnabled = false
        print("START VIEW DID LOAD")
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)

        self.LeaderboardsViewBOTTOM.constant = -81
        
      //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleAlertMessage:", name: "HandleAlertMessage",  object: nil)
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVC:", name: "HandleShorcutVC",  object: nil)
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVCmyGames:", name: "HandleShorcutVCmyGames",  object: nil)
        
    //    NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVCleaders:", name: "HandleShorcutVCleaders",  object: nil)
        
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "NewGameStarted:", name: "NewGameStarted",  object: nil)
        
        
   //     NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayLaunchDetails", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
  //      NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayBackgroundDetails", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
   //     NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayRemoteNotificationKeyDetails", name: UIApplicationLaunchOptionsRemoteNotificationKey, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWasShown:"), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWillHide:"), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    //    dobTXT.addTarget(self, action: Selector("textFieldDidChangeBegin:"), forControlEvents: UIControlEvents.EditingDidBegin)
        
    //    dobTXT.addTarget(self, action: Selector("textFieldDidChangeEnd:"), forControlEvents: UIControlEvents.EditingDidEnd)
        
        
        
        /*
        if #available(iOS 9.0, *) {
        //   let shortcut = UIApplicationShortcutItem(type: "newgame2.PQ.createnewgame2", localizedTitle: "Start New Game", localizedSubtitle: "Dynamic Action", icon: UIApplicationShortcutIcon(type: .Add), userInfo: nil)
        
        //   UIApplication.sharedApplication().shortcutItems = [shortcut]
        
        } else {
        // Fallback on earlier versions
        }
        
        /*
        if #available(iOS 9.0, *) {
        UIApplication.sharedApplication().shortcutItems = [shortcut]
        } else {
        // Fallback on earlier versions
        }
        */
        */
        

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
        
        
        ViewLoad1MSG.text = "Searching for user..."
        //   let song = "ComedicFun.caf"
        ViewLoadHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        ViewWelcomeHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        GameCenterErrorHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        ViewLoad1.layer.cornerRadius = 10
        ViewLoad2.layer.cornerRadius = 10
        
        SubViewLoad.layer.cornerRadius = 10
        ViewLoad1.layer.masksToBounds = true
        ViewLoad2.layer.masksToBounds = true
        
        SubViewWelcome.layer.cornerRadius = 10
        SubViewWelcome.layer.masksToBounds = true
        ViewWelcome1.layer.cornerRadius = 10
        ViewWelcome2.layer.cornerRadius = 10
        ViewWelcome1.layer.masksToBounds = true
        ViewWelcome2.layer.masksToBounds = true
        ViewWelcome3.layer.cornerRadius = 10
        ViewWelcome3.layer.masksToBounds = true
        GCErrorSubView.layer.masksToBounds = true
        GCErrorSubView.layer.cornerRadius = 10
        GCErrorSubViewHolder.layer.masksToBounds = true
        GCErrorSubViewHolder.layer.cornerRadius = 10
        picker.delegate = self

        Total_Likes = 0
        
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //let WLess10 = DeviceW - 10;
        let WidthSize = (DeviceW / 2) - 10;
        let HeightSize = (DeviceH - 250) / 5;
        
        

        NewGameH.constant = HeightSize;
        HowToH.constant = HeightSize;
        MyFriendsH.constant = HeightSize;
        MyGamesH.constant = HeightSize;
        MyFriendsW.constant = WidthSize;
        HowToW.constant = WidthSize;
        
        //  MyFriendsH_LBL.constant = HeightSize - 10;
        //  HowToH_LBL.constant = HeightSize - 10;
        
        
        //   print("How To height = \(howtoButton.frame.height)")
        
        //    print("My Games height = \(mygamesBTN.frame.height)")       // let middleScreenY = DeviceH / 2
        //  let middleY = middleScreenY - 200
        
        //    print("Min Session - Rate Me = \(iMinSessions)")
        //     print("Try again session - rate me = \(iTryAgainSessions)")
        
        self.TurnsAvailableLBL.layer.cornerRadius = 20
        self.ProfileImage.layer.cornerRadius = 5
        self.TurnsAvailableLBL.layer.masksToBounds = true
        let five:CGFloat = 5
        
        
       // VolumeMute = prefs.boolForKey("MuteGameAudio")
        
        
       // PlayBackgroundMusic()
        
        //HERE WE LOG INTO GAME CENTER
        
        
        
        self.NotfirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
        
        print("First Launch VIEW WILL APPEAR = \(self.NotfirstLaunch)")
        
        if self.NotfirstLaunch {
        
        IsPlayerLoggedIn = self.LogIntoGameCenter()
            
        }
        
        //     })
        
        
        
        DispatchQueue.main.async(execute: {
            
            
            if self.revealViewController() != nil {
                self.menuButton.target = self.revealViewController()
                self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
            
            
            
            print("UserName Confirmed = \(self.player)")
            
            self.NotfirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
            
            if self.NotfirstLaunch {
                print("Not First Launch")
                self.ShowSettingsNotice = true
                
            } else {
                print("First Launch, setting NSUserDefault")
                self.ShowSettingsNotice = false
                
            }
            
            
        })
        
        
        //   }
        defaultCFUN = prefs.bool(forKey: "DEFAULTCFUN")
        
        
        if Reachability.isConnectedToNetwork() {
        if !defaultCFUN {
            prefs.set(true, forKey: "MuteGameAudio")
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/ComedicFun.mp3", name: "/ComedicFun.mp3")
        }
        }
        
        let urlpath = dirpath.stringByAppendingPathComponent("ComedicFun.mp3") as String
        url = URL(fileURLWithPath: urlpath)
        
        
        VolumeMute = prefs.bool(forKey: "MuteGameAudio")
        
        PlayBackgroundMusic()
        
    }
    func dobLBLAction(_ sender: UITapGestureRecognizer) {
        
       
        ProfileFirstNameTXT.resignFirstResponder()
        ProfileLastNameTXT.resignFirstResponder()
        
        view.endEditing(true)
        
        DispatchQueue.main.async(execute: {
            
             self.view.endEditing(true)
            
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
            
             DispatchQueue.main.async(execute: {
              self.view.endEditing(true)
            })
            
            
        } else {
            print("Game Title Changed begin true")
            
            
        }
        print("bottom textfieldchange1")
        
    })
    
        
    }
    
    
    /*
    func textFieldDidChangeBegin(textField: AnyObject) {
        
        print("textFieldChange1")
        
       // qbDoneBTN.hidden = false
        
        //EditingGameTitle = true
        print("Turned On EditingGameTitle")
        
         if !EditingDOB {
            
            ProfileSubmitBTN.enabled = false
            ProfileSkipBTN.enabled = false
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.dobView.center.y = self.dobView.center.y - 1000
            
            self.dobPickerTOP.constant = 200
            // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
            // self.QuoteLabelTop.constant = 50
            //   self.qbDoneBOTTOM.constant = self.QuoteBoxBottom.constant + 20
            
           // self.qbDoneBOTTOM.constant = -(self.view.frame.height) + 100
        })
        
            
        EditingDOB = true
       
            
            
        } else {
            print("Game Title Changed begin true")
           
            
        }
        print("bottom textfieldchange1")
    }
    */
    
    /*
    func textFieldDidChangeEnd(textField: UITextField) {
        
        //qbDoneBTN.hidden = true
        
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            // self.QuoteBoxBottom.constant = keyboardFrame.size.height + 20
            // self.QuoteLabelTop.constant = 50
            //self.qbDoneBOTTOM.constant = -100
        })
        
        
        
        if EditingDOB {
            print("Game Title Changed end true")
           
            
        } else {
            
            
        }
    }
    
    */
    
    func dismissPicker ()
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
            
            self.dobnewLBL.text = dateFormatter.string(from: self.dobPicker.date)
            self.dobnewLBL.textColor = UIColor.black
            
           // self.selectedDate.setTitle(dateFormatter.stringFromDate(self.picker.date), forState: UIControlState.Normal)
            
            
        })
         
            ProfileSubmitBTN.isEnabled = true
            ProfileSkipBTN.isEnabled = true
            
           EditingDOB = false
            
        }
    }
    
    @IBAction func doItLaterBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.GameCenterErrorHolder.center.y = self.GameCenterErrorHolder.center.y + 1050
            self.GCErrorViewTOP.constant = 1000
        })
        
    }
  
    
    override func viewWillAppear(_ animated: Bool) {

        self.IsGameCenter = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
        
        self.NotfirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
        
        print("First Launch VIEW WILL APPEAR = \(self.NotfirstLaunch)")
        
        if self.NotfirstLaunch {
            
            //let LevelUpTime = GetLevelTokens(self.welcometxt, userid: self.myID, action: "get")
            
             let ProfileSet = UserDefaults.standard.bool(forKey: "ProfileSet")
            
            if !ProfileSet {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let GCReadyTwo = UserDefaults.standard.bool(forKey: "GameCenterEnabled")
                    
                    if !GCReadyTwo {
                        
                        // if self.user == "" {
                        print("User is still blank")
                        
                    } else {
                        
                        self.actIndTwo.isHidden = true
                        self.actIndTwo.stopAnimating()
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.menuButton.isEnabled = false
                            self.revealViewController().panGestureRecognizer().isEnabled = false
                            
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
                
            }
            
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
       // }
        
            
            ///NEW IF FIRST LAUNCH ADDED ABOVE
            
        if !self.IsPlayerLoggedIn {
            
            //print("Player is not logged in")
            
             print("game center not enabled, ViewWillAppear")
            
           // let AC = JSController("Game Center", MyMessage: "Please make sure you are logged into Game Center to continue.",Color: "Green")
            if !self.IsGameCenter {

            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "Please make sure you are logged into the Game Center.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
          //  self.presentViewController(AC, animated: true, completion: nil)
            
            }
            
        } else {
  
     }
        
    }
     //   EasyGameCenter.sharedInstance(self)
    
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !ShowingProfileView {
        
        print("Pre Que - View Did Appear, Game Center enabled = \(gameCenterEnabled)")
        
        DispatchQueue.main.async(execute: {
            
            print("Main Que - View Did Appear, Game Center enabled = \(self.gameCenterEnabled)")
            
            //  })
            

            if (self.prefs.value(forKey: "deviceToken") != nil)  {
                self.token  = self.prefs.value(forKey: "deviceToken") as! Data
                print("deviceToken not nil")
                print("token = \(self.token)")
            } else {
                print("DeviceToken IS nil")
            }
            
            
            DispatchQueue.main.async(execute: {
                
                
                self.LoadingItems()
                
                // }
                
            })
            
        })
        
        if StartedAGame {
            
            DispatchQueue.main.async(execute: {
                self.NewGameStarted()
            })
            
        }
    }
        
       let defaultVideo = prefs.bool(forKey: "DEFAULTSAVEDvideo")
        let defaulttada = prefs.bool(forKey: "DEFAULTSAVEDtada")
        let defaultjoy = prefs.bool(forKey: "DEFAULTSAVEDjoy")
        let defaultplease = prefs.bool(forKey: "DEFAULTSAVEDplease")
        let defaultmetroid = prefs.bool(forKey: "DEFAULTSAVEDmetroid")
        
        let defaultdoorbell = prefs.bool(forKey: "DEFAULTSAVEDdoorbell")
        
        if Reachability.isConnectedToNetwork() {
        
        if !defaultVideo {
            print("IS SAVING DEFAULT VIDEO")
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQTempMusic3.m4v", name:"/PQTempMusic4.m4v")
            
        }
        
        if !defaulttada {
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/tada.caf", name: "/tada.caf")
        }
        
        }
        /*
        if !defaultjoy {
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/joy.caf", name: "/joy.caf")
        }
        
        if !defaultplease {
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/please.caf", name: "/please.caf")
        }
        
        if !defaultmetroid {
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/metroid.caf", name: "/metroid.caf")
        }
        
        if !defaultdoorbell {
            SaveVideo("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/doorbell.caf", name: "/doorbell.caf")
        }
*/
        
        VolumeMute = prefs.bool(forKey: "MuteGameAudio")
        
        PlayBackgroundMusic()
        
}
    
   /*
    func easyGameCenterAuthentified() {
        print("\nPlayer Authentified\n")
    }
  */
    
    func LoadingItems() {
        
        print("STARTING LOADING ITEMS FUNCTION")
        
        //   let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        
        if NotfirstLaunch {
            print("Not First Launch")
            
            
        } else {
            print("First Launch, setting NSUserDefault")
            // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            
            //self.performSegueWithIdentifier("goto_login", sender: self)
            
            //    self.performSegueWithIdentifier("First_Load", sender: self)
            
            if !PQExplained {
                
                //  var url : NSURL = NSBundle.mainBundle().URLForResource("PixieWaving", withExtension: "gif")!
                
                //  PixieWavingView.image = UIImage.animatedImageWithAnimatedGIFURL(url)
                
                
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    
                    //UNCOMMENT TO SHOW PIXIE
                    self.ViewWelcomeHolder.center.y = self.ViewWelcomeHolder.center.y - 1050
                    
                    self.ViewWelcomeHolderTOP.constant = -50
                    
                    self.menuButton.isEnabled = false
                    self.helpBTN.isEnabled = false
                    self.revealViewController().panGestureRecognizer().isEnabled = false
                    
                })
            }
            
        }
        
        
        if !self.AlreadyLoaded {
            
            let neverRate = self.prefs.bool(forKey: "neverRate")
            print("neverRate = \(neverRate)")
            
            
            // let currentNumLaunches = prefs.integerForKey("numLaunches")
            
            let numLaunches
            = self.prefs.integer(forKey: "numLaunches") + 1
            
            print("Number of Launches = \(numLaunches)")
            
            
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                //    self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y - 1000
                
                //    self.ViewLoadHolderTOP.constant = 0
                
            })
            
            //  self.user = GameLogin()
            
            self.rateMe()
            
        }
        
        
        print("Player confirmed again in viewDidAppear \(player)")
        
        
        //user = GameLogin()
        
        
        DispatchQueue.main.async(execute: {
            
            
            
            if (self.prefs.value(forKey: "USERNAME") != nil)
            {
                self.welcometxt = (self.prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                print("USERNAME not nil")
                //   myID = prefs.valueForKey("PLAYERID") as! NSString as String
                print("Myid = \(self.userID)")
                self.usernameLabel.text = ("Welcome back \(self.welcometxt)")
            } else {
                self.usernameLabel.text = ("No User Signed In")
            }
            
            print("logged in user: \(self.welcometxt)")
            
            self.NewLikesArray.removeAll()
            self.GameIDArray.removeAll()
            
            
            
            
            // let progressHUD = ProgressHUD(text: "Loading Game Data")
            //  self.view.addSubview(progressHUD)
            
            
            //self.view.addSubview(self.SaveProgressHUD)
            
            //dispatch_async(dispatch_get_main_queue
            
            
            
            //     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            
            
            
            /*
            UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            
            self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y - 1000
            
            self.ViewLoadHolderTOP.constant = 0
            
            })
            */
            
            
            if !self.AlreadyLoaded {
                
                self.ActInd.startAnimating()
                
                
                if Reachability.isConnectedToNetwork() {
                    
                    SyncVisitDate(self.welcometxt)
                    
                    if (self.prefs.value(forKey: "PLAYERID") != nil)       {
                        print("PlayerID is not nil")
                        
                        self.myID = (self.prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
                        
                        
                        
                        UIView.animate(withDuration: 1.0, animations: { () -> Void in
                            
                            
                            self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y - 1000
                            
                            self.ViewLoadHolderTOP.constant = 0
                            
                        })
                        
                        //CREATES USER HERE
                        DispatchQueue.main.async(execute: {
                            
                        self.CreateUserNow()
                        
                        })

                    }
                    
                    self.AlreadyLoaded = true
                    
                }
                else
                {
                    

                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                }
                DispatchQueue.main.async(execute: {
                    self.ActInd.stopAnimating()
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y + 1000
                        
                        self.ViewLoadHolderTOP.constant = 1000
                        
                    })
                    // GetLevelTokens(self.welcometxt, userid: self.myID, action: "get")
                    
                    self.mygamesBTN.isEnabled = true
                    
   
                })
                
                
            }
            
        })
        //});
        
        let RecNot = self.prefs.bool(forKey: "RECNOT")
        
        
        let NotifyOn = self.prefs.bool(forKey: "NOTIFYISON")
        
        
        if !RecNot {
            print("notifications are turned off")
            
            
            
            var numLaunchesSettings = prefs.integer(forKey: "numLaunchesSettings") + 1
            
            print("Num of Launch Setings = \(numLaunchesSettings)")
            
            if (numLaunchesSettings == iMinSessionsSettings || numLaunchesSettings >= (iMinSessionsSettings + iTryAgainSessionsSettings + 1 )) {
                
             

            
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert =  SCLAlertView()
                theAlert.addButton("Settings", action: {
                    
                    let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                    //   let settingsUrl = NSURL(string: UIAppli)
                    if let url = settingsUrl {
                        UIApplication.shared.openURL(url)
                    }
                    
                    
                })
                
                theAlert.showCustomOK(UIImage(named: "settingsWhite2.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Notifications", subTitle: "Turn on your notifications for a better game experience", duration: nil, completeText: "I'll fix later", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
            
            
            
            if self.ShowSettingsNotice {
  
                DispatchQueue.main.async(execute: {
                    
                    
                    let theAlert =  SCLAlertView()
                    theAlert.addButton("Settings", action: {
                        
                        let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                        //   let settingsUrl = NSURL(string: UIAppli)
                        if let url = settingsUrl {
                            UIApplication.shared.openURL(url)
                        }
                        
                        
                    })
                    
                    theAlert.showCustomOK(UIImage(named: "settingsWhite2.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Notifications", subTitle: "Turn on your notifications for a better game experience", duration: nil, completeText: "I'll fix later", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
                
                
                
                
            } else {
                
                if !NotifyOn {
                    if self.ShowSettingsNotice {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let theAlert =  SCLAlertView()
                            theAlert.addButton("Settings", action: {
                                
                                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                                //   let settingsUrl = NSURL(string: UIAppli)
                                if let url = settingsUrl {
                                    UIApplication.shared.openURL(url)
                                }
                                
                                
                            })
                            
                            theAlert.showCustomOK(UIImage(named: "settingsWhite2.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Notifications", subTitle: "Turn on your notifications for a better game experience", duration: nil, completeText: "I'll fix later", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
                        
                    }
                }
                
            }
            
        
            
            numLaunchesSettings = iMinSessionsSettings + 1
        }
            
       
        
            prefs.set(numLaunchesSettings, forKey: "numLaunchesSettings")
            print("Number of Launches = \(numLaunchesSettings)")
            
            
        }
        
        
        DispatchQueue.main.async(execute: {
       
            if let viewControllers = self.navigationController?.viewControllers {
                print("view controller is navigation controller")
                for viewController in viewControllers {
                    if viewController.isKind(of: ViewController.self) {
                        print("is kind of class")
                        
                         self.theShortCut()
                        //self.GoToMyGames()
                        
                    }
                }
            }
            
            
           
        })
        
        RemindPoints()
        
  

    }
    
    func CreateUserNow(){
        DispatchQueue.main.async(execute: {
            
            
            let Token = self.token
            let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
            let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
            let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
            
            print("About to Confirm or Create User")
            self.ConfirmOrCreateUser(self.welcometxt as String, UserID: self.myID as String, Token: TokenNew)
            
            DispatchQueue.main.async(execute: {
                
                
                
                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
                    
                    //  let LevelUpTime = GetLevelTokens(self.welcometxt, userid: self.myID, action: "get")
                    
                    //   print("level up time = \(LevelUpTime)")
                    
                    print("Done Getting Toeksn and Level")
                    
                })
                
                
                //GETTING LIKES AND TURN INFO
                let URLTurns = AvailableTurnsData(self.welcometxt, userID: self.myID)
                
                self.GameIDArray = self.FilterIDData(URLTurns)
                
                
                
                //var GamesCount = GameIDArray.count
                
                if self.GameIDArray.count == 0 {
                    self.TurnsAvailableLBL.isHidden = true
                    print("No Turns Available")
                } else {
                    
                    self.TurnsAvailableLBL.text = "\(self.GameIDArray.count)"
                    
                }
                
                self.heartViewLBL.text = self.Total_Likes.description
                
                if self.Total_Likes == 0 {
                    self.heartView.isHidden = true
                } else {
                    self.heartView.isHidden = false
                    
                }
                
                print("Should show heart")
                
                UIView.animate(withDuration: 1.5, animations: {
                    self.TurnsAvailableLBL.center.y = (self.TurnsAvailableLBL.center.y + 700)
                    
                    // self.TurnsAvailableLBL.center.y = (self.TurnsAvailableLBL.center.y - 50)
                    
                    //  self.TurnsAvailableLBL.center.y = (self.TurnsAvailableLBL.center.y + 50)
                    self.TurnsAvailableTOP.constant = -10
                    //self.TurnsAvailableTOP.constant = -60
                    //self.TurnsAvailableTOP.constant = -10
                })
                
                
                UIView.animate(withDuration: 1.5, animations: {
                    self.heartView.center.y = (self.heartView.center.y + 700)
                    
                    // self.TurnsAvailableLBL.center.y = (self.TurnsAvailableLBL.center.y - 50)
                    
                    
                    self.heartTOP.constant = -10
                    //self.TurnsAvailableTOP.constant = -60
                    //self.TurnsAvailableTOP.constant = -10
                })
                
                self.numPoints = 0;
                //UNCOMMENT SOME WHERE ELSE (BELOW)
                //   numPoints = UPData(self.welcometxt, userid: self.myID, type: "get", points: "0")
                
                // numPoints = FilterUPData(UPurldata)
                print("number of points = \(self.numPoints)")
                
                
            })
        })
    }
    
    
    func LogIntoGameCenter() -> Bool {
        
        print("Logging into game center")
        var gameCenterEnabled2 = Bool()
        
        //REVIEW BELOW
      //  var localPlayer = getLocalPlayer() // see GKLocalPlayerHack.h
        
        
        print("Local Player = \(localPlayer)")
        print("GCError ViewShowing = \(GCErrorViewShowing)")
        
        
        localPlayer.authenticateHandler =
            { (viewController : UIViewController?, error : Error?) -> Void in
                if viewController != nil
                {
                    print("should present ViewController for Game Center")
                    self.present(viewController!, animated:true, completion: nil)
                }
                else
                {
                    
                    /*
                    
                    print("Local Player Auth = \(localPlayer.authenticated)")
                    
                    if localPlayer.playerID == nil {
                        print("the player ID is nil")
                    
                        self.presentViewController(viewController!, animated:true, completion: nil)

                    } else {
                        print("player ID = \(localPlayer.playerID)")
                    }
                    */
                    
                    
                    
                    if self.localPlayer.isAuthenticated
                    {
                       // print("GCErrorViewShowing = \(self.GCErrorViewShowing)")
                        
                        
                        if self.GCErrorViewShowing {
                            
                      UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        self.GameCenterErrorHolder.center.y = self.GameCenterErrorHolder.center.y + 1050
                        self.GCErrorViewTOP.constant = 1000
                        })
                            
                        self.menuButton.isEnabled = true
                        self.helpBTN.isEnabled = true
                        self.revealViewController().panGestureRecognizer().isEnabled = true
                        self.GCErrorViewShowing = false

                        }
                        
                        gameCenterEnabled2 = true
                        self.gameCenterEnabled = true
                        UserDefaults.standard.set(true, forKey: "GameCenterEnabled")
                       // self.PlayerIsLoggedInToGameCenter = true
                        
                        print("GameCenter Enabled = \(self.gameCenterEnabled)")
                        
                        
                        //self.player = localPlayer.displayName
                        self.playerid = self.localPlayer.playerID! as NSString
                        self.player = self.localPlayer.alias! as NSString
                        
                        print("player: \(self.player)")
                        print("playerid: \(self.playerid)")
                        
                        var sameuserTest = false
                        
                        if (self.prefs.value(forKey: "USERNAME") != nil) {
                            if (self.player.description == (self.prefs.value(forKey: "USERNAME") as AnyObject).description) {
                                sameuserTest = true
                            } else {
                                sameuserTest = false
                            }
                        }
                        
                        
                        print("SETTING COREDATA FOR PLAYER NAME AND ID")
                        self.prefs.setValue(self.player, forKey: "USERNAME")
                        let PlayerIDEdit = self.playerid.replacingOccurrences(of: ":", with: "")
                        
                        self.prefs.setValue(PlayerIDEdit, forKey: "PLAYERID")
                        //self.prefs.setValue(self.playerid, forKey: "PLAYERID")
                        
                        
                        self.usernameLabel.text = ("Welcome back \(self.player)")
                        
                        
                        self.welcometxt = (self.prefs.value(forKey: "USERNAME") as! NSString) as NSString
                        self.userID = (self.prefs.value(forKey: "PLAYERID") as! NSString) as NSString

                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            
                            let Token = self.token
                            let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
                            let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
                            let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
                            
                            print("About to Confirm or Create User FROM LOG INTO GAME CENTER")
                            self.ConfirmOrCreateUser(self.welcometxt as String, UserID: self.userID as String, Token: TokenNew)
                            
                            
                            
                       //     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
     
                                
                                self.NotfirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
                            
                            print("First Launch Before Tokens = \(self.NotfirstLaunch)")
                            
                                if self.NotfirstLaunch {
                                    
                                    if Reachability.isConnectedToNetwork() {
                                    
                                
                                  let LevelUpTime = GetLevelTokens(self.welcometxt, userid: PlayerIDEdit as NSString, action: "get")
                                    
                                    UserDefaults.standard.set(true, forKey: "FirstLaunch")

} else {

    
                                        DispatchQueue.main.async(execute: {
                                            
                                            
                                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Connection Error!", subTitle: "Check your network settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                                            
                                        })
                                        
                                        
}

                                }
                            
                            
                           //   NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
                                 //  numPoints = UPData(self.welcometxt, userid: self.myID, type: "get", points: "0")
                                
                               //  numPoints = FilterUPData(UPurldata)
                                
                                //   print("level up time = \(LevelUpTime)")
                                
                                print("Done Getting Tokens and Level Info")
                            
                                self.mygamesBTN.isEnabled = true
                                
                        //    })
                            
                        })
                        
                        /*
                        
                        
                        localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler
                            { (leaderboardIdentifier, error) -> Void in
                                if error != nil
                                {
                                    print("error")
                                }
                                else
                                {
                                    self.leaderboardIdentifier = leaderboardIdentifier
                                    print("\(self.leaderboardIdentifier)") //in your example "VHS" should be returned
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        */
                        
                    }
                    else
                    {
                        print("not able to authenticate fail")
                        gameCenterEnabled2 = false
                        //self.PlayerIsLoggedInToGameCenter = false
                        
                        if (error != nil)
                        {
                           // print("\(error!.description)")
                            print("SHould Show GCError View2")
                            
                            
                            if !self.GCErrorViewShowing {
                                
                                print("should be showing now")
                            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                                
                                
                                self.GameCenterErrorHolder.center.y = self.GameCenterErrorHolder.center.y - 1050
                                
                                self.GCErrorViewTOP.constant = -50
                                
                            })
                                
                                
                                self.menuButton.isEnabled = false
                                self.revealViewController().panGestureRecognizer().isEnabled = false
                                self.helpBTN.isEnabled = false
                                
                                self.GCErrorViewShowing = true
                            }

                            
                        }
                        else
                        {
                            print(    "error is nil")
                        }
                    }
                }
        }
        return gameCenterEnabled2
    }
    
    
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
        IsPlayerLoggedIn = LogIntoGameCenter()
        
        print("After GCVC Did Finish, is player logged in = \(IsPlayerLoggedIn)")
        
    }
        
        //UIColor(red: 0.99, green: 0.69, blue: 0.35, alpha: 1.0)
    //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
    //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
    //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)
    
    

    
    
    @IBAction func LikesInfoBTN(_ sender: AnyObject) {
        if Total_Likes == 0 {
    
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "likeButton.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Your Likes", subTitle: "No one has liked your turns yet...", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        } else {
   
            DispatchQueue.main.async(execute: {

                SCLAlertView().showCustomOK(UIImage(named: "likeButton.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Your Likes", subTitle: "Your Friends have Liked your work \(self.Total_Likes) times!", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
        }

    }
    
    func displayRemoteNotificationKeyDetails() {
        print("REMOTE NOTIFICATION KEY DETAILS")
    }
    
    func displayBackgroundDetails() {
        print("APP ENTERED THE BACKGROUND")
    }
    
    
    
    //func NewGameStarted(notification:NSNotification) {
    
    
     func NewGameStarted() {
        print("Received notice to start a new game")
   
        DispatchQueue.main.async(execute: {
            
            var numPoints = Int()
            var LevelUpTime = Bool()
            (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "0", levelpoints: "5")
            //numPoints = FilterUPData(UPurldata)
            print("number of points = \(numPoints)")

               // print("Ok button pressed")
  
                let theAlert =  SCLAlertView()
                theAlert.addButton("Ok", action: {
                    
                                    if LevelUpTime {
                    var PointsNew = NSInteger()
                    var LevelNew = NSInteger()
                    
                    (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.myID, type: "add", level: "1")
                    
                    DispatchQueue.main.async(execute: {
                        
                        let theAlert2 = SCLAlertView()
                        theAlert2.addButton("Ok", action: {
                            DispatchQueue.main.async(execute: {
                             NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
                            })
                        })
                        
                            theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Level \(LevelNew.description) - Level Up!", subTitle: "You just got a Level up on your Pixie!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })

                    
                }
                })
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You just earned 5 Pixie points for starting a new game!", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })

        
    }
    
    
    func displayLaunchDetails() {
        
        //var window: UIWindow?
        /*
        if let viewControllers = self.navigationController?.viewControllers {
            
            for viewController in viewControllers {
                if viewController.isKindOfClass(MyGamesViewController) {
                    print("is on my games view controller, refresh my games")
                } else {
                    //   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                    print("Not on My Games ViewController")
                }
            }
        } else {
            print("else showing")
            
          
        }
        */
        
       // let storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let vc = storyboard.instantiateViewControllerWithIdentifier("start") as! UIViewController

       // self.presentViewController(vc, animated: false, completion: nil)

       // navigationController?.popToRootViewControllerAnimated(true)
        
        var URLGameID: NSString!
        var URLTurn: NSString!
        var URLName: NSString!
        
        
       // if self.window.rootViewController is ViewController {
        
       // }
        
        if delegate.scheme != nil {
            //print("deleg")
         
            
            print("scheme scheme: \(delegate.scheme)")
            
            if delegate.scheme == "file" {
                
                ImportedFileURL = delegate.path as NSString
                
                if ImportedFileURL.hasSuffix("mp3") || ImportedFileURL.hasSuffix("wav") {
                   
                    print("file is a mp3")
                     NotificationCenter.default.post(name: Notification.Name(rawValue: "ImportedFileType"), object: nil, userInfo: ["data":self.ImportedFileURL, "type":"audio"]);
                    
                    self.performSegue(withIdentifier: "SuggestedNewGame", sender: self)

                    
                }
                
                
                if ImportedFileURL.hasSuffix("png") || ImportedFileURL.hasSuffix("jpeg") || ImportedFileURL.hasSuffix("jpg") {
                    
                    print("file is an image")
                     NotificationCenter.default.post(name: Notification.Name(rawValue: "ImportedFileType"), object: nil, userInfo: ["data":self.ImportedFileURL, "type":"picture"]);
                    
                    self.performSegue(withIdentifier: "SuggestedNewGame", sender: self)

                    
                }

                /*
                var recordings = files.filter( { (name: String) -> Bool in
                    
                    /*
                    if name.containsString("tempTYAudio") {
                    print("Path containts tempTYAudio")
                    return false
                    } else {
                    */
                    return name.hasSuffix("m4a")
                    // }
                })
*/
                
            } else {
            
            if delegate.scheme == "fb669563119812230" {
                
            } else {
            
            let URLQuery = delegate.nsurl.queryDictionary
            //let URLGameID = URLQuery["gameid"]
            URLGameID = URLQuery?["gameid"]?.first as NSString!
            URLTurn = URLQuery?["turn"]?.first as NSString!
            URLName = URLQuery?["name"]?.first as NSString!
            print("URLTurn: \(URLTurn!)")
            print("URLGameID: \(URLGameID!)")
            
            /*
            if let queryString = delegate.nsurl.getKeyVals() {
                println("Query String: \(queryString)")
            }
*/
            
                
       // }
        if delegate.path != nil {
            print("scheme path: \(delegate.path)")
            
            if (delegate.path == "/FirstInvite"){
            self.performSegue(withIdentifier: "FirstGame_Invite", sender: self)
                
                
            }
            
            if (delegate.path == "/EmailInvite"){
               // self.performSegueWithIdentifier("FirstGame_Invite", sender: self)
                print("New Game Alert")
                
                let URLQuery = delegate.nsurl.queryDictionary
                //let URLGameID = URLQuery["gameid"]
                //let URLGameID = URLQuery?["gameid"]?.first
               // let URLTurn = URLQuery?["turn"]?.first
                print("URLTurn: \(URLTurn!)")
                print("URLGameID: \(URLGameID!)")
                print("URLQuery NEW GAME: \(URLQuery)")
                
                
                  DispatchQueue.main.async(execute: {
                self.NewGameAlert(URLGameID, turn: URLTurn)
                })
            }
            
            
        }
        if delegate.query2 != nil {
            print("scheme query: \(delegate.query2)")
            
            let URLQuery = delegate.nsurl.queryDictionary
            //let URLGameID = URLQuery["gameid"]
            let URLGameID = URLQuery?["gameid"]?.first
            let URLTurn = URLQuery?["turn"]?.first
            print("URLTurn: \(URLTurn!)")
            print("URLGameID: \(URLGameID!)")
            }
          }
        }
            
        }
        
        print("APP ENTERED FOREGROUND FROM VIEW CONTROLLER")
        
        DispatchQueue.main.async(execute: {
        
        let RecNot = self.prefs.bool(forKey: "RECNOT")
        
        
        let NotifyOn = self.prefs.bool(forKey: "NOTIFYISON")
        
        
        if !RecNot {
            print("notifications are turned off")
            
            if self.ShowSettingsNotice {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let theAlert =  SCLAlertView()
                    theAlert.addButton("Settings", action: {
                        
                        let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                        //   let settingsUrl = NSURL(string: UIAppli)
                        if let url = settingsUrl {
                            UIApplication.shared.openURL(url)
                        }
                        
                        
                    })
                    
                    theAlert.addButton("Later", action: {
                        
                        let numLaunchesSettings = 0
                        
                        self.prefs.set(numLaunchesSettings, forKey: "numLaunchesSettings")
                        
                    })
                    
                    theAlert.showCustomOK(UIImage(named: "settingsWhite2.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Notifications", subTitle: "Turn on your notifications for a better game experience", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                /*
                let alertController = UIAlertController (title: "Notifications", message: "Looks like your Push Notifications are turned off, turn them on for a better game experience", preferredStyle: .Alert)
                
                let settingsAction = UIAlertAction(title: "Settings", style: .Default) { (_) -> Void in
                    let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                    //   let settingsUrl = NSURL(string: UIAppli)
                    if let url = settingsUrl {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                alertController.addAction(settingsAction)
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true, completion: nil);
                */
            }
            
        } else {
            
            if !NotifyOn {
                if self.ShowSettingsNotice {
                    
                    print("notifications are turned off")
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        let theAlert =  SCLAlertView()
                        theAlert.addButton("Settings", action: {
                            
                            let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                            //   let settingsUrl = NSURL(string: UIAppli)
                            if let url = settingsUrl {
                                UIApplication.shared.openURL(url)
                            }
                            
                            
                        })
                        
                        theAlert.addButton("Later", action: {
                            
                            let numLaunchesSettings = 0
                            
                            self.prefs.set(numLaunchesSettings, forKey: "numLaunchesSettings")
                            
                        })
                        
                        theAlert.showCustomOK(UIImage(named: "settingsWhite2.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Notifications", subTitle: "Turn on your notifications for a better game experience", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                   
                    
                }
            }
            
        }
        
        
    })
    
        
     DispatchQueue.main.async(execute: {
        self.theShortCut()
        })
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destination = segue.destinationViewController as? LoginViewController {
            //destination.NameInfo = NameInfo
            destination.player = player
            destination.playerid = playerid
            destination.dt = token
            
        }

    }

*/
    
  
    func AddToGameMemebers() {
        
       // override func vi
       deviceToken = prefs.value(forKey: "deviceToken") as! Data
        
        print("User's name is \(user)")
        print("VC Device Token: \(deviceToken)")

        //prefs.valueForKey("USERNAME") as! NSString as String
        
              // let DT = NSString(data: delegate.DT, encoding: NSUTF8StringEncoding)
        
        ///////////////
        var password:NSString = "test123"
        /*
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            println("You are NOT logged in")
            // self.performSegueWithIdentifier("goto_login", sender: self)
            SearchForMember(user as String, PlayerID: playerid as String)
            
        } else {
            println("You ARE logged in")
            
            SearchForMember(user as String, PlayerID: playerid as String)
            
        }
        */
        
      //  MergeWithGameMembers(user as String, password: password as String, Token: deviceToken as String, PlayerID: playerid as String)
        
       // SearchForMember(user as String, PlayerID: playerid as String)
       
    
    }
    
    func ConfirmOrCreateUser(_ user: String, UserID: String, Token: String) {

        print("CREATE USER \(user)")
        print("CREATE USERID \(UserID)")
        print("CREATE TOKEN \(Token)")
        
        
     self.SearchForMember(user, PlayerID: UserID)

    }
    
    func GameLogin () -> NSString {
        print("login called")
        //localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController: UIViewController?, error: Error?) -> Void in
            if ((ViewController) != nil) {
                print("VC True")
                self.present(ViewController!, animated: true, completion: nil)
            
            
            } else if self.localPlayer.isAuthenticated {
                self.gcEnabled = true
                print("Player authenticated")
                
                //self.player = localPlayer.displayName
                self.playerid = self.localPlayer.playerID! as NSString
                self.player = self.localPlayer.alias! as NSString
                
                print("player: \(self.player)")
                print("playerid: \(self.playerid)")
                
                var sameuserTest = false
                
                if (self.prefs.value(forKey: "USERNAME") != nil) {
                if (self.player.description == (self.prefs.value(forKey: "USERNAME") as AnyObject).description) {
                    sameuserTest = true
                } else {
                    sameuserTest = false
                }
                }
                
                self.prefs.setValue(self.player, forKey: "USERNAME")
                let PlayerIDEdit = self.playerid.replacingOccurrences(of: ":", with: "")
                
                self.prefs.setValue(PlayerIDEdit, forKey: "PLAYERID")
                //self.prefs.setValue(self.playerid, forKey: "PLAYERID")
                
                
                self.usernameLabel.text = ("Welcome back \(self.player)")
                
                
                self.welcometxt = (self.prefs.value(forKey: "USERNAME") as! NSString)
                self.userID = (self.prefs.value(forKey: "PLAYERID") as! NSString)
                        
                self.PlayerIsLoggedInToGameCenter = true
                        
                UserDefaults.standard.set(true, forKey: "GameCenterEnabled")
                 //   print("GAME CENTER IS NOW ENABLED 2"),
                    //boolForKey("GameCenterEnabled")
                
                //var GCFriends = [NSString]()
                
                if self.localPlayer.isAuthenticated {
                    
                    
                
                self.localPlayer.loadFriendPlayers(completionHandler: { (GCFriends) -> Void in
                    print("TEST")
                    print("GCFriend = \(GCFriends)")
                    var myFriend = GCFriends.0
                    
                  //  print("my friend is \(testFriend)")
                   
                    if self.localPlayer.isAuthenticated {
                    for myFriend in GCFriends.0! {
                        
                    
                   // var myFriend = myFriend?.first
                    print("my friend ID = \(myFriend.playerID)")
                    print("my friend alias = \(myFriend.alias)")
                    print("my friend name = \(myFriend.displayName)")

                    }
                    /*
                    for myFriend in GCFriends[0] {
                    let FriendID = GCFriends[0]["playerID"]
                    let FriendAlias = GCFriends[0]["alias"]
                        
                    }
*/
                    }
                })
                    
                    if self.TryAgain {
                        
                      
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                           let theAlert =  SCLAlertView()
                            theAlert.addButton("Ok", action: {
                                
                                
                                DispatchQueue.main.async(execute: {
                               self.ShowIDViewNow()
                                })
                                
                            })
                            
                            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "All Set!", subTitle: "Let's create your ID", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        
                    }
                    
                    
                } else {
                    print("Game Center Player Not Authenticated")
                }
                print("searching: matching Gamecenter player to player database")
                
                
                

                    
                    if sameuserTest {
                        print("SameuserTest: Same user is playing")
                        
                     //SEARCHING FOR MEMBER IN DATA BASE
                    print("SEARCHING FOR MEMBER NOW!!!!!!")
                        
                    self.SearchForMember(self.player as String, PlayerID: self.playerid as String)
  
                    } else {
                  
                     print("SameuserTest: New User is playing")
                        
                    print("SEARCHING FOR new MEMBER NOW!!!!!!")
                    self.SearchForMember(self.player as String, PlayerID: self.playerid as String)

                }

                    
                    
                
        } else {
            self.gcEnabled = false
                print("Local player could not be authenticated, disabling game")
                print("Authentifcate error: \(error)")
                print("Player NOT authenticated")
                
                //self.player = ""
                
                
         
            }
            
        }
        return player
    }
    

    
    @IBAction func NewGame(_ sender : UIButton) {
        
        //AddToGameMemebers()

        self.performSegue(withIdentifier: "select_newgame", sender: self)
    }
    
 
    @IBAction func GoToFriends(_ sender : UIButton) {
        
        print("Go To My Friends")
        
       
        self.performSegue(withIdentifier: "goto_friends", sender: self)
    }
    
        // Do any additional setup after loading the view, typically from a nib.
    
    func SearchForMember (_ PLAYER: String, PlayerID: String) {
        print("search for Member")
        password = "test123"
        // username.stringByReplacingOccurrencesOfString(" ", withString: "")
        let PlayerID2 = PlayerID.replacingOccurrences(of: ":", with: "")
        let Token = token
        let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
        print("TokenNew = \(TokenNew)")
        let user = self.localPlayer.alias
        
       // let post:NSString = "username=\(user)&password=\(password)&c_password=\(password)"
        
        let post:NSString = "username=\(PLAYER)&password=\(password)&c_password=\(password)&token=\(TokenNew)&playerid=\(PlayerID2)" as NSString
        
        //NSLog("PostData: %@",post);
        print("Searching for Player in TP database - TPLogin Query")
        
        let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TelePictionaryLogin.php")!
        
        print("URL entered")
        
        let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
        
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
                
              //  var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
                //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                    //NSLog("Member Found - Success");
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                   // prefs.setObject(user, forKey: "USERNAME")
                    
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                    Email = jsonData.value(forKey: "email") as! NSString
                    
                    let isFun = jsonData.value(forKey: "isFun") as! NSString
                    
                    prefs.setValue(isFun, forKey: "ISFUN")
                    
                    prefs.setValue(Email, forKey: "EMAIL")
                    
                    prefs.setValue(user, forKey: "USERNAME")
                    prefs.setValue(PlayerID2, forKey: "PLAYERID")
                    
             self.ViewLoad1MSG.text = "Member found..."                    
                    //MEMBER FOUND
                    /*
                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                        
                        
                        self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y + 1000
                        
                        self.ViewLoadHolderTOP.constant = 1000
                        
                    })
   */
                    
                    
                } else {
                    var error_msg:NSString
                    
                    print("Merging with Game Members: Token - \(token), player - \(PLAYER) ")
                    
                   // prefs.setValue(PLAYER, forKey: "USERNAME")
                    
                  //  MergeWithGameMembers(PLAYER as String, password: password as String, Token: token, PlayerID: playerid as String)
                    
                   // View1TOPP.constant = 0
                   // View2TOP.constant = 0
                    
                    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
                    
                    UIView.transition(from: self.ViewLoad1, to: self.ViewLoad2, duration: 0.8, options: animationOptions, completion: nil)
                    
                    
                    //CREATE NEW MEMBER
                    
                    MergeWithGameMembers(PLAYER as String, password: password as String, Token: token, PlayerID: PlayerID2 as String as NSString)
                    
                    
                }
                
            } else {
                /*
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Pics & Quotes!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                */
                
                DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                })
                
            }
        } else {
            /*
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Pics & Quotes!"
            alertView.message = "Connection Failure"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            */
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        }
    }
    
    
    
    func MergeWithGameMembers (_ username: String, password: String, Token: Data, PlayerID: NSString) {
        
        
        let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        let TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
   
        
        
        let tempemail = "test123@\(ServerInfo.sharedInstance)"
        let privacy = "no"
        
        print("Token - Spaces Removed: \(TokenNew)")
        
        let post:NSString = "username=\(username)&password=\(password)&token=\(TokenNew)&playerid=\(PlayerID)&email=\(tempemail)&privacy=\(privacy)" as NSString
        
        
        //NSLog("PostData: %@",post);
        
        let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TelePictionarySignup.php")!
        
        print("URL entered")
        
        let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
        
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
            
         //   //NSLog("Response code: %ld", res?.statusCode);
            
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                
                //NSLog("Response ==> %@", responseData);
                
            //    var error: NSError?
                
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
                //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                    //NSLog("MERGE With Game Database - SUCCESS");
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                    //prefs.setObject(username, forKey: "USERNAME")
                    
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                    //Email = jsonData.valueForKey("email") as! NSString
                    
                    prefs.setValue(Email, forKey: "EMAIL")
                    
                    prefs.setValue(username, forKey: "USERNAME")
                    prefs.setValue(PlayerID, forKey: "PLAYERID")
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.ViewLoadHolder.center.y = self.ViewLoadHolder.center.y + 1000
                        
                        self.ViewLoadHolderTOP.constant = 1000
                        
                    })
                    //  self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    
                    
                    
                    var error_msg:NSString
                    
                    
                    if jsonData["error_message"] as? NSString != nil {
                        error_msg = jsonData["error_message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Pics & Quotes!"
                    //alertView.message = "Sign in Error"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                  //  alertView.show()
                    
                }
                
            } else {
                /*
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                //alertView.show()
                */
                DispatchQueue.main.async(execute: {
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            }
        } else {
            /*
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Unable to Match GameCenter Username"
            alertView.message = "Please check your internet connection if you would like to play with your friends remotely"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
           // alertView.show()
            */
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        }
    }
    
    func NewGameAlert(_ gameid: NSString, turn: NSString) {
        
        
        DispatchQueue.main.async(execute: {
            
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Accept Invite", action: {
                print("Settings pushed")
                
                let mergeResult = MergeWithGame(gameid, username: self.player, turninfo: turn, status: "accept", userID: self.userID)
                if mergeResult == "yes" {
                    print("Sync Complete")
                    
                    let AC = JSController("Game Accepted", MyMessage: "You have accepted this Game Invite.  You will be notified when it's your turn.",Color: "Green")
                   // self.presentViewController(AC, animated: true, completion: nil)
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Game Accepted", subTitle: "You will be notified when it's your turn", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                      
                            
                            DispatchQueue.main.async(execute: {
                                self.dismiss(animated: false, completion: nil)
                                print("DISMISSING THE HARD ALERT SCREEN")
                            })
                       
                        
                    })
                    
                    
                } else {
                    print("Sync Incomplete")
                    
                    let AC = JSController("Error", MyMessage: "There was an error accepting this game.  Please check your network connections and try again.",Color: "Red")
                  //  self.presentViewController(AC, animated: true, completion: nil)
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error Accepting Game", subTitle: "Please Check your network Connections", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                }
                
            })
            
             theAlert.addButton("No Thanks", action: {
                
             
                let mergeResult = MergeWithGame(gameid, username: self.player, turninfo: turn, status: "decline", userID: self.userID)
                if mergeResult == "yes" {
                    print("Sync Complete")
                    
                    let AC = JSController("Game Declined", MyMessage: "You have declined to join this game.",Color: "Blue")
                   // self.presentViewController(AC, animated: true, completion: nil)
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Declined", subTitle: "You have declined to join this game.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                } else {
                    print("Sync Incomplete")
                    
                    //  let AC = JSController("Error", MyMessage: "There was an error declining this game.  Please check your network connections and try again.",Color: "Red")
                    //  self.presentViewController(AC, animated: true, completion: nil)
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "There was an error declining this game", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
               
                        
                        DispatchQueue.main.async(execute: {
                            self.dismiss(animated: false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                        })
                   
                    
                }

                
                
             })
            //, target:self, selector:Selector("Settings"))
            //theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blueColor(), title: "It's Your Turn!", subTitle: NotificationMessage)
            
            
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "New Game!", subTitle: "You've been asked to join a game", duration: nil, completeText: "Not Now", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        })

        
    }
    
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ViewComments" {
            if let destination = segue.destination as? CommentsViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.GameID = GameID
                destination.wasNotified = true
                
            }
            
        }
        
        
        if segue.identifier == "goto_login" {
            if let destination = segue.destination as? LoginViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.player = player
                         
          }
        
        }
        
        
        if segue.identifier == "SuggestedNewGame" {
            if let destination = segue.destination as? ConfirmPlayersViewController {
                // destination.GameName = GameNameInfo[GameIndex]
               // destination.player = player
                destination.NewGameTitle = SuggestedTitle
                destination.NewGamePlayers = SuggestedPlayers
                destination.NewGameTurnTime = SuggestedTurnTime
                destination.NewGameFirstTurn = SuggestedFirstTurn
             //   destination.NewGameImage = SuggestedNewGameImage
                destination.NewGameQuote = SuggestedQuote
                destination.NewGamePictureData = SuggestedNewGamePictureData
                destination.NewGameContentRating = SuggestedRating
            }
            
        }
        
        
        //  if segue.identifier == GameSegue {
            if let destination = segue.destination as? GameViewController {
                    // destination.GameName = GameNameInfo[GameIndex]
                    destination.GameID = GameID
                    //println("Game Turn 1: \(TurnNumberInfo[GameIndex])")
                    
                    destination.CurrentTurn = TurnNumber
                    destination.GameStyle = GameType
                    destination.IsTurnAvailable = "yes"
                //destination.IsComplete = IsCompleteInfo[GameIndex]
                    
 
            }
     //   }
        
        if let destination = segue.destination as? LoginViewController {
            //destination.NameInfo = NameInfo
            destination.player = player
            destination.playerid = playerid
            destination.dt = token
            
        }
        
    }
    
    
    
    func HandleShortcutVCleaders(_ notification:Notification) {
        print("seguing to leaders)")
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        let type = jsonAlert["type"].stringValue
        
        print("type = \(type)")
        
      
        
        if let viewControllers = self.navigationController?.viewControllers {
            print("view controller is navigation controller")
            for viewController in viewControllers {
                if viewController.isKind(of: ViewController.self) {
                    print("is kind of class")
                    
                    
                    self.GoToNewGame()
                    
                    
                    
                } else {
                    print("go to root view controller")
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                    
                }
            }
        } else {
            print("else showing")
            
            self.navigationController?.popToRootViewController(animated: false)
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: {
                self.GoToNewGame()
                
            })
        }
        
        
        //    dispatch_async(dispatch_get_main_queue(), {
        
        DispatchQueue.main.async(execute: {
            //  self.dismissViewControllerAnimated(false, completion: nil)
            //self.StartSuggestedGame(QuoteExample, username: self.username, userid: self.userID)
            self.GoToNewGame()
        })
        //   })
        
        
    }
    
    func HandleShortcutVCmygames(_ notification:Notification) {
        print("seguing to my games)")
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        let type = jsonAlert["type"].stringValue
        
        print("type = \(type)")
        
        print("start game")
        
        if let viewControllers = self.navigationController?.viewControllers {
            print("view controller is navigation controller")
            for viewController in viewControllers {
                if viewController.isKind(of: ViewController.self) {
                    print("is kind of class")
                    
                    
                    self.GoToNewGame()
                    
                    
                    
                } else {
                    print("go to root view controller")
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                    
                }
            }
        } else {
            print("else showing")
            
            self.navigationController?.popToRootViewController(animated: false)
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: {
                self.GoToNewGame()
                
            })
        }
        
        
        //    dispatch_async(dispatch_get_main_queue(), {
        
        DispatchQueue.main.async(execute: {
            //  self.dismissViewControllerAnimated(false, completion: nil)
            //self.StartSuggestedGame(QuoteExample, username: self.username, userid: self.userID)
            self.GoToNewGame()
        })
        //   })
        
        
    }
    
    func HandleShortcutVC(_ notification:Notification) {
        print("seguing to new game)")
        
        
        if self.isViewLoaded  {
            print("SHOULD Perform New Game Shortcut")
        }
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        let type = jsonAlert["type"].stringValue
        
        print("type = \(type)")
        
        print("start game")
        
        if let viewControllers = self.navigationController?.viewControllers {
            print("view controller is navigation controller")
            for viewController in viewControllers {
                if viewController.isKind(of: ViewController.self) {
                   // if viewController.is
                    print("is kind of class")
                    
                    DispatchQueue.main.async(execute: {
                    self.GoToNewGame()
                    })
                    
                    
                } else {
                    print("go to root view controller")
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                    
                }
            }
        } else {
            print("else showing")
            
            self.navigationController?.popToRootViewController(animated: false)
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: {
                self.GoToNewGame()

            })
        }
        
        
    //    dispatch_async(dispatch_get_main_queue(), {
            
            DispatchQueue.main.async(execute: {
                //  self.dismissViewControllerAnimated(false, completion: nil)
                //self.StartSuggestedGame(QuoteExample, username: self.username, userid: self.userID)
                self.GoToNewGame()
            })
     //   })
        
        
    }
    
    func GoToNewGame() {
        
        DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "select_newgame", sender: self)
        })
    }
    
    func GoToMyGames() {
        DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "select_mygames", sender: self)
        })
    }
    
    func GoToLeaders() {
        DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "select_leaders", sender: self)
        })
    }
    
    func HandleAlertMessage(_ notification:Notification) {
        
      /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GameController") as! UIViewController
        
        self.presentViewController(vc, animated: false, completion: nil)
        
         navigationController?.popToRootViewControllerAnimated(true)

        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
     */   
        print("Did Receive Remote Notification While In Game")
        
        var QuoteExample = String()
        var player1 = String()
        var player2 = String()
        var player3 = String()
        var player4 = String()
        var player5 = String()
        var player6 = String()
        var player7 = String()
        var player8 = String()
        var player9 = String()
        var player10 = String()
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        let NotificationMessage = jsonAlert["message"].stringValue
        let gameBy = jsonAlert["gameBy"].stringValue
        let gameId = jsonAlert["gameId"].stringValue
        let category = jsonAlert["category"].stringValue
        let turninfo = jsonAlert["turninfo"].stringValue
        let gameType = jsonAlert["gameType"].stringValue
        
        if category == "GameSuggestion" {
            
            
            QuoteExample = jsonAlert["quote"].stringValue
            print("Quote example is =\(QuoteExample)")
            player1 = jsonAlert["player1"].stringValue
            print("Player 1 is \(player1)")
            player2 = jsonAlert["player2"].stringValue
            player3 = jsonAlert["player3"].stringValue
            player4 = jsonAlert["player4"].stringValue
            player5 = jsonAlert["player5"].stringValue
            player6 = jsonAlert["player6"].stringValue
            player7 = jsonAlert["player7"].stringValue
            player8 = jsonAlert["player8"].stringValue
            player9 = jsonAlert["player9"].stringValue
            player10 = jsonAlert["player10"].stringValue
            
        } else {
            
        }
        
        print("in Game Alert Category: \(category)")
        
        
        
        if !IsHandlingAlertMessage {
            
        IsHandlingAlertMessage = true
        
        switch category {
            
        case "yourTurn":
    

            DispatchQueue.main.async(execute: {

                let theAlert = SCLAlertView()
                    theAlert.addButton("Yes, Play Now!", action: {
                    print("Settings pushed")
                   
                    var window: UIWindow?
                    
                    if let viewControllers = self.navigationController?.viewControllers {
                        
                        for viewController in viewControllers {
                            if viewController.isKind(of: ViewController.self) {
                                
                            } else {
                                UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                            }
                        }
                    } else {
                        print("else showing")
                        
                        self.navigationController?.popToRootViewController(animated: false)
                        UIApplication.shared.keyWindow?.makeKeyAndVisible()
                        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.GameID = gameId as NSString
                        self.TurnNumber = turninfo as NSString
                        self.GameType = gameType as NSString
                        
                        print("GameID =\(self.GameID)")
                        print("TurnInfo =\(self.TurnNumber)")
                        print("Trying to take turn")
                        
                        //   self.dismissViewControllerAnimated(true, completion {
                        
                        
                        DispatchQueue.main.async(execute: {
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            self.TakeTurn()
                            // self.dismissViewControllerAnimated(false, completion: nil)
                            
                            //actionSheetController.dismissViewControllerAnimated(true, completion: self.TakeTurn)
                            
                            //    }
                            
                        })
                    })
                    
                    
                })
                    
                    theAlert.addButton("Play Later", action: {
                        
                        DispatchQueue.main.async(execute: {
                            self.dismiss(animated: false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                        })
                    })
                //, target:self, selector:Selector("Settings"))
                //theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.blueColor(), title: "It's Your Turn!", subTitle: NotificationMessage)
                
                
                
                 theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "It's Your Turn...Yipee!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
               
                    
                })
                
                
                
            
                        
         //   })
            //  UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(actionSheetController, animated: true, completion: nil)
            
            case "userMessage":

                DispatchQueue.main.async(execute: {
                    
                    
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "pokeIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Incoming Message", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            
            
            
            
            case "pokeSoft":
                print("Poke Soft begins")
                
                var window: UIWindow?
                
                
                if self.isViewLoaded && (self.view.window != nil) {
       
                    print("Home VC is loaded AND on the screen")

                } else {

                    print("Home VC is loaded, but not on the screen")
                }
                
                
                if self.isViewLoaded  {
                    print("Home VC is loaded")
                } else {
                    print("Home vc is NOT loaded")
                }
                
                
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Sure, I'll play now", action: {
                        //IsHandlingAlertMessage = false
                        
                        
                        
                        // let topRootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
                        
                        // while
                        
                        //actionSheetController.dismissViewControllerAnimated(true, Completion {
                        
                        
                        // actionSheetController.re
                        
                        print("play now")
                        
                        //   theAlert.dismissViewControllerAnimated(true, completion: {
                        if self.isViewLoaded && (self.view.window != nil) {
                            
                            print("Home VC is loaded AND on the screen")
                            
                             //theAlert.hideView()
                            //theAlert.removeFromParentViewController()
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()

                            
                        } else {
                            
                           // theAlert.hideView()
                            
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            
                            if let viewControllers = self.navigationController?.viewControllers {
                                print("view controller is navigation controller")
                                for viewController in viewControllers {
                                    if viewController.isKind(of: ViewController.self) {
                                        print("is kind of class")
                                        
                                        
                                        self.navigationController?.popToRootViewController(animated: false)
                                        UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
                                        
                                        /*
                                        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                                        let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                                        
                                         UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: nil )
                                        
                                        */
                                        
                                    } else {
                                        print("go to root view controller")
                                        UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                                        
                                    }
                                }
                                
                                
                            } else {
                                
                            self.navigationController?.popToRootViewController(animated: false)
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
                            
                            
                            
                            
                            
                            print("Home VC is loaded, but not on the screen")
                        }
                        }
                        
                        /*
                        if let viewControllers = self.navigationController?.viewControllers {
                            print("view controller is navigation controller")
                            for viewController in viewControllers {
                                if viewController.isKindOfClass(ViewController) {
                                    print("is kind of class")
                                } else {
                                    print("go to root view controller")
                                    UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                                    
                                }
                            }
                            

                        } else {
                            print("else showing")
                            
                           /*
                            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                            let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                            
                           // UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: nil )
                            
                            
                            //UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(vc, animated: false, completion: {
                            
                            dispatch_async(dispatch_get_main_queue(), {

                            self.GameID = gameId
                            self.TurnNumber = turninfo
                            self.GameType = gameType
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            dispatch_async(dispatch_get_main_queue(), {
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            theAlert.removeFromParentViewController()
                            self.TakeTurn()
                            
                            
                            })
                            
                            })
                        //})
                        
                            }
*/
                            
                           //  UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: nil)
                            
                            
                            
                            print("Should show VC NOW")
                            
                          //  self.dismissViewControllerAnimated(true, completion: {
                            
                            self.navigationController?.popToRootViewControllerAnimated(false)
                            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                           // })
                        }
                        */
                            //self.dismissViewControllerAnimated(false, completion: nil)
                            
                            // })
                            
                            
                            
                            
                            /*
                            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc: UIViewController = sb.instantiateViewControllerWithIdentifier("start") as UIViewController
                            
                            let window = UIApplication.sharedApplication().windows[0] as UIWindow;
                            
                            
                            UIView.transitionFromView((window.rootViewController?.view)!, toView: vc.view, duration: 0.65, options: .TransitionCrossDissolve, completion: nil)
                            
                            }*/
                       // }
                        
                        
                        
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.GameID = gameId as NSString
                            self.TurnNumber = turninfo as NSString
                            self.GameType = gameType as NSString
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            DispatchQueue.main.async(execute: {
                                //  self.dismissViewControllerAnimated(false, completion: nil)
                                theAlert.removeFromParentViewController()
                                theAlert.hideView()
                                self.TakeTurn()
                                
                                 //theAlert.removeFromParentViewController()
                                DispatchQueue.main.async(execute: {
                                    //theAlert.dismissViewControllerAnimated(false, completion: nil)
                                   //  UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
                                    self.IsHandlingAlertMessage = false
                                   // theAlert.removeFromParentViewController()
                                    print("about to dismiss the root view controller????")
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
                                    })
                                    
                                    self.dismiss(animated: false, completion: nil)
                                    print("DISMISSING THE SOFT ALERT SCREEN")
                                })
                                
                            })
                        })
                        

                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                       //  })
                    })
                    
                    theAlert.addButton("Later", action: {
                        theAlert.removeFromParentViewController()

                        DispatchQueue.main.async(execute: {
                            self.IsHandlingAlertMessage = false
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            //theAlert.dismissViewControllerAnimated(false, completion: nil)
                            //self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE SOFT ALERT SCREEN")
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Poked Softly To Play.", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            
            
            case "pokeMedium":
            
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Play Now", action: {
                        
                        var window: UIWindow?
                        
                        
                        // let topRootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
                        
                        // while
                        
                        //actionSheetController.dismissViewControllerAnimated(true, Completion {
                        
                        
                        // actionSheetController.re
                       
                     //    theAlert.dismissViewControllerAnimated(true, completion: {
                        
                        print("play now")
                        
                        if let viewControllers = self.navigationController?.viewControllers {
                            
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            
                            print("view controller is navigation controller")
                            for viewController in viewControllers {
                                if viewController.isKind(of: ViewController.self) {
                                    print("is kind of class")
                                } else {
                                    print("go to root view controller")
                                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                                    
                                }
                            }
                        } else {
                            print("else showing")
                            
                            
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.GameID = gameId as NSString
                            self.TurnNumber = turninfo as NSString
                            self.GameType = gameType as NSString
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            DispatchQueue.main.async(execute: {
                                //  self.dismissViewControllerAnimated(false, completion: nil)
                                theAlert.removeFromParentViewController()
                                theAlert.hideView()
                                self.TakeTurn()
                                DispatchQueue.main.async(execute: {
                                   // theAlert.dismissViewControllerAnimated(false, completion: nil)
                                    
                                    self.IsHandlingAlertMessage = false
                                   // theAlert.hideView()
                                    //theAlert.removeFromParentViewController()
                                    self.dismiss(animated: false, completion: nil)
                                    print("DISMISSING THE MEDIUM ALERT SCREEN")
                                })
                                
                            })
                        })
                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                      //  })
                    })
                    
                    theAlert.addButton("Later", action: {
                        theAlert.hideView()
                        DispatchQueue.main.async(execute: {
                            self.IsHandlingAlertMessage = false
                            theAlert.hideView()
                            theAlert.removeFromParentViewController()
                           // theAlert.dismissViewControllerAnimated(false, completion: nil)
                            //self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE MEDIUM ALERT SCREEN")
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poked to Play!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            
            
            case "pokeHard":
                
                
                
                
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Play Now", action: {
                        
                        var window: UIWindow?
                        
                        
                        // let topRootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
                        
                        // while
                        
                        //actionSheetController.dismissViewControllerAnimated(true, Completion {
                        
                        
                        // actionSheetController.re
                        
                        //  theAlert.dismissViewControllerAnimated(true, completion: {
                        
                        print("play now")
                        
                        if let viewControllers = self.navigationController?.viewControllers {
                            
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            print("view controller is navigation controller")
                            for viewController in viewControllers {
                                if viewController.isKind(of: ViewController.self) {
                                    print("is kind of class")
                                } else {
                                    print("go to root view controller")
                                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                                    
                                }
                            }
                        } else {
                            print("else showing")
                            theAlert.removeFromParentViewController()
                            theAlert.hideView()
                            
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.GameID = gameId as NSString
                            self.TurnNumber = turninfo as NSString
                            self.GameType = gameType as NSString
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            DispatchQueue.main.async(execute: {
                                //  self.dismissViewControllerAnimated(false, completion: nil)
                                theAlert.removeFromParentViewController()
                                theAlert.hideView()
                                self.TakeTurn()
                                DispatchQueue.main.async(execute: {
                                    
                                    self.IsHandlingAlertMessage = false
                                    
                                    theAlert.removeFromParentViewController()
                                    //theAlert.dismissViewControllerAnimated(false, completion: nil)
                                    //self.dismissViewControllerAnimated(false, completion: nil)
                                    print("DISMISSING THE HARD ALERT SCREEN")
                                })
                                
                            })
                        })
                        
                        //  })
                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                        //})
                    })
                    
                    theAlert.addButton("Later", action: {
                        theAlert.hideView()
                        DispatchQueue.main.async(execute: {
                            
                            self.IsHandlingAlertMessage = false
                            theAlert.removeFromParentViewController()
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                            // theAlert.dismissViewControllerAnimated(false, completion: nil)
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Ouch! Hard Poked!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
            
            case "newGame":
                
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Alright!", action: {
                        
                        
                        
                        self.GameID = gameId as NSString
                        self.GameBY = gameBy as NSString
                        
                          DispatchQueue.main.async(execute: {
                        self.NewGameAlert(gameId as NSString, turn: turninfo as NSString)
                        
                        })
                        
                    })
                    
                    theAlert.addButton("No Thanks", action: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            theAlert.removeFromParentViewController()
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                            // theAlert.dismissViewControllerAnimated(false, completion: nil)
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "New Game!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            
            case "GameComplete":
           
                
                
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Check it out!", action: {
                        
                        var window: UIWindow?
                        
                        
                        
                        // print("play now")
                        
                        if let viewControllers = self.navigationController?.viewControllers {
                            print("view controller is navigation controller")
                            for viewController in viewControllers {
                                if viewController.isKind(of: ViewController.self) {
                                    print("is kind of class")
                                } else {
                                    print("go to root view controller")
                                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                                    
                                }
                            }
                        } else {
                            print("else showing")
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                        }
                        
                        
                        //dispatch_async(dispatch_get_main_queue(), {
                        
                        self.GameID = gameId as NSString
                        self.TurnNumber = turninfo as NSString
                        self.GameType = gameType as NSString
                        
                        print("GameID =\(self.GameID)")
                        print("TurnInfo =\(self.TurnNumber)")
                        print("Trying to take turn")
                        DispatchQueue.main.async(execute: {
                            
                            theAlert.removeFromParentViewController()
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            self.TakeTurn()
                            
                        })

                        
                    })
                    
                    
                    theAlert.addButton("Later", action: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            theAlert.removeFromParentViewController()
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                            // theAlert.dismissViewControllerAnimated(false, completion: nil)
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Your Game is Complete!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })

                
            
        case "GameSuggestion":
                
                let title = "Game Suggestion"
                let message = "Start a new game using this quote: \(QuoteExample)"
                
                let notifiAlert = UIAlertView()
                notifiAlert.title = "\(title)"
                notifiAlert.message = "\(message)"
                notifiAlert.addButton(withTitle: "Ok")
                
                DispatchQueue.main.async(execute: {
                    let theAlert = SCLAlertView()
                    
                    theAlert.addButton("Let's do it", action: {
                        
                        var window: UIWindow?
                        
                        
                        // let topRootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
                        
                        // while
                        print("start game")
                        
                        if let viewControllers = self.navigationController?.viewControllers {
                            print("view controller is navigation controller")
                            for viewController in viewControllers {
                                if viewController.isKind(of: ViewController.self) {
                                    print("is kind of class")
                                } else {
                                    print("go to root view controller")
                                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                                    
                                }
                            }
                        } else {
                            print("else showing")
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.GameID = gameId as NSString
                            self.TurnNumber = turninfo as NSString
                            self.GameType = gameType as NSString
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            DispatchQueue.main.async(execute: {
                                //  self.dismissViewControllerAnimated(false, completion: nil)
                                
                                theAlert.removeFromParentViewController()
                                self.StartSuggestedGame(QuoteExample as NSString, username: self.username, userid: self.userID)
                                
                            })
                        })
                        
                    })
                    
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "\(title)", subTitle: message, duration: nil, completeText: "Next time", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })

                
            
        case "gameComment":
            
            
        DispatchQueue.main.async(execute: {
            
            
            let theAlert = SCLAlertView()
            
            
            theAlert.addButton("Check It Out!") {
                
                var window: UIWindow?
                
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController in viewControllers {
                        if viewController.isKind(of: ViewController.self) {
                            
                        } else {
                            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                        }
                    }
                } else {
                    print("else showing")
                    
                    self.navigationController?.popToRootViewController(animated: false)
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.GameID = gameId as NSString
                    self.TurnNumber = turninfo as NSString
                    self.GameType = gameType as NSString
                    
                    print("GameID =\(self.GameID)")
                    print("TurnInfo =\(self.TurnNumber)")
                    print("Trying to take turn")
                    DispatchQueue.main.async(execute: {
                        //  self.dismissViewControllerAnimated(false, completion: nil)
                        self.ViewComments()
                        
                    })
                })

                
            }
            
                
           
            //theAlert.showCustomOK(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage)
            
            theAlert.showCustom(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
            
        
        default:
            print("unknown push alert")
            
        }
        
        
    }
        
  }
    
    
    
    @IBAction func VolumeBTN(_ sender: AnyObject) {
        if !VolumeMute {
            VolumeMute = true
            prefs.set(true, forKey:"MuteGameAudio")
            
            musicPlayer.stop()
            VolumeBTN.image = UIImage(named: "speaker-off.png")
        } else {
            VolumeMute = false
            VolumeBTN.image = UIImage(named: "speaker-on.png")
            
            
            
         //   if defaultCFUN {
                
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
                
            } catch {
                print(error)
            }
       //     }
            
            prefs.set(false, forKey: "MuteGameAudio")
        }
    
    }
    
    func PlayBackgroundMusic() {
    
        if VolumeMute {
        
            VolumeBTN.image = UIImage(named: "speaker-off.png")
        } else {
            VolumeBTN.image = UIImage(named: "speaker-on.png")
            
          //  if defaultCFUN {
            do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
                
            } catch {
                print(error)
            }
      //  }
        
        }
 
        
        
    }
    
    func StartSuggestedGame(_ Quote: NSString, username: NSString, userid: NSString){
        
        SuggestedQuote = Quote
        SuggestedUserName = username
        SuggestedUserID = userid
        SuggestedRating = "M"
        SuggestedTitle = "Test Suggestion"
        SuggestedPlayers = 2
        SuggestedTurnTime = "00:00:00"
        SuggestedFirstTurn = "quote"
       // SuggestedNewGameImage = UIImage()
        
        SuggestedNewGamePictureData = ""

        
        print("starting suggested new game")
        
        self.performSegue(withIdentifier: "SuggestedNewGame", sender: self)
        
    }
    
    func TakeTurn() {
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let vc = storyboard.instantiateViewControllerWithIdentifier("home") as! UIViewController

        
       // UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(vc, animated: false, completion: nil)
        print("Take my turn seque")
        /*dispatch_async(dispatch_get_main_queue(), { self.dismissViewControllerAnimated(true, completion: {
         */
            self.performSegue(withIdentifier: "Take_My_Turn", sender: self)
            
      //  })
      //  })
        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
        
        //self.redLeft.constant = -210
    }
   
    func ViewComments() {
    
        print("ViewComments")
     
        self.performSegue(withIdentifier: "ViewComments", sender: self)
      
    }
    
    @IBAction func testFirst(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "DemoGame", sender: self)
        
      //  SCLAlertView().showNotice("Congrats!", subTitle: "the pop up message is working")
        
       /*
        let theAlert = SCLAlertView()
        theAlert.addButton("Settings") {
            print("Settings pushed")
            let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            //   let settingsUrl = NSURL(string: UIAppli)
            if let url = settingsUrl {
                UIApplication.sharedApplication().openURL(url)
            }

        }
        //, target:self, selector:Selector("Settings"))
        theAlert.addButton("Cancel") {
            print("Cancel pushed")
        }
        theAlert.showCustom(UIImage(named: "alertcontent.png")!, color: UIColor.redColor(), title: "Notifications!", subTitle: "Looks like your Push Notifications are turned off, turn them on for a better game experience")
*/
       
     /*
        let theAlert = SCLAlertView()
        theAlert.addButton("Ok") {
            print("Cancel pushed")
        }

*/
         //theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Uh..that's yours.", subTitle: "You're trying to 'Fail' your own turn...nope.")

        
        //green - UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        //blue - UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)
        //red - UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0)


  
        
     //   SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "test", subTitle: "test", duration: nil, completeText: "test", style: .Custom, colorStyle: 1, colorTextButton: 1)
        

    }
    
    func FilterIDData(_ urlData: Data) -> [NSString] {
        
        var Total_Likes_Int = Int()
        var Game_ID_Array = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary

        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")

        for result in json["Data"].arrayValue {

            if ( result["id"] != "0") {

                let game_id = result["id"].stringValue
                print("Game ID = \(game_id)")
                
                Game_ID_Array.append(game_id as NSString)
                
            }
            
            let num_likesTemp = result["totalLikes"].stringValue
            //println9("")
            let num_likes = Int(num_likesTemp)
            
            print("Num Likes = \(num_likes!)")
           // Total_Likes = num_likes!
           Total_Likes_Int = Total_Likes_Int + num_likes!
            NewLikesArray.append(Total_Likes_Int)
            
            print("Total Likes = \(Total_Likes)")
        }
        Total_Likes = NewLikesArray[0]
        
        return Game_ID_Array
        
    }
    

}

extension URL {
    func getKeyVals() -> Dictionary<String, String>? {
        var results = [String:String]()// = [String:AnyObject]()
        let keyValues = self.query?.components(separatedBy: "&")
        if keyValues?.count > 0 {
            for pair in keyValues! {
                let kv = pair.components(separatedBy: "=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
            /*
        if let queryString = self.query{
            for parameter in queryString.componentsSeparatedByString("&"){
                let parts = parameter.componentsSeparatedByString("=")
                if parts.count > 1{
                    let key = (parts[0] as String).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                    let value = (parts[1] as String).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                    if key != nil && value != nil {
                        info[key!] = value
                    }
                }
            }
        }
*/
        }
        return results
    }
    


}


extension URL {
    var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                for keyValueString in query.components(separatedBy: "&") {
                    var parts = keyValueString.components(separatedBy: "=")
                    if parts.count < 2 { continue; }
                    let key = parts[0].removingPercentEncoding!
                    let value = parts[1].removingPercentEncoding!
                    var values = dictionary[key] ?? [String]()
                    values.append(value)
                    dictionary[key] = values
                }
                return dictionary
            }

        return nil
        }
    }
}

extension UIView
{
    
    
    func removeAllSubViews()
    {
        for subView :AnyObject in self.subviews
        {
            subView.removeFromSuperview()
        }
    }
    
}
