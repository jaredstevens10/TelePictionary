//
//  StartUpViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/17/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class StartUpViewController: UIViewController, GameViewControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    
    var IsUpdatingVersion = Bool()
    let AppVersion = "1.0.7"
    
    
    
    @IBOutlet weak var grayViewH: NSLayoutConstraint!

    @IBOutlet weak var grayViewW: NSLayoutConstraint!
    @IBOutlet weak var grayView: UIView!
    
    var NotFirstLaunch = false
    var musicPlayer: AVAudioPlayer!
    
    @IBOutlet weak var viewPQ: UIView!
    @IBOutlet weak var viewCS: UIView!
    
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
    
    var GameBY = NSString()
    var GameID = NSString()
    var TurnNumber = NSString()
    var GameType = NSString()
    var IsHandlingAlertMessage = Bool()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var WordSX: NSLayoutConstraint!
    
    var ImportedFileURL = NSString()
    var ShowSettingsNotice = Bool()
    @IBOutlet weak var WordCX: NSLayoutConstraint!
    @IBOutlet weak var cirProgress: KDCircularProgress!
    var CompletedGameIDs = [String]()
    var ShouldSkip = Bool()
   // var NotFirstLaunch = Bool()
    var url: URL!
    var defaultCFUN = Bool()
    var LoggedIn = Bool()
    let prefs:UserDefaults = UserDefaults.standard
    var VolumeMute = Bool()
    @IBOutlet weak var wordS: UIImageView!
    @IBOutlet weak var wordC: UIImageView!
    @IBOutlet weak var PQLogo: UIImageView!
    var username = NSString()
    var userid = NSString()
    let maxCount = 360
    var currentCount = 0
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    override func viewDidLoad() {
        
        prefs.set(AppVersion, forKey: "AppVersion")
        print("*****App Version***** - \(AppVersion)")
        
       // grayView.layer.cornerRadius = 100
        grayView.layer.cornerRadius = 0
        grayView.clipsToBounds = true
        grayView.layer.masksToBounds = true
        grayViewH.constant = 0
        grayViewW.constant = 0
        grayView.layer.backgroundColor = UIColor(red: 50.0/255, green: 55.0/255, blue: 61.0/255, alpha: 1.0).cgColor
        
        
        self.viewCS.isHidden = false
        viewCS.layer.masksToBounds = true
        self.viewCS.alpha = 1.0
        viewCS.layer.cornerRadius = 100
        viewCS.clipsToBounds = true
        viewCS.layer.borderWidth = 1
        viewCS.layer.borderColor = UIColor(red: 50.0/255, green: 55.0/255, blue: 61.0/255, alpha: 1.0).cgColor
        
        viewPQ.layer.masksToBounds = true
        viewPQ.layer.cornerRadius = 100
        viewPQ.clipsToBounds = true
       // viewPQ.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.view.backgroundColor = UIColor(red: 71.0/255, green: 75.0/255, blue: 84.0/255, alpha: 1.0)
        
        let isNo = "no"
        prefs.setValue(isNo, forKey: "ISFUN")
        super.viewDidLoad()
       //ShouldSkip = NSUserDefaults.standardUserDefaults().boolForKey("LOGINLATER")
        ShouldSkip = prefs.bool(forKey: "LOGINLATER")
        print("Should skip from start VC = \(ShouldSkip)")
      //  self.logoIMGw.constant = 0
      //  self.logoIMGh.constant = 0
        self.PQLogo.alpha = 1.0
        self.cirProgress.alpha = 0.0
        
        prefs.set("NONE", forKey: "LOGINSENTFROM")
        
        
        self.NotFirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
        self.LoggedIn = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        
        // self.performSegueWithIdentifier("login", sender: self)
        
        /*
        if !LoggedIn {
            self.performSegueWithIdentifier("login", sender: self)
        } else {
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            print("waiting 4 seconds to start")

                self.performSegueWithIdentifier("start_game", sender: self)
            //self.performSegueWithIdentifier("startApp", sender: self)
            // here code perfomed with delay
            
        })
            
            */
        
       // }
        
        /*
        if !LoggedIn {
            self.performSegueWithIdentifier("login", sender: self)
        }
        */

        // Do any additional setup after loading the view.
        
        
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
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(StartUpViewController.displayForegroundDetailsStart), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartUpViewController.displayBackgroundDetails), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        //SWIFT 3 ERROR
     //   NotificationCenter.default.addObserver(self, selector: "displayRemoteNotificationKeyDetails", name: NSNotification.Name.remoteNotification, object: nil)
        
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartUpViewController.displayLaunchDetails), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartUpViewController.HandleAlertMessage(_:)), name: NSNotification.Name(rawValue: "HandleAlertMessage"),  object: nil)
        /*
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVC:", name: "HandleShorcutVC",  object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVCmyGames:", name: "HandleShorcutVCmyGames",  object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "HandleShortcutVCleaders:", name: "HandleShorcutVCleaders",  object: nil)
        */
        /*
      
       
        
      
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "NewGameStarted:", name: "NewGameStarted",  object: nil)
        
     
        
       
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name:UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);

*/
        
        
       // cirProgress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        cirProgress.startAngle = 0
        cirProgress.progressThickness = 0.1
        cirProgress.trackThickness = 0.3
        cirProgress.clockwise = true
        cirProgress.gradientRotateSpeed = 2
        cirProgress.roundedCorners = false
        cirProgress.glowMode = .forward
        cirProgress.glowAmount = 0.9
        cirProgress.setColors(colors: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0))
        cirProgress.trackColor = UIColor.white
        //cirProgress.backgroundColor = UIColor.whiteColor()
        //cirProgress.setColors(UIColor.cyanColor() ,UIColor.whiteColor(), UIColor.magentaColor(), UIColor.whiteColor(), UIColor.orangeColor())
       // cirProgress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        //view.addSubview(progress)
        
        self.viewCS.isHidden = false
        
        
       // PlayBackgroundMusic()
    }
    
    func displayForegroundDetailsStart() {
        print("APP ENTERED THE FOREGROUND FROM THE STARTUP VC")
       

        
        if IsUpdatingVersion {
            
            let seconds = 1.0
            let secondsLoad = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
            
            
        if Reachability.isConnectedToNetwork() {
            
            let TestAppVersion = CheckAppVersion(self.AppVersion as NSString)
            print("App needs updating = \(TestAppVersion)")
            
            if !TestAppVersion {
                
                
                VolumeMute = prefs.bool(forKey: "MuteGameAudio")
                
                
                self.LoggedIn = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
                // self.performSegueWithIdentifier("login", sender: self)
                // LoggedIn = false
                //let ShouldSkip = NSUserDefaults.standardUserDefaults().boolForKey("LOGINLATER")
                //print("Should Skip = \(ShouldSkip)")
                
                if !LoggedIn {
                    
                    username = "guest"
                    userid = "guest"
                    
                    print("Skip from View did appear start VC = \(ShouldSkip)")
                    if ShouldSkip {
                        print("Should start game")
                        self.performSegue(withIdentifier: "start_game", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "login", sender: self)
                    }
                } else {
                    
                    // let TokenNew = GetTokenInfo()
                    
                    
                    
                    // currentCount = 10
                    increaseProgress()
                    
                    prefs.set(false, forKey: "VIEWEDTURNS")
                    username = prefs.value(forKey: "USERNAME") as! String as NSString
                    userid = prefs.value(forKey: "PLAYERID") as! String as NSString
                    print("STARTING Current playerID = \(prefs.value(forKey: "USERNAME"))")
                    print("STARTING Current playerID = \(prefs.value(forKey: "PLAYERID"))")
                    
                    SyncUser(username, theUserID: userid)
                    
                    GetCompletedGamesData()
                    
                    
                    let GameData = MyTurnsCount(username, userID: userid)
                    FilterCompletedData(GameData)
                    //let
                    
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let LevelUpTime = GetLevelTokens(self.username, userid: self.userid, action: "get")
                        
                        DispatchQueue.main.asyncAfter(deadline: dispatchTimeLoad, execute: {
                            
                            let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
                            
                            //  dispatch_after(dispatchTimeLoad, dispatch_get_main_queue(), {
                            UIView.transition(from: self.viewCS, to: self.viewPQ, duration: 0.8, options: animationOptions, completion: nil)
                            
                            // })
                            
                            self.performSegue(withIdentifier: "start_game", sender: self)
                        })
                    })
                    
                }
                
                
            } else {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let theAlert = SCLAlertView()
                    
                    
                    theAlert.addButton("Update", action: {
                        
                        
                        //http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8
                        
                        UIApplication.shared.openURL(URL(string: "http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8")!)
                        
                    })
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Update Available", subTitle: "A new version is available", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
            }
            
            
        }  else {
            
            DispatchQueue.main.async(execute: {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Check your Internet Connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
            
            
        }
        
    }
    
        
        
    }
    
    func displayRemoteNotificationKeyDetails() {
        print("REMOTE NOTIFICATION KEY DETAILS")
    }
    
    func displayBackgroundDetails () {
        print("APP ENTERED THE BACKGROUND")
    }
    
    /*
    func NewGameStarted() {
    print("Received notice to start a new game")
    
    dispatch_async(dispatch_get_main_queue(),{
    
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
    
    dispatch_async(dispatch_get_main_queue(),{
    
    let theAlert2 = SCLAlertView()
    theAlert2.addButton("Ok", action: {
    dispatch_async(dispatch_get_main_queue(),{
    NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
    })
    })
    
    theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Level \(LevelNew.description) - Level Up!", subTitle: "You just got a Level up on your Pixie!", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    
    }
    })
    
    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You just earned 5 Pixie points for starting a new game!", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
    })
    
    
    }
    
   
*/
    
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
    
    
    func NewGameAlert(_ gameid: NSString, turn: NSString) {
        
        
        DispatchQueue.main.async(execute: {
            
            
            
            let theAlert = SCLAlertView()
            theAlert.addButton("Accept Invite", action: {
                print("Settings pushed")
                
                let mergeResult = MergeWithGame(gameid, username: self.username, turninfo: turn, status: "accept", userID: self.userid)
                if mergeResult == "yes" {
                    print("Sync Complete")
                    
                    _ = JSController("Game Accepted", MyMessage: "You have accepted this Game Invite.  You will be notified when it's your turn.",Color: "Green")
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
                    
                    _ = JSController("Error", MyMessage: "There was an error accepting this game.  Please check your network connections and try again.",Color: "Red")
                    //  self.presentViewController(AC, animated: true, completion: nil)
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error Accepting Game", subTitle: "Please Check your network Connections", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                }
                
            })
            
            theAlert.addButton("No Thanks", action: {
                
                
                let mergeResult = MergeWithGame(gameid, username: self.username, turninfo: turn, status: "decline", userID: self.userid)
                if mergeResult == "yes" {
                    print("Sync Complete")
                    
                    _ = JSController("Game Declined", MyMessage: "You have declined to join this game.",Color: "Blue")
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
                        if viewController.isKind(of: StartUpViewController.self) {
                            print("is kind of class")
                            
                            self.prefs.setValue("", forKey: "SHORTCUT")
                            //NEED TO UPDATE
                           // self.GoToNewGame()
                            
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
                        if viewController.isKind(of: StartUpViewController.self) {
                            print("is kind of class")
                            
                            self.prefs.setValue("", forKey: "SHORTCUT")
                            
                            //NEED TO UPDATE
                            //self.GoToMyGames()
                            
                            
                            
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
                        if viewController.isKind(of: StartUpViewController.self) {
                            print("is kind of class")
                            
                            self.prefs.setValue("", forKey: "SHORTCUT")
                            
                            //NEED TO UPDATE
                            //self.GoToLeaders()
                            
                            
                            
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        ShouldSkip = prefs.bool(forKey: "LOGINLATER")
        print("Should skip from start VC ViewWillAppear = \(ShouldSkip)")
        
        
        self.NotFirstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
        
        print("First Launch VIEW WILL APPEAR = \(self.NotFirstLaunch)")


        
    }
    
    func newAngle() -> Int {
        return Int(360 * (currentCount / maxCount))
    }
    
    func increaseProgress() {
        
        if currentCount != maxCount {
            currentCount += 1
           // let newAngleValue = newAngle()
            let newAngleValue = Int(360 * (currentCount / maxCount))
            print("New Angle = \(newAngleValue)")
            cirProgress.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
           
        }

        
        //cirProgress.animateToAngle(90, duration: 0.5, completion: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.prefs.setValue(AppVersion, forKey: "AppVersion")
        
        let seconds = 1.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        self.PQLogo.alpha = 1.0
        self.cirProgress.alpha = 0.0
        //self.viewCS.alpha = 0.0
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            //  self.logoIMGw.constant = 100
            //  self.logoIMGh.constant = 100
            // self.cirProgress.alpha = 1.0
           // self.viewCS.alpha = 1.0
            
            
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            print("waiting 4 seconds to start")
            
            
            
            let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews]
            
            UIView.transition(from: self.viewPQ, to: self.viewPQ, duration: 0.8, options: animationOptions, completion: { (Bool) -> Void in
            
           // UIView.transition(from: self.viewPQ, to: self.viewCS, duration: 0.8, options: animationOptions, completion: { (Bool) -> Void in
                print("making CS view big")
                
                 UIView.animate(withDuration: 2.0, animations: { () -> Void in
               
                    self.grayViewH.constant = 200
                    self.grayViewW.constant = 200
                    self.grayView.layer.cornerRadius = 100
                
                 })
                
               // return true
                
            })
            
            
            
            
            /*
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                //  self.logoIMGw.constant = 100
                //  self.logoIMGh.constant = 100
                // self.cirProgress.alpha = 1.0
                self.PQLogo.alpha = 0.0
                
                
            })
            
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                //  self.logoIMGw.constant = 100
                //  self.logoIMGh.constant = 100
                // self.wordC.center.x = self.wordC.center.x - 300
                //  self.wordS.center.x = self.wordS.center.x + 300
                
                self.wordC.center.x = self.wordC.center.x + 1000
                self.WordCX.constant = -64.5
                self.wordS.center.x = self.wordS.center.x - 1000
                self.WordCX.constant = 47.5
                
                // self.wordC.hidden = true
                // self.wordS.hidden = true
                //self.PQLogo.alpha = 1.0
                
                
            })
            
            */
            
            
            
        })
        
        
        
        
        
        
        
        
        
        
        //self.WordCX.constant = -1000
       // self.WordSX.constant = 1000
        
        
       


        /*
        cirProgress.animateFromAngle(0, toAngle: 360, duration: 5) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
        */
        
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
            
         
            
            
            //add version check here

            
        }
        
        
    if Reachability.isConnectedToNetwork() {
        
        let TestAppVersion = CheckAppVersion(self.AppVersion as NSString)
        print("App needs updating = \(TestAppVersion)")

        if !TestAppVersion {
        
        
        VolumeMute = prefs.bool(forKey: "MuteGameAudio")
        
        
        self.LoggedIn = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        // self.performSegueWithIdentifier("login", sender: self)
       // LoggedIn = false
        //let ShouldSkip = NSUserDefaults.standardUserDefaults().boolForKey("LOGINLATER")
        //print("Should Skip = \(ShouldSkip)")
        
        if !LoggedIn {
            
            username = "guest"
            userid = "guest"
            
            print("Skip from View did appear start VC = \(ShouldSkip)")
            if ShouldSkip {
                print("Should start game")
                self.performSegue(withIdentifier: "start_game", sender: self)
            } else {
                self.performSegue(withIdentifier: "login", sender: self)
            }
          } else {
            
           // let TokenNew = GetTokenInfo()
            
            
            
           // currentCount = 10
            increaseProgress()
            
            prefs.set(false, forKey: "VIEWEDTURNS")
            username = prefs.value(forKey: "USERNAME") as! String as NSString
            userid = prefs.value(forKey: "PLAYERID") as! String as NSString
            print("STARTING Current playerID = \(prefs.value(forKey: "USERNAME"))")
            print("STARTING Current playerID = \(prefs.value(forKey: "PLAYERID"))")
            
            SyncUser(username, theUserID: userid)
            
            GetCompletedGamesData()
            
            
            let GameData = MyTurnsCount(username, userID: userid)
            FilterCompletedData(GameData)
            //let
            
            
            
            
            DispatchQueue.main.async(execute: {
                
            let LevelUpTime = GetLevelTokens(self.username, userid: self.userid, action: "get")
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTimeLoad, execute: {
                    
                let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews]
                    
                  //  dispatch_after(dispatchTimeLoad, dispatch_get_main_queue(), {
                        UIView.transition(from: self.viewCS, to: self.viewPQ, duration: 0.8, options: animationOptions, completion: nil)
                        
                   // })
                    
            self.performSegue(withIdentifier: "start_game", sender: self)
                })
            })
        
        }
        
        
    } else {
            
            DispatchQueue.main.async(execute: {
                
                
                let theAlert = SCLAlertView()
                
                
                theAlert.addButton("Update", action: {
                    
                    
                    //http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8
                    
                    UIApplication.shared.openURL(URL(string: "http://itunes.apple.com/us/app/pics%26quotes/id1023231287?mt=8")!)
                    
                })
                
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Update Available", subTitle: "A new version is available", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            })
        
        }
        
        
    }  else {
        
        DispatchQueue.main.async(execute: {
            
            self.IsUpdatingVersion = true
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Check your Internet Connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
        
        }
    
        print("View did appear")
    }
    
    
    func SyncUser (_ theUsername: NSString, theUserID: NSString) {
        
            //username = "testuser"
            // var password:NSString = txtPassword.text
            // let username: NSString = txtUsername.text!
           // let password: NSString = txtPassword.text!
            let email: NSString = theUserID
            let password = "SYNC"
            
            var deviceToken3 = Data()
            
            if (prefs.value(forKey: "deviceToken") != nil) {
                deviceToken3 = prefs.value(forKey: "deviceToken") as! Data}
                
            else {
                print("error: DeviceToken was nil")
            }
            
            let TokenNewT: NSString = deviceToken3.description.replacingOccurrences(of: " ", with: "") as NSString
            let TokenNewS: NSString = TokenNewT.description.replacingOccurrences(of: "<", with: "") as NSString
            let TokenNew: NSString = TokenNewS.description.replacingOccurrences(of: ">", with: "") as NSString
            
        
                
                let post:NSString = "username=\(theUsername)&password=\(password)&email=\(email)&playerid=\(theUserID)&token=\(TokenNew)&action=sync" as NSString
                
                //NSLog("PostData: %@",post);
                
                let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQLogin.php")!
                
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
                        
                    //    //NSLog("Response ==> %@", responseData);
                        
                      //  _: NSError?
                        
                        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                        
                        
                        let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        //NSLog("Success: %ld", success);
                        
                        //Admin = jsonData.valueForKey("admin") as! NSString
                        
                        
                        
                        if(success == 1)
                        {
                            //NSLog("Login SUCCESS");
                            
                            let prefs:UserDefaults = UserDefaults.standard
                            
                            //prefs.setObject(username, forKey: "USERNAME")
                            
                            // prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.set(true, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            
                            //  prefs.setValue(Admin, forKey: "ADMIN")
                            /*
                            Email = jsonData.valueForKey("email") as! NSString
                            let theUsername = jsonData.valueForKey("theusername") as! NSString
                            
                            print("the username =\(theUsername)")
                            prefs.setValue(Email, forKey: "EMAIL")
                            
                            prefs.setValue(theUsername, forKey: "USERNAME")
                            
                            prefs.setValue(Email, forKey: "PLAYERID")
                            
                            */
                            
                            self.dismiss(animated: true, completion: nil)
                            print("sync view dismissed")
                            
                        } else {
                            var error_msg:NSString
                            
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign in Failed!"
                            //alertView.message = "Sign in Error"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButton(withTitle: "OK")
                            // alertView.show()
                            
                            // txtEmail.text = ""
                            // txt
                            /*
                            dispatch_async(dispatch_get_main_queue(),{
                                
                                
                                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                                
                            })
                            */
                            
                        }
                        
                    } else {
                        
                        /*
                        dispatch_async(dispatch_get_main_queue(),{
                            
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                            
                        })
                        
                        */
                    }
                } else {
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                    
                    
                }
           // }
            
    }
    
    
    /*
    func SearchForMember (PLAYER: String, PlayerID: String) {
        print("search for Member")
        //password = "test123"
        // username.stringByReplacingOccurrencesOfString(" ", withString: "")
        let PlayerID2 = PlayerID.stringByReplacingOccurrencesOfString(":", withString: "")
        let Token = token
        let TokenNew2 = Token.description.stringByReplacingOccurrencesOfString("<", withString: "")
        let TokenNew3 = TokenNew2.stringByReplacingOccurrencesOfString(">", withString: "")
        let TokenNew = TokenNew3.stringByReplacingOccurrencesOfString(" ", withString: "")
        print("TokenNew = \(TokenNew)")
        //let user = self.localPlayer.alias
        
        // let post:NSString = "username=\(user)&password=\(password)&c_password=\(password)"
        
        let post:NSString = "username=\(PLAYER)&password=\(password)&c_password=\(password)&token=\(TokenNew)&playerid=\(PlayerID2)"
        
        //NSLog("PostData: %@",post);
        print("Searching for Player in TP database - TPLogin Query")
        
        let url:NSURL = NSURL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/TelePictionaryLogin.php")!
        
        print("URL entered")
        
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        let postLength:NSString = String( postData.length )
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
        } catch let error as NSError {
            reponseError = error
            urlData = nil
        }
        
        if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            
            //NSLog("Response code: %ld", res.statusCode);
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                //NSLog("Response ==> %@", responseData);
                
                //  var error: NSError?
                
                let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers )) as! NSDictionary
                
                
                let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                
                //[jsonData[@"success"] integerValue];
                
                //NSLog("Success: %ld", success);
                
                //Admin = jsonData.valueForKey("admin") as! NSString
                
                
                
                if(success == 1)
                {
                    //NSLog("Member Found - Success");
                    
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    
                    // prefs.setObject(user, forKey: "USERNAME")
                   /*
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    //  prefs.setValue(Admin, forKey: "ADMIN")
                    
                    
                    
                    Email = jsonData.valueForKey("email") as! NSString
                    
                    let isFun = jsonData.valueForKey("isFun") as! NSString
                    
                    prefs.setValue(isFun, forKey: "ISFUN")
                    
                    prefs.setValue(Email, forKey: "EMAIL")
                    
                    prefs.setValue(user, forKey: "USERNAME")
                    prefs.setValue(PlayerID2, forKey: "PLAYERID")
                    
                    */
                    
                    //self.ViewLoad1MSG.text = "Member found..."
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
                    
                    let animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews]
                    
                    UIView.transitionFromView(self.ViewLoad1, toView: self.ViewLoad2, duration: 0.8, options: animationOptions, completion: nil)
                    
                    
                    //CREATE NEW MEMBER
                    
                    MergeWithGameMembers(PLAYER as String, password: password as String, Token: token, PlayerID: PlayerID2 as String)
                    
                    
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
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
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
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            })
        }
    }
    
    */
    
    func FilterCompletedData(_ urlData: Data) {
        var CompletedCount = 0
        var gamearray = [NSString]()
        
       //
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        let totalgames = jsonData.value(forKey: "totalgames") as! NSInteger
        
        let dbtest = Double(totalgames/100)
        
        print("dbtest = \(dbtest)")
        
        let dbtest2 = 10 * dbtest
        print("dbtest2 = \(dbtest2)")
        
        
        let plusItem = round(dbtest2 / 10)
        print("round dbtest2 = \(round(dbtest2 / 10))")
        
        //let plusItem: Int = 10 * Int(round(Double(totalgames/100) / 10.0))
        print("plus item= \(plusItem.description)")
        
        //var totalgametemp = json["totalgames"].stringValue
        
        var json = JSON(jsonData)
        var load = Int()
        for result in json["Data"].arrayValue {
            
            
        
            print("Loading \(load.description)")
            print("Current Count = \(currentCount)")
            print("max count = \(maxCount)")
            
            if currentCount != maxCount {
                currentCount += 1
                // let newAngleValue = newAngle()
                let newAngleValue = Int(360 * (currentCount / maxCount))
                print("New Angle = \(newAngleValue)")
               // cirProgress.animateToAngle(newAngleValue, duration: 0.1, completion: nil)
                 cirProgress.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
            }
            
         if ( result["id"] != "0") {
            
            self.currentCount = currentCount + Int(plusItem)
           // self.increaseProgress()
            let gameID = result["id"].stringValue
            if !CompletedGameIDs.contains(gameID) {
                CompletedCount += 1
            }
            }
            load += 1
        }
        
        print("Number of UnView Completed Games = \(CompletedCount.description)")
        
        UserDefaults.standard.set(CompletedCount, forKey: "comGames")
        //return gamearray
        
    }

    
    @IBAction func unwindToStartViewController(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is QuoteViewController {
            print("Coming from Quote")
        }
        else if unwindSegue.source is ImageViewController {
            print("Coming from Image")
        }
        else if unwindSegue.source is PageIntroViewController {
            print("Coming from Completed")
        }
        else if unwindSegue.source is GameViewController {
            print("Coming GameViewController")
        }
        else if unwindSegue.source is SignUpViewController {
            print("Coming GameViewController")
        }
        
    }
    
    func GetCompletedGamesData() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext!
        
        if let managedContext = appDelegate.managedObjectContext {
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CompletedGames")
            let error: NSError?
            
            do {
                let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                
                
                if let results = fetchedResults {
                    let DGames = results
                    print(DGames)
                    
                    
                    
                    for items in DGames as [NSManagedObject] {
                        
                        let Gid = items.value(forKey: "id") as! String
                        
                        
                        
                        print(items)
                        print("game id = \(Gid)")
                        
                        CompletedGameIDs.append(Gid)
                    }
                    
                    
                } else {
                    //print("Could not fetch \(error), \(error!.userInfo)")
                }
                
            } catch {
                print(error)
            }
            
        }
        
        print("Completed Games = \(CompletedGameIDs)")
        //println("Friends Now: \(NameInfo)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
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
            
            print("switch category")
            
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
                                if viewController.isKind(of: StartUpViewController.self) {
                                    
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
                    
                    
                    
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Incoming Message", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
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
                                    if viewController.isKind(of: StartUpViewController.self) {
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
                                
                                print("view controller is NOT navigation controller")
                                print("")
                                self.navigationController?.popToRootViewController(animated: false)
                                
                                /*
                                UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: true, completion: nil)
                                
                                */
                                
                                
                                
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
                                
                              //  self.PopoverTurn()
                                
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
                                    
                                    self.TakeTurn()
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
                                    if viewController.isKind(of: StartUpViewController.self) {
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
                                
                                print("view controller is NOT navigation controller")
                                print("")
                                self.navigationController?.popToRootViewController(animated: false)
                                
                                /*
                                UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: true, completion: nil)
                                
                                */
                                
                                
                                
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
                                
                                //  self.PopoverTurn()
                                
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
                                    
                                    self.TakeTurn()
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
                                    if viewController.isKind(of: StartUpViewController.self) {
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
                                
                                print("view controller is NOT navigation controller")
                                print("")
                                self.navigationController?.popToRootViewController(animated: false)
                                
                                /*
                                UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: true, completion: nil)
                                
                                */
                                
                                
                                
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
                                
                                //  self.PopoverTurn()
                                
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
                                    
                                    self.TakeTurn()
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
                                    if viewController.isKind(of: StartUpViewController.self) {
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
                                
                                print("view controller is NOT navigation controller")
                                print("")
                                self.navigationController?.popToRootViewController(animated: false)
                                
                                /*
                                UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: true, completion: nil)
                                
                                */
                                
                                
                                
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
                                
                                //  self.PopoverTurn()
                                
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
                                    
                                    self.TakeTurn()
                                })
                                
                                
                            })
                        })
                        
                        
                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                        //  })
                    })
                    
                    
                    theAlert.addButton("Later", action: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            theAlert.removeFromParentViewController()
                            //  self.dismissViewControllerAnimated(false, completion: nil)
                            print("DISMISSING THE HARD ALERT SCREEN")
                            
                            self.TakeTurn()
                            // theAlert.dismissViewControllerAnimated(false, completion: nil)
                        })
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Game Complete!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
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
                                if viewController.isKind(of: StartUpViewController.self) {
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
                                self.StartSuggestedGame(QuoteExample as NSString, username: self.username, userid: self.userid)
                                
                            })
                        })
                        
                    })
                    
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "\(title)", subTitle: message, duration: nil, completeText: "Next time", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
                
            case "gameComment":
                
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let theAlert = SCLAlertView()
                    
                    
                    theAlert.addButton("Check It Out!", action: {
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
                                    if viewController.isKind(of: StartUpViewController.self) {
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
                                
                                print("view controller is NOT navigation controller")
                                print("")
                                self.navigationController?.popToRootViewController(animated: false)
                                
                                /*
                                UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: true, completion: nil)
                                
                                */
                                
                                
                                
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
                                
                                //  self.PopoverTurn()
                                
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
                                    
                                    self.ViewComments()
                                })
                                
                                
                            })
                        })
                        
                        
                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                        //  })
                    })
                    
                    
                    
                    //theAlert.showCustomOK(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage)
                    
                    /*
                    theAlert.showCustom(UIImage(named: "commentsIcon White.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    */
                    
                    
                       theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "New Comment", subTitle: NotificationMessage, duration: nil, completeText: "Later", style: .custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            default:
                print("unknown push alert")
                
            }
            
            
        }
        
    }
    
    func TakeTurn() {
     
        print("Take my turn seque")
        /*dispatch_async(dispatch_get_main_queue(), { self.dismissViewControllerAnimated(true, completion: {
        */
        self.performSegue(withIdentifier: "Take_My_Turn", sender: self)
        
     
    }
    
 //   @IBAction func buttonPopOverClick(sender: UIButton {
        
        func PopoverTurn() {
        
        let sender = PQLogo
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "GameController") as! GameViewController
        
        //self.GameID = gameId
        //self.TurnNumber = turninfo
       // self.GameType = gameType
        
        savingsInformationViewController.delegate=self;
        savingsInformationViewController.GameID=GameID;
        
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController = savingsInformationViewController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = (sender?.bounds)!
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    func ViewComments() {
        
        print("ViewComments")
        
        self.performSegue(withIdentifier: "ViewComments", sender: self)
    }
    
    func StartSuggestedGame(_ Quote: NSString, username: NSString, userid: NSString){
    
    
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ViewComments" {
            if let destination = segue.destination as? CommentsViewController {
                // destination.GameName = GameNameInfo[GameIndex]
                destination.GameID = GameID
                destination.wasNotified = true
                
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
        
        if segue.destination is LoginViewController {
            //destination.NameInfo = NameInfo
           // destination.player = player
           // destination.playerid = playerid
           // destination.dt = token
            
        }
        
        if segue.identifier == "select_newgame" {
            
            if let destination = segue.destination as? NewViewController {
                // let AudioBrowseViewController = segue.destinationViewController
                destination.FromMyGamesView = true
                //PQ2ViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                
                // PQ2ViewController.popoverPresentationController!.delegate = self
                //  PQ2ViewController.presentationController?.delegate = self
            }
            
        }
        
    }
    
    func GoToNewGame() {
        
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "select_newgame", sender: self)
        })
    }
    
    func GoToMyGames() {
        DispatchQueue.main.async(execute: {
          //  self.performSegueWithIdentifier("select_mygames", sender: self)
        })
    }
    
    func GoToLeaders() {
        DispatchQueue.main.async(execute: {
           // self.performSegueWithIdentifier("select_leaders", sender: self)
        })
    }

    
    func PlayBackgroundMusic() {
        
        if VolumeMute {
            
           // VolumeBTN.image = UIImage(named: "speaker-off.png")
        } else {
          //  VolumeBTN.image = UIImage(named: "speaker-on.png")
            
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
    

}
