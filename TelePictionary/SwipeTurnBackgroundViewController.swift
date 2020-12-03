//
//  SwipeTurnBackgroundViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/15/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import pop

private let numberOfCards: UInt = 5
private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1

class SwipeTurnBackgroundViewController: UIViewController {
    
    
    let RefreshHUD = ProgressHUD(text: "Refreshing Turns...")
    let GetStealHUD = ProgressHUD(text: "Loading More Turns...")
    let GetMyHUD = ProgressHUD(text: "Loading Your Turns...")
    let GetAllHUD = ProgressHUD(text: "Loading Public Turns...")
    
    var ISLOGGEDIN = Bool()
    var CurrentTurn = NSString()
    var UserTurnIDInfoBTN = NSString()
    var GameSelected = NSString()
    var BlurryImages = [UIImage]()
    var KolodaViewSegemnt = Int()
    
    var DidGetMyTurns = Bool()
    var DidGetStealTurns = Bool()
    var DidGetPublicTurns = Bool()
    
    @IBOutlet weak var nothanksLBL: UILabel!
    @IBOutlet weak var taketurnLBL: UILabel!
    
    var MyTurnImages = [UIImage]()
    var StealTurnImages = [UIImage]()
    var  PublicTurnImages = [UIImage]()
    var CurrentImage = UIImage()
    var NextImage = UIImage()
    var NextImageTwo = UIImage()
    
    var GameNameInfoBTN = NSString()
    var GameIDInfoBTN = NSString()
    var TurnNumberInfoBTN = NSString()
    var IsCompleteInfoBTN = NSString()
    var GameStyleInfoBTN = NSString()
    var CanTakeTurnInfoBTN = NSString()
    var CurrentUserInfoBTN = NSString()
    
    var GameNameInfoBTNTwo = NSString()
    var GameIDInfoBTNTwo = NSString()
    var TurnNumberInfoBTNTwo = NSString()
    var IsCompleteInfoBTNTwo = NSString()
    var GameStyleInfoBTNTwo = NSString()
    var CanTakeTurnInfoBTNTwo = NSString()
    var CurrentUserInfoBTNTwo = NSString()
    
    var NumComments = NSString()
    var theContent = NSString()
    
    var NumCommentsTwo = NSString()
    var theContentTwo = NSString()
    
    @IBOutlet weak var noBTN: UIButton!
    
    @IBOutlet weak var menuButtonRight: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let ServerURL = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    
    @IBOutlet weak var kolodaView: KolodaView!
    var GamesAvailable = Bool()
    var username = NSString()
    var userID = NSString()
    var IsGameCenter = Bool()
    var SegmentValueString = NSString()
    
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    
    var LastTurnUser = NSString()
    var TurnUser = NSString()
    var TurnUserID = NSString()
    var TurnURLString = NSString()
    
    var GameData = [NSArray]()
    var GameInfo = [NSArray]()
    
    var MyTurnSearchArray = [GameTypeSwipe]()
    var StealTurnSearchArray = [GameTypeSwipe]()
    var PublicTurnSearchArray = [GameTypeSwipe]()
    var GameSearchInfo = [GameTypeSwipe]()
    
    var FilteredGames = [GameTypeSwipe]()
    
    let prefs = UserDefaults.standard
    
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var undoView: UIView!
     @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var taketurnBTN: UIButton!
   // @IBOutlet weak var kolodaView: CustomKolodaView!
      @IBOutlet weak var backBTN: UIButton!
    
    //let numberOfCards: UInt = 5
   // let frameAnimationSpringBounciness:CGFloat = 9
   // let frameAnimationSpringSpeed:CGFloat = 16
   // let kolodaCountOfVisibleCards = 2
   // let kolodaAlphaValueSemiTransparent:CGFloat = 0.1
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        
        let numBadges = self.prefs.integer(forKey: "numTurns")
        let completedGames = self.prefs.integer(forKey: "comGames")
        // navigationController!.tabBarItem.badgeValue = numBadges.description
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
        let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
        
        print("NUMBER OF TURNS = \(numBadges)")
        
        if numBadges > 0 {
            TurnItem.badgeValue = numBadges.description
        }
        
        if completedGames > 0 {
            CompletedItem.badgeValue = completedGames.description
        }
        
        /*
        ISLOGGEDIN = NSUserDefaults.standardUserDefaults().boolForKey("ISLOGGEDIN")
        
        if !LoggedIn {
           self.performSegueWithIdentifier("login", sender: self)
        } else {
            
            */
        
        BlurryImages.append(UIImage(named: "blurry3.png")!)
        BlurryImages.append(UIImage(named: "blurry4.png")!)
        BlurryImages.append(UIImage(named: "blurry5.png")!)
        //self.KolodaViewSegemnt = 0
        
        self.title = "Turns"
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0)

        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            menuButtonRight.target = self.revealViewController()  //revealViewController()
            menuButtonRight.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if self.prefs.value(forKey: "USERNAME") != nil {
            //GamesAvailable = true
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
           // NoGamesLBL.hidden = true
            
            
        } else  {
         //   GamesAvailable = false
            username = "temp"
           // NoGamesLBL.hidden = false
            userID = "temp"
            
                        //restartMyGames.hidden = true
        }
        
        yesView.layer.cornerRadius = 30
        yesView.clipsToBounds = true
        yesView.layer.masksToBounds = true
        
        undoView.layer.cornerRadius = 20
        undoView.clipsToBounds = true
        undoView.layer.masksToBounds = true
        undoView.layer.borderWidth = 1
        undoView.layer.borderColor = UIColor.white.cgColor
        
        refreshView.layer.cornerRadius = 20
        refreshView.clipsToBounds = true
        refreshView.layer.masksToBounds = true
        
        
        noView.layer.cornerRadius = 30
        noView.clipsToBounds = true
        noView.layer.masksToBounds = true
        
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            
      //  }
        
        NotificationCenter.default.addObserver(self, selector: #selector(SwipeTurnBackgroundViewController.displayForegroundDetails), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    
    @objc func displayForegroundDetails() {
        print("APP ENTERED THE FOREGROUND")
        
        
        var window: UIWindow?
        
        
        if self.isViewLoaded && view.window != nil {
            
            
            self.view.addSubview(self.RefreshHUD)
            
            
            
            DispatchQueue.main.async(execute: {
                print("is on swipe view controller, trying to refresh my turns")
                //self.RefreshGameData(self)
                DispatchQueue.main.async(execute: {
                    self.kolodaView.resetCurrentCardNumber()
                })
                
                // self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                    self.RefreshHUD.removeFromSuperview()
                  //  self.tableView.reloadData()
                })
            })
            
            
            print("swipe VC is loaded and on screen")
            
            /*
            backgroundThread(background: {
                //self.GetPublicTurns()
                print("Starting to get Completed Game Count")
                let GameCompletdData = MyTurnsCount(self.username, userID: self.userID)
                
                //self.GetMyTurns()
                }, completion: {
                    // print("Done Getting Steal Turns")
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        print("Completed Data retrieved Refreshing Completed Games Now")
                        
                        let numBadges = self.prefs.integerForKey("numTurns")
                        let completedGames = self.prefs.integerForKey("comGames")
                        // navigationController!.tabBarItem.badgeValue = numBadges.description
                        let tabArray = self.tabBarController?.tabBar.items as NSArray!
                        let TurnItem = tabArray.objectAtIndex(0) as! UITabBarItem
                        let CompletedItem = tabArray.objectAtIndex(3) as! UITabBarItem
                        
                        //print("NUMBER OF TURNS = \(numBadges)")
                        
                        if numBadges > 0 {
                            TurnItem.badgeValue = numBadges.description
                        }
                        
                        if completedGames > 0 {
                            CompletedItem.badgeValue = completedGames.description
                        }
                        
                        print("Done Refreshing Completed Games")
                        
                        
                        
                        
                        // self.kolodaView.resetCurrentCardNumber()
                    })
            })
            */
            
            
        } else {
            print("swipe vc is not loaded or on screen")
        }
        
        if self.isViewLoaded  {
            print("swipe VC is loaded")
        } else {
            print("swipe vc is not loaded")
        }
        
        
        
        
        if let viewControllers = self.navigationController?.viewControllers {
            
            for viewController in viewControllers {
                if viewController.isKind(of: SwipeTurnBackgroundViewController.self) {
                    
                    
                    /*
                    self.view.addSubview(self.RefreshHUD)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    print("is on my games view controller, trying to refresh my games")
                    self.RefreshGameData(self)
                    // self.TableView.reloadData()
                    dispatch_async(dispatch_get_main_queue(), {
                    self.RefreshHUD.removeFromSuperview()
                    self.TableView.reloadData()
                    })
                    })
                    */
                } else {
                    //   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                    print("Not on Swipe Turn ViewController")
                }
            }
        } else {
            print("else showing")
            
            /*
            self.navigationController?.popToRootViewControllerAnimated(false)
            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
            */
        }
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        /*
        if let superView = resultSearchController.view.superview
        {
            superView.removeFromSuperview()
        }
        */
        //superView.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        prefs.set(true, forKey: "VIEWEDTURNS")
     //   override func viewDidAppear(animated: Bool) {
            //  actInd.startAnimating()
            
            
            
          //  /*
            
           // self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        
        ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        if !ISLOGGEDIN {
            
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
            let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
            
            TurnItem.badgeValue = nil
            //TurnItem.
            CompletedItem.badgeValue = nil
            
            let fromWhere: NSString = prefs.object(forKey: "LOGINSENTFROM") as! NSString
            if fromWhere.isEqual(to: "MYTURNS") {
                
                
                //   let fromView = tabBarController?.selectedViewController?.view
                // let toView = tabBarController?.viewControllers![2] as! UINavigationController
                //  let toView = tabBarController?.viewControllers![2] as! GalleryViewController
                
                prefs.set("NONE", forKey: "LOGINSENTFROM")
                
                tabBarController?.selectedIndex = 2
                
                
                
                //  UIView.transitionFromView(fromView!, toView: toView, duration: 0.325, options: UIView.AnimationOptions.CurveEaseInOut, completion: nil)
                
                
            } else {
                
                self.performSegue(withIdentifier: "login", sender: self)
                
                
            }
        
        /*
            if !self.IsGameCenter {
                
                //self.refreshControl.enabled = false
                
                let Alert = SCLAlertView()
                Alert.addButton("Log in Now", action: {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        LogIntoGameCenterNew()
                        
                    })
                    
                })
                
                Alert.addButton("Later", action: {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                        // self.NoGamesLBL.hidden = true
                        // self.restartMyGames.hidden = true
                        // self.NoGamesLBL.text = "No User Is Signed In"
                        
                        //  self.actInd.stopAnimating()
                        
                    })
                    
                    
                })
                
                Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                
                
            } else {
                
                //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GameCenterEnabled")
                
                
                
                
                // RemoveGameArrayData()
                
                // self.TableView.reloadData()
                
                //  print("game array = \(GameNameInfo)")
                
           */
                
                
                //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
        } else {
        
            
            let numBadges = self.prefs.integer(forKey: "numTurns")
            let completedGames = self.prefs.integer(forKey: "comGames")
            // navigationController!.tabBarItem.badgeValue = numBadges.description
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
            let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
            
            print("NUMBER OF TURNS = \(numBadges)")
            
            if numBadges > 0 {
                TurnItem.badgeValue = numBadges.description
            }
            
            if completedGames > 0 {
                CompletedItem.badgeValue = completedGames.description
            }
                
                if prefs.value(forKey: "USERNAME") != nil {
                    
                    username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                    userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
                } else  {
                    username = "guest"
                    userID = "guest"
                }
                
                if GamesAvailable {
                    
                    
                    
                }
                
                //  DeletedGameIDs.removeAll()
                //  GetDeletedGamesData()
                
                
                //   print("Retrieved All hidden Games: \(DeletedGameIDs)")
                
                
              // self.GetMyTurns()
            
            
                
                backgroundThread(background: {
                    //self.GetPublicTurns()
                    self.GetMyTurns()
                    }, completion: {
                        // print("Done Getting Steal Turns")
                        DispatchQueue.main.async(execute: {
                            print("Reloading My Turns from View will appear")
                        self.kolodaView.resetCurrentCardNumber()
                        })
                })
            
            
        
            
        //    }
            // self.TableView.reloadData()
            //   actInd.stopAnimating()
          //  dispatch_async(dispatch_get_main_queue(), {
              //  print("Game Serach Array on My Turns View = \(self.MyTurnSearchArray)")
              //  var gametype = self.GameSearchArray[0]
             //   let datatemp = NSData(contentsOfURL: NSURL(string: gametype.TheMediaType)!)

              //  self.CurrentImage = UIImage(data: datatemp!)!
                    
              //  self.kolodaView.resetCurrentCardNumber()
           // })
      //  }
        
            
            
            backgroundThread(background: {
                //self.GetPublicTurns()
                print("Starting to get Completed Game Count")
                let GameCompletdData = MyTurnsCount(self.username, userID: self.userID)
                
                //self.GetMyTurns()
                }, completion: {
                    // print("Done Getting Steal Turns")
                    DispatchQueue.main.async(execute: {
                        
                        
                        print("Completed Data retrieved Refreshing Completed Games Now!!!!!!")
                        
                        let numBadges = self.prefs.integer(forKey: "numTurns")
                        let completedGames = self.prefs.integer(forKey: "comGames")
                        // navigationController!.tabBarItem.badgeValue = numBadges.description
                        let tabArray = self.tabBarController?.tabBar.items as NSArray!
                        let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
                        let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
                        
                        print("NUMBER OF TURNS AFTER BACKGROUND CHECK= \(numBadges)")
                        
                        if numBadges > 0 {
                            TurnItem.badgeValue = numBadges.description
                        }
                        
                        if completedGames > 0 {
                            CompletedItem.badgeValue = completedGames.description
                        }
                        
                        print("DONE Refreshing Completed Games!!!!!!!!")
                        
                        
                        
                        
                        // self.kolodaView.resetCurrentCardNumber()
                    })
            })
            
        
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.GetAllHUD.removeFromSuperview()
        self.GetStealHUD.removeFromSuperview()
        self.GetMyHUD.removeFromSuperview()
        
        
        
        ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        
        
        
        print("MY turns array count = \(MyTurnSearchArray.count)")
        print("Steal turns array = \(StealTurnSearchArray.count)")
        print("public turns array = \(PublicTurnSearchArray.count)")
        
        self.noView.alpha = 0.0
        self.yesView.alpha = 0.0
        
        self.undoView.alpha = 0.0
        self.refreshView.alpha = 0.0
        // kolodaView.resetCurrentCardNumber()
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.yesView.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.noView.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.undoView.alpha = 0.7
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.refreshView.alpha = 0.7
            
            }, completion: nil)
        
       //  self.kolodaView.resetCurrentCardNumber()
        
        
        
        
        if !ISLOGGEDIN {
            
 
            
        }  else {
            RefreshNow()
        }
        
        
        
    }
    
    /*
    override func viewDidAppear(animated: Bool) {
        //  actInd.startAnimating()
        
        
        
        
        
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            //self.refreshControl.enabled = false
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    // self.NoGamesLBL.hidden = true
                    // self.restartMyGames.hidden = true
                    // self.NoGamesLBL.text = "No User Is Signed In"
                    
                    //  self.actInd.stopAnimating()
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } else {
            
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GameCenterEnabled")
            
            
            
            
            // RemoveGameArrayData()
            
            // self.TableView.reloadData()
            
            //  print("game array = \(GameNameInfo)")
            
            
            
            
            //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if prefs.valueForKey("USERNAME") != nil {
                
                username = prefs.valueForKey("USERNAME") as! NSString as String
            } else  {
                username = "tempName"
            }
            
            if GamesAvailable {
                
                
                
            }
            
            //  DeletedGameIDs.removeAll()
            //  GetDeletedGamesData()
            
            
            //   print("Retrieved All hidden Games: \(DeletedGameIDs)")
            
            
            if Reachability.isConnectedToNetwork() {
                
                
                // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
                // view.addGestureRecognizer(tap)
                
                
                //println("Username value check: \(username)")
                
                // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    if self.prefs.valueForKey("USERNAME") != nil {
                        print("Loading Turn Info")
                        let URLData = GetUserGameData(self.username, userID: self.userID, type: self.SegmentValueString)
                        //println(test)
                        (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                        
                        // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                        
                        //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                        
                        if self.GameSearchArray.count < 1 {
                            // self.NoGamesLBL.hidden = false
                            //   self.restartMyGames.hidden = false
                            
                            print("showing no games label")
                        } else {
                            
                            print("hidding no games label")
                            //  self.NoGamesLBL.hidden = true
                            //  self.restartMyGames.hidden = true
                        }
                        
                        //println("Game Info: \(GameInfo)")
                        
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            //   self.AddGameArrayInfo(self.GameInfo)
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                //  self.TableView.reloadData()
                                //  self.actInd.stopAnimating()
                            })
                            
                            
                            
                        })
                        
                        
                        
                        //    print("Users turn info =\(self.UsersTurnInfo)")
                        //     print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        //print(GameNameInfo)
                        
                    } else {
                        
                        print("no games available")
                        
                    }
                    
                })
                
                
                
                
                
            }
                
            else
                
            {
                
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                
            }
            
        }
        // self.TableView.reloadData()
        //   actInd.stopAnimating()
         dispatch_async(dispatch_get_main_queue(), {
        print("Game Serach Array on My Turns View = \(self.GameSearchArray)")
        })
    }
    
    
    */
    func FilterMyTurnData(_ urlData: Data) -> [GameTypeSwipe] {
        
        //KolodaViewSegemnt = 0
        GameData.removeAll()
        GameSearchInfo.removeAll()
        MyTurnSearchArray.removeAll()
        MyTurnImages.removeAll()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        var json = JSON(jsonData)
        
        var MyTotalTurnsTemp = json["totalGames"].stringValue
        if MyTotalTurnsTemp == "" {
            MyTotalTurnsTemp = "0"
        }
        MyTotalTurns = Int(MyTotalTurnsTemp)!
        
        print("My Total Turns = \(MyTotalTurns.description)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                
                let gameID = result["id"].stringValue
              //  print("Found GameID = \(gameID)")
                
                // if DeletedGameIDs.!contains(gameID) {
                
                if 1 == 1 {
                    
                    //if !DeletedGameIDs.contains(gameID) {
                    
                    let gname = result["GameName"].stringValue
                //    print("Accepted GameID = \(gameID)")
                    
                    let player1 = result["User1"].stringValue
                    
                    let player2 = result["User2"].stringValue
                    
                    let player3 = result["User3"].stringValue
                    let player4 = result["User4"].stringValue
                    let player5 = result["User5"].stringValue
                    
                    let player6 = result["User6"].stringValue
                    
                    let player7 = result["User7"].stringValue
                    
                    let player8 = result["User8"].stringValue
                    let player9 = result["User9"].stringValue
                    let player10 = result["User10"].stringValue
                    
                    let player1ID = result["User1ID"].stringValue
                    
                    let player2ID = result["User2ID"].stringValue
                    
                    let player3ID = result["User3ID"].stringValue
                    let player4ID = result["User4ID"].stringValue
                    let player5ID = result["User5ID"].stringValue
                    
                    let player6ID = result["User6ID"].stringValue
                    
                    let player7ID = result["User7ID"].stringValue
                    
                    let player8ID = result["User8ID"].stringValue
                    let player9ID = result["User9ID"].stringValue
                    let player10ID = result["User10ID"].stringValue
                    
                    let isComplete = result["isComplete"].stringValue
                    let turnNumber = result["TurnNumber"].stringValue
                    let LastTurnTime = result["LastTurnTime"].stringValue
                    
                    
                    let TimeLimit = result["TimeLimit"].stringValue
                    let CanTakeTurn = result["CanTakeTurn"].stringValue
                    
                    let gameliketemp = result["GameLike"].stringValue
                    let gamefailtemp = result["GameFail"].stringValue
                    
                    
                  //  print("Can Take Turn = \(CanTakeTurn)")
                    
                    let GameStyle = result["gamestyle"].stringValue
                    let GameVisible1 = result["gameVisible"].stringValue
                    
                    var GameVisible = NSString()
                    
                    if GameVisible1 == "yes" {
                        GameVisible = "Public"
                    } else {
                        GameVisible = "Private"
                    }
                    
                    let GameSettingP = result["gameSetting"].stringValue
                    
                    let totalLikes = result["totalLikes"].stringValue
                    let commentTemp = result["comments"].stringValue
                    
                    let Turn1MediaType = result["turn1mediatype"].stringValue
                    
                    
                    let Turn1URLStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameID)Turn1"
                    
                    var Turn1URLString = String()
                    
                    switch Turn1MediaType {
                        
                    case "audio":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).mp3"
                        
                    case "image":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "quote":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "gif":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).gif"
                        
                        
                    default:
                        break
                    }
                    
                  //  print("Turn1MediaType = \(Turn1MediaType)")
                    
                    switch turnNumber
                    {
                    case "1":
                        LastTurnUser = player1 as NSString
                        TurnUser = player1 as NSString
                        TurnUserID = player1ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn1" as NSString
                        //TurnUser2 = "User1"
                    case "2":
                        LastTurnUser = player1 as NSString
                        TurnUser = player2 as NSString
                        TurnUserID = player2ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn2" as NSString
                    case "3":
                        LastTurnUser = player2 as NSString
                        TurnUser = player3 as NSString
                        TurnUserID = player3ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn3" as NSString
                    case "4":
                        LastTurnUser = player3 as NSString
                        TurnUser = player4 as NSString
                        TurnUserID = player4ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn4" as NSString
                    case "5":
                        LastTurnUser = player4 as NSString
                        TurnUser = player5 as NSString
                        TurnUserID = player5ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn5" as NSString
                    case "6":
                        LastTurnUser = player5 as NSString
                        TurnUser = player6 as NSString
                        TurnUserID = player6ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn6" as NSString
                    case "7":
                        LastTurnUser = player6 as NSString
                        TurnUser = player7 as NSString
                        TurnUserID = player7ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn7" as NSString
                    case "8":
                        LastTurnUser = player7 as NSString
                        TurnUser = player8 as NSString
                        TurnUserID = player8ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn8" as NSString
                    case "9":
                        LastTurnUser = player8 as NSString
                        TurnUser = player9 as NSString
                        TurnUserID = player9ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn9" as NSString
                    case "10":
                        LastTurnUser = player9 as NSString
                        TurnUser = player10 as NSString
                        TurnUserID = player10ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn10" as NSString
                    default:
                        LastTurnUser = player10 as NSString
                        TurnURLString = "NA"
                     //   print("Error")
                    }
                    
                    
                    let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
                    
                    let ContentRating = result["contentrating"].stringValue
                    let themediatype = result["theMediaType"].stringValue
                    
                    var mediaSuf = String()
                    
                    switch themediatype {
                    case "quote":
                        mediaSuf = "jpg"
                    case "image":
                        mediaSuf = "jpg"
                    case "gif":
                        mediaSuf = "gif"
                    case "audio":
                        mediaSuf = "mp3"
                        
                        
                    default:
                        break
                        
                        
                    }
                    
                    let lastTurn = Int(turnNumber)! - 1
                    
                    let MediaURLString = "\(self.ServerURL)Game\(gameID)Turn\(lastTurn).\(mediaSuf)"
                     print("Media URL String = \(MediaURLString)")
                    
                    if TurnUserID == self.userID {
                        
                        if isComplete == "yes" {
                            GameSearchInfo.append(GameTypeSwipe(GameCategory: "Complete", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                            //         GameSearchArray.append(GameType(category: "Complete", name: gname, turnUser: TurnUser as String))
                        } else {
                            
                            print("Adding in process games to My Turns")
                            
                            //    GameSearchArray.append(GameType(category: "In Process", name: gname, turnUser: TurnUser as String))
                            GameSearchInfo.append(GameTypeSwipe(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                            
                            
                        }
                        
                    }
                    
                    
                }
            }
            
        }
        
        print("My Turns count = \(GameSearchInfo.count)")
        
        let MyTurnCountTemp = GameSearchInfo.count
        
        UserDefaults.standard.set(MyTurnCountTemp, forKey: "numTurns")
        
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let TurnItem = tabArray?.object(at: 0) as! UITabBarItem
        let CompletedItem = tabArray?.object(at: 3) as! UITabBarItem
        
        //print("NUMBER OF TURNS = \(numBadges)")
        
        if MyTurnCountTemp > 0 {
            TurnItem.badgeValue = MyTurnCountTemp.description
        }
        
        
        /*
        for i in GameSearchInfo {
            // let gametype = GameTypeSwipe[i]
            //let gametype = i.The
            //let datatemp = NSData(contentsOfURL: NSURL(string: GameTypeSwipe[i.TheMediaType])!)
            if (NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)?.length)! > 0 {
                
                let datatemp = NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)
                self.MyTurnImages.append(UIImage(data: datatemp!)!)
            } else {
                self.MyTurnImages.append(UIImage(named: "noImage.png")!)
            }
            
            
        }
        
        */
        print("Images Count = \(MyTurnImages.count)")
        self.DidGetMyTurns = true
        return GameSearchInfo
        
    }
    func FilterPublicTurnData(_ urlData: Data) -> [GameTypeSwipe] {
        
        //KolodaViewSegemnt = 2
        GameData.removeAll()
        GameSearchInfo.removeAll()
        PublicTurnSearchArray.removeAll()
        PublicTurnImages.removeAll()
        
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        var json = JSON(jsonData)
        
        var MyTotalTurnsTemp = json["totalGames"].stringValue
        if MyTotalTurnsTemp == "" {
            MyTotalTurnsTemp = "0"
        }
        MyTotalTurns = Int(MyTotalTurnsTemp)!
        
        print("Total public Turns = \(MyTotalTurns.description)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                
                let gameID = result["id"].stringValue
              //  print("Found GameID = \(gameID)")
                
                // if DeletedGameIDs.!contains(gameID) {
                
                if 1 == 1 {
                    
                    //if !DeletedGameIDs.contains(gameID) {
                    
                    let gname = result["GameName"].stringValue
                  //  print("Accepted GameID = \(gameID)")
                    
                    let player1 = result["User1"].stringValue
                    
                    let player2 = result["User2"].stringValue
                    
                    let player3 = result["User3"].stringValue
                    let player4 = result["User4"].stringValue
                    let player5 = result["User5"].stringValue
                    
                    let player6 = result["User6"].stringValue
                    
                    let player7 = result["User7"].stringValue
                    
                    let player8 = result["User8"].stringValue
                    let player9 = result["User9"].stringValue
                    let player10 = result["User10"].stringValue
                    
                    let player1ID = result["User1ID"].stringValue
                    
                    let player2ID = result["User2ID"].stringValue
                    
                    let player3ID = result["User3ID"].stringValue
                    let player4ID = result["User4ID"].stringValue
                    let player5ID = result["User5ID"].stringValue
                    
                    let player6ID = result["User6ID"].stringValue
                    
                    let player7ID = result["User7ID"].stringValue
                    
                    let player8ID = result["User8ID"].stringValue
                    let player9ID = result["User9ID"].stringValue
                    let player10ID = result["User10ID"].stringValue
                    
                    let isComplete = result["isComplete"].stringValue
                    let turnNumber = result["TurnNumber"].stringValue
                    let LastTurnTime = result["LastTurnTime"].stringValue
                    
                    
                    let TimeLimit = result["TimeLimit"].stringValue
                    let CanTakeTurn = result["CanTakeTurn"].stringValue
                    
                    let gameliketemp = result["GameLike"].stringValue
                    let gamefailtemp = result["GameFail"].stringValue
                    
                    
                 //   print("Can Take Turn = \(CanTakeTurn)")
                    
                    let GameStyle = result["gamestyle"].stringValue
                    let GameVisible1 = result["gameVisible"].stringValue
                    
                    var GameVisible = NSString()
                    
                    if GameVisible1 == "yes" {
                        GameVisible = "Public"
                    } else {
                        GameVisible = "Private"
                    }
                    
                    let GameSettingP = result["gameSetting"].stringValue
                    
                    let totalLikes = result["totalLikes"].stringValue
                    let commentTemp = result["comments"].stringValue
                    
                    let Turn1MediaType = result["turn1mediatype"].stringValue
                    
                    
                    let Turn1URLStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameID)Turn1"
                    
                    var Turn1URLString = String()
                    
                    switch Turn1MediaType {
                        
                    case "audio":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).mp3"
                        
                    case "image":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "quote":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "gif":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).gif"
                        
                        
                    default:
                        break
                    }
                    
                   // print("Turn1MediaType = \(Turn1MediaType)")
                    
                    switch turnNumber
                    {
                    case "1":
                        LastTurnUser = player1 as NSString
                        TurnUser = player1 as NSString
                        TurnUserID = player1ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn1" as NSString
                        //TurnUser2 = "User1"
                    case "2":
                        LastTurnUser = player1 as NSString
                        TurnUser = player2 as NSString
                        TurnUserID = player2ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn2" as NSString
                    case "3":
                        LastTurnUser = player2 as NSString
                        TurnUser = player3 as NSString
                        TurnUserID = player3ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn3" as NSString
                    case "4":
                        LastTurnUser = player3 as NSString
                        TurnUser = player4 as NSString
                        TurnUserID = player4ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn4" as NSString
                    case "5":
                        LastTurnUser = player4 as NSString
                        TurnUser = player5 as NSString
                        TurnUserID = player5ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn5" as NSString
                    case "6":
                        LastTurnUser = player5 as NSString
                        TurnUser = player6 as NSString
                        TurnUserID = player6ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn6" as NSString
                    case "7":
                        LastTurnUser = player6 as NSString
                        TurnUser = player7 as NSString
                        TurnUserID = player7ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn7" as NSString
                    case "8":
                        LastTurnUser = player7 as NSString
                        TurnUser = player8 as NSString
                        TurnUserID = player8ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn8" as NSString
                    case "9":
                        LastTurnUser = player8 as NSString
                        TurnUser = player9 as NSString
                        TurnUserID = player9ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn9" as NSString
                    case "10":
                        LastTurnUser = player9 as NSString
                        TurnUser = player10 as NSString
                        TurnUserID = player10ID as NSString
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn10" as NSString
                    default:
                        LastTurnUser = player10 as NSString
                        TurnURLString = "NA"
                      //  print("Error")
                    }
                    
                    
                    let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
                    
                    let ContentRating = result["contentrating"].stringValue
                    let themediatype = result["theMediaType"].stringValue
                    
                    var mediaSuf = String()
                    
                    switch themediatype {
                    case "quote":
                        mediaSuf = "jpg"
                    case "image":
                        mediaSuf = "jpg"
                    case "gif":
                        mediaSuf = "gif"
                    case "audio":
                        mediaSuf = "mp3"
                        
                        
                    default:
                        break
                        
                        
                    }
                    
                    let lastTurn = Int(turnNumber)! - 1
                    
                    let MediaURLString = "\(self.ServerURL)Game\(gameID)Turn\(lastTurn).\(mediaSuf)"
                     print("Media URL String = \(MediaURLString)")
                    
                    if (GameSettingP == "public") {
                        
                        
                        if isComplete == "yes" {
                        
                        /*
                            GameSearchInfo.append(GameTypeSwipe(GameCategory: "Complete", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                            
                            */
                            //         GameSearchArray.append(GameType(category: "Complete", name: gname, turnUser: TurnUser as String))
                        } else {
                            
                            print("Adding in process games to publc turns")
                            
                            //    GameSearchArray.append(GameType(category: "In Process", name: gname, turnUser: TurnUser as String))
                            GameSearchInfo.append(GameTypeSwipe(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                            
                            
                        }
                        
                    }
                    
                    
                }
            }
            
        }
        
        
       /*
        for i in GameSearchInfo {
            // let gametype = GameTypeSwipe[i]
            //let gametype = i.The
            //let datatemp = NSData(contentsOfURL: NSURL(string: GameTypeSwipe[i.TheMediaType])!)
            if (NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)?.length)! > 0 {
                
                let datatemp = NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)
                self.PublicTurnImages.append(UIImage(data: datatemp!)!)
            } else {
                self.PublicTurnImages.append(UIImage(named: "noImage.png")!)
            }
            
            
        }
        
        */
        print("Images Count = \(PublicTurnImages.count)")
        self.DidGetPublicTurns = true
        return GameSearchInfo
        
    }
    
    func FilterStealTurnData(_ urlData: Data) -> [GameTypeSwipe] {
        
      //  KolodaViewSegemnt = 1
        GameData.removeAll()
        GameSearchInfo.removeAll()
        StealTurnSearchArray.removeAll()
        StealTurnImages.removeAll()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        

        var json = JSON(jsonData)
        
        var MyTotalTurnsTemp = json["totalGames"].stringValue
        if MyTotalTurnsTemp == "" {
            MyTotalTurnsTemp = "0"
        }
        MyTotalTurns = Int(MyTotalTurnsTemp)!
        
        print("Total Steal Turns = \(MyTotalTurns.description)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                
                let gameID = result["id"].stringValue
               // print("Found GameID = \(gameID)")
                
                // if DeletedGameIDs.!contains(gameID) {
                
                if 1 == 1 {
                    
                    //if !DeletedGameIDs.contains(gameID) {
                    
                    let gname = result["GameName"].stringValue
                  //  print("Accepted GameID = \(gameID)")
                    
                    let player1 = result["User1"].stringValue
                    
                    let player2 = result["User2"].stringValue
                    
                    let player3 = result["User3"].stringValue
                    let player4 = result["User4"].stringValue
                    let player5 = result["User5"].stringValue
                    
                    let player6 = result["User6"].stringValue
                    
                    let player7 = result["User7"].stringValue
                    
                    let player8 = result["User8"].stringValue
                    let player9 = result["User9"].stringValue
                    let player10 = result["User10"].stringValue
                    
                    let player1ID = result["User1ID"].stringValue
                    
                    let player2ID = result["User2ID"].stringValue
                    
                    let player3ID = result["User3ID"].stringValue
                    let player4ID = result["User4ID"].stringValue
                    let player5ID = result["User5ID"].stringValue
                    
                    let player6ID = result["User6ID"].stringValue
                    
                    let player7ID = result["User7ID"].stringValue
                    
                    let player8ID = result["User8ID"].stringValue
                    let player9ID = result["User9ID"].stringValue
                    let player10ID = result["User10ID"].stringValue
                    
                    let isComplete = result["isComplete"].stringValue
                    let turnNumber = result["TurnNumber"].stringValue
                    let LastTurnTime = result["LastTurnTime"].stringValue
                    
                    
                    let TimeLimit = result["TimeLimit"].stringValue
                    let CanTakeTurn = result["CanTakeTurn"].stringValue
                    
                    let gameliketemp = result["GameLike"].stringValue
                    let gamefailtemp = result["GameFail"].stringValue
                    
                    
                  //  print("Can Take Turn = \(CanTakeTurn)")
                    
                    let GameStyle = result["gamestyle"].stringValue
                    let GameVisible1 = result["gameVisible"].stringValue
                    
                    var GameVisible = NSString()
                    
                    if GameVisible1 == "yes" {
                        GameVisible = "Public"
                    } else {
                        GameVisible = "Private"
                    }
                    
                    let GameSettingP = result["gameSetting"].stringValue
                    
                    let totalLikes = result["totalLikes"].stringValue
                    let commentTemp = result["comments"].stringValue
                    
                    let Turn1MediaType = result["turn1mediatype"].stringValue
                    
                    
                    let Turn1URLStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(gameID)Turn1"
                    
                    var Turn1URLString = String()
                    
                    switch Turn1MediaType {
                        
                    case "audio":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).mp3"
                        
                    case "image":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "quote":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).jpg"
                        
                    case "gif":
                        
                        Turn1URLString = "\(Turn1URLStringTemp).gif"
                        
                        
                    default:
                        break
                    }
                    
                 //   print("Turn1MediaType = \(Turn1MediaType)")
                    
                    var NextTurnUserID = String()
                    var LastTurnUserID = String()
                    
                    switch turnNumber
                    {
                    case "1":
                        LastTurnUser = player1 as NSString
                        
                        TurnUser = player1 as NSString
                        TurnUserID = player1ID as NSString
                        LastTurnUserID = player1ID
                        NextTurnUserID = player2ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn1" as NSString
                        //TurnUser2 = "User1"
                    case "2":
                        LastTurnUser = player1 as NSString
                        TurnUser = player2 as NSString
                        TurnUserID = player2ID as NSString
                        LastTurnUserID = player1ID
                        NextTurnUserID = player3ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn2" as NSString
                    case "3":
                        LastTurnUser = player2 as NSString
                        TurnUser = player3 as NSString
                        TurnUserID = player3ID as NSString
                        
                        LastTurnUserID = player2ID
                        NextTurnUserID = player4ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn3" as NSString
                    case "4":
                        LastTurnUser = player3 as NSString
                        TurnUser = player4 as NSString
                        TurnUserID = player4ID as NSString
                        
                        LastTurnUserID = player3ID
                        NextTurnUserID = player5ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn4" as NSString
                    case "5":
                        LastTurnUser = player4 as NSString
                        TurnUser = player5 as NSString
                        TurnUserID = player5ID as NSString
                        LastTurnUserID = player4ID
                        NextTurnUserID = player6ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn5" as NSString
                    case "6":
                        LastTurnUser = player5 as NSString
                        TurnUser = player6 as NSString
                        TurnUserID = player6ID as NSString
                        LastTurnUserID = player5ID
                        NextTurnUserID = player7ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn6" as NSString
                    case "7":
                        LastTurnUser = player6 as NSString
                        TurnUser = player7 as NSString
                        TurnUserID = player7ID as NSString
                        LastTurnUserID = player6ID
                        NextTurnUserID = player8ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn7" as NSString
                    case "8":
                        LastTurnUser = player7 as NSString
                        TurnUser = player8 as NSString
                        TurnUserID = player8ID as NSString
                        LastTurnUserID = player7ID
                        NextTurnUserID = player9ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn8" as NSString
                    case "9":
                        LastTurnUser = player8 as NSString
                        TurnUser = player9 as NSString
                        TurnUserID = player9ID as NSString
                        LastTurnUserID = player8ID
                        NextTurnUserID = player10ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn9" as NSString
                    case "10":
                        LastTurnUser = player9 as NSString
                        TurnUser = player10 as NSString
                        TurnUserID = player10ID as NSString
                        LastTurnUserID = player9ID
                        NextTurnUserID = player10ID
                        TurnURLString = "\(ServerURL)Game\(gameID)Turn10" as NSString
                    default:
                        LastTurnUser = player10 as NSString
                        TurnURLString = "NA"
                     //   print("Error")
                    }
                    
                    
                    let theSearchString = "\(player1) \(player2) \(player3) \(player4) \(player5) \(player6) \(player7) \(player8) \(player9) \(player10) \(gname)"
                    
                    let ContentRating = result["contentrating"].stringValue
                    let themediatype = result["theMediaType"].stringValue
                    
                    var mediaSuf = String()
                    
                    switch themediatype {
                    case "quote":
                        mediaSuf = "jpg"
                    case "image":
                        mediaSuf = "jpg"
                    case "gif":
                        mediaSuf = "gif"
                    case "audio":
                        mediaSuf = "mp3"
                        
                        
                    default:
                        break
                        
                        
                    }
                    
                    let lastTurn = Int(turnNumber)! - 1
                    
                    let MediaURLString = "\(self.ServerURL)Game\(gameID)Turn\(lastTurn).\(mediaSuf)"
                    
                    print("Media URL String = \(MediaURLString)")
                    
                    if ((userID as String != LastTurnUserID) || (userID as String != NextTurnUserID)) && (NextTurnUserID != "OPEN") {
                    
                    if isComplete == "yes" {
                        
                        /*
                        GameSearchInfo.append(GameTypeSwipe(GameCategory: "Complete", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                        
                        */
                        //         GameSearchArray.append(GameType(category: "Complete", name: gname, turnUser: TurnUser as String))
                    } else {
                        
                        print("Adding in process games to Steal Turns")
                        
                        //    GameSearchArray.append(GameType(category: "In Process", name: gname, turnUser: TurnUser as String))
                        GameSearchInfo.append(GameTypeSwipe(GameCategory: "In Process", GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTurnNumber: turnNumber, GameIsComplete: isComplete, GameUsersTurn: TurnUser as String, GameLastTurnTime: LastTurnTime, GameTimeLimit: TimeLimit, GameCanTakeTurn: CanTakeTurn, GameGameStyle: GameStyle, GameGameVisible: GameVisible as String, GameTotalLikes: totalLikes, GameCommentInfo: commentTemp, GameGameLikeArray: gameliketemp, GameGameFailArray: gamefailtemp, GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameUsersTurnID: TurnUserID as String, GameContent: ContentRating, GameSearchString: theSearchString, Turn1MediaType: Turn1MediaType, Turn1URLString: Turn1URLString, LastTurnUser: LastTurnUser as String, GameSetting: GameSettingP, TurnURL: TurnURLString as String, TheMediaType: MediaURLString))
                        
                        
                    }

                    }
                   
                    
                }
            }
            
        }
        
        
        /*
        for i in GameSearchInfo {
           // let gametype = GameTypeSwipe[i]
            //let gametype = i.The
            //let datatemp = NSData(contentsOfURL: NSURL(string: GameTypeSwipe[i.TheMediaType])!)
            if (NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)?.length)! > 0 {

            let datatemp = NSData(contentsOfURL: NSURL(string: i.TheMediaType)!)
              self.StealTurnImages.append(UIImage(data: datatemp!)!)
            } else {
              self.StealTurnImages.append(UIImage(named: "noImage.png")!)
            }
        
            
        }
        */
        /*
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: gametype.Turn1URLString)!)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                var image = UIImage(data: data!)
                // Store the imge in to our cache
                //  self.imageCache[urlString] = image
                // Update the cell
                dispatch_async(dispatch_get_main_queue(), {
                    //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                    //if let cellToUpdate = TableView.cel
                    if let cellToUpdate = self.TableView.cellForRowAtIndexPath(indexPath) {
                        
                        if gametype.theMediaType == "gif" {
                            //image
                        } else if gametype.theMediaType == "image" {
                            
                            //image
                            
                        } else {
                            
                            
                            
                           // image
                            
                        }
                      // image
                    }
                })
            }
            else {
                
               
                
                print("Error: \(error!.localizedDescription)")
            }
        })
        
        */
        
        
       print("Images Count = \(StealTurnImages.count)")
        self.DidGetStealTurns = true
        return GameSearchInfo
        
    }
    
    
    
    func fileExists(_ url : URL!) -> Bool {
        
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "HEAD"
        req.timeoutInterval = 1.0 // Adjust to your needs
        
        var response : URLResponse?
        var responseError: NSError?
        
        do {
            try NSURLConnection.sendSynchronousRequest(req as URLRequest, returning:&response)
        } catch let error as NSError {
            responseError = error
            // urlData = nil
        }
        
        //NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: nil)
        
        return ((response as? HTTPURLResponse)?.statusCode ?? -1) == 200
    }
    
    
    func LoadTurnImage(_ URLString: String, index: UInt) -> UIImage {
        
        var theImage = UIImage()
        
        var request: URLRequest!
        
        let requestJPG = URL(string: "\(URLString).jpg")!
        let requestGIF = URL(string: "\(URLString).gif")!
        let requestMP3 = URL(string: "\(URLString).mp3")!
        
        var loadImage = Bool()
        
        if fileExists(requestJPG) {
            print("JPG exists")
            request = URLRequest(url: requestJPG)
            loadImage = true
        } else if fileExists(requestGIF) {
            print("gif exists")
            request = URLRequest(url: requestGIF)
            loadImage = true
        } else if fileExists(requestMP3) {
            print("mp3 exists")
            request = URLRequest(url: requestMP3)
            loadImage = true
        } else {
            print("no file exists at the url \(URLString)")
            loadImage = false
        }
        
        
        
        
        // let request: NSURLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
        
        if loadImage {
            
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the imge in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    DispatchQueue.main.async(execute: {
                        
                        theImage = image!
                        // if let cellToUpdate = self.
                        
                    })
                } else {
                    
                    theImage = UIImage(named: "noImage.png")!
                    
                    print("Error: \(error!.localizedDescription)")
                }
            })
            
            
            
        } else {
            theImage = UIImage(named: "noImage.png")!
        }
        return theImage
    }
    
  
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.right)
        
        GameNameInfoBTN = GameNameInfoBTNTwo
        GameIDInfoBTN = GameIDInfoBTNTwo
        TurnNumberInfoBTN = TurnNumberInfoBTNTwo
        IsCompleteInfoBTN = IsCompleteInfoBTNTwo
        GameStyleInfoBTN = GameStyleInfoBTNTwo
        CanTakeTurnInfoBTN = CanTakeTurnInfoBTNTwo
        CurrentUserInfoBTN = CurrentUserInfoBTNTwo
        NumComments = NumCommentsTwo
        theContent = theContentTwo
        
        self.performSegue(withIdentifier: "TakeTurn", sender: self)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    
    func RefreshNow() {
        
        
        self.view.addSubview(self.GetMyHUD)
        
        DispatchQueue.main.async(execute: {
            
            self.MyTurnSearchArray.removeAll()
            self.StealTurnSearchArray.removeAll()
            self.PublicTurnSearchArray.removeAll()
            self.DidGetMyTurns = false
            //LoadMyTurns()
            
            
            
            self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            self.taketurnLBL.text = "Take Turn!"
            
            
            print("Loading My Turns")
            if self.DidGetMyTurns {
                self.KolodaViewSegemnt = 0
                self.kolodaView.resetCurrentCardNumber()
                self.DidGetMyTurns = false
            } else {
                self.KolodaViewSegemnt = 0
                
                
                /*
                self.backgroundThread(background: {
                    //self.GetPublicTurns()
                    self.GetMyTurns()
                    }, completion: {
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.GetMyHUD.removeFromSuperview()
                            //  self.tableView.reloadData()
                        })
                        // print("Done Getting Steal Turns")
                        //   self.kolodaView.resetCurrentCardNumber()
                })
                
                */
                
                 self.GetMyTurns()
                
                DispatchQueue.main.async(execute: {
                    self.GetMyHUD.removeFromSuperview()
                    //  self.tableView.reloadData()
                    
                    self.kolodaView.resetCurrentCardNumber()
                })

                
            }
            
            /*
            
            dispatch_async(dispatch_get_main_queue(), {
                print("Reloading My Turns from View will appear")
                self.kolodaView.resetCurrentCardNumber()
            })
            */

            /*
            backgroundThread(background: {
            //self.GetPublicTurns()
            self.GetMyTurns()
            }, completion: {
            // print("Done Getting Steal Turns")
            dispatch_async(dispatch_get_main_queue(), {
            print("Reloading My Turns from View will appear")
            self.kolodaView.resetCurrentCardNumber()
            })
            })
            */
        })
        
        
       
        
    }
    
    @IBAction func RefreshButtonTapped() {
       // kolodaView?.revertAction()
        
        
        
        RefreshNow()
        
        
        
    }
    
    @IBAction func backBTN(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    struct GameTypeSwipe {
        let GameCategory : String
        let GameName : String
        let GameID : String
        let GamePlayer1 : String
        let GamePlayer2 : String
        let GamePlayer3 : String
        let GamePlayer4 : String
        let GamePlayer5 : String
        let GamePlayer6 : String
        let GamePlayer7 : String
        let GamePlayer8 : String
        let GamePlayer9 : String
        let GamePlayer10 : String
        let GameTurnNumber : String
        let GameIsComplete : String
        let GameUsersTurn : String
        let GameLastTurnTime : String
        let GameTimeLimit : String
        let GameCanTakeTurn : String
        let GameGameStyle : String
        let GameGameVisible : String
        let GameTotalLikes : String
        let GameCommentInfo : String
        let GameGameLikeArray : String
        let GameGameFailArray : String
        let GamePlayer1ID : String
        let GamePlayer2ID : String
        let GamePlayer3ID : String
        let GamePlayer4ID : String
        let GamePlayer5ID : String
        let GamePlayer6ID : String
        let GamePlayer7ID : String
        let GamePlayer8ID : String
        let GamePlayer9ID : String
        let GamePlayer10ID : String
        let GameUsersTurnID : String
        let GameContent : String
        let GameSearchString : String
        let Turn1MediaType: String
        let Turn1URLString: String
        let LastTurnUser: String
        let GameSetting: String
        let TurnURL: String
        let TheMediaType: String
    }
    
    func LoadStealTurns() {
        
        self.view.addSubview(self.GetStealHUD)
        
      
        
        print("Loading Steal Turns")
        if DidGetStealTurns {
            KolodaViewSegemnt = 1
            self.kolodaView.resetCurrentCardNumber()
            DidGetStealTurns = false
        } else {
            KolodaViewSegemnt = 1
            backgroundThread(background: {
                //self.GetPublicTurns()
                self.GetStealTurns()
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        self.GetStealHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    // print("Done Getting Steal Turns")
                  //  self.kolodaView.resetCurrentCardNumber()
            })
        }
    }
    
    func LoadPublicTurns() {
        
        
        self.view.addSubview(self.GetAllHUD)
        
        
        
       print("Loading Public Turns")
        if DidGetPublicTurns {
            KolodaViewSegemnt = 2
            self.kolodaView.resetCurrentCardNumber()
            DidGetPublicTurns = false
        } else {
            KolodaViewSegemnt = 2
            backgroundThread(background: {
                //self.GetPublicTurns()
                self.GetPublicTurns()
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        self.GetAllHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    // print("Done Getting Steal Turns")
                 //   self.kolodaView.resetCurrentCardNumber()
            })
        }
    }
    
    func LoadMyTurns() {
        
        
        self.view.addSubview(self.GetMyHUD)
      
        
   print("Loading My Turns")
        if DidGetMyTurns {
            KolodaViewSegemnt = 0
            self.kolodaView.resetCurrentCardNumber()
         DidGetMyTurns = false
        } else {
            KolodaViewSegemnt = 0
            
            backgroundThread(background: {
                //self.GetPublicTurns()
                self.GetMyTurns()
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        self.GetMyHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    // print("Done Getting Steal Turns")
                 //   self.kolodaView.resetCurrentCardNumber()
            })
            
            
            
        }
    }
    
    func GetStealTurns() {
        print("Getting Steal Turns")
        
        /*
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
        // do some task
        dispatch_async(dispatch_get_main_queue()) {
        // update some UI
        }
        }
        
        requestImage("") { (image) -> Void in
        let myImage = image
        }
        */
        
        self.StealTurnSearchArray.removeAll()
        
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            
            //println("Username value check: \(username)")
            
            // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
            DispatchQueue.main.async(execute: {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    print("Loading Turn Info")
                    let URLData = GetUserGameData(self.username, userID: self.userID, type: "All")
                    //println(test)
                    self.StealTurnSearchArray = self.FilterStealTurnData(URLData)
                    
                    // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                    
                    //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                    
                    if self.StealTurnSearchArray.count < 1 {
                        // self.NoGamesLBL.hidden = false
                        //   self.restartMyGames.hidden = false
                        
                        print("showing no games label")
                    } else {
                        
                        print("hidding no games label Steal Turns")
                        //  self.NoGamesLBL.hidden = true
                        //  self.restartMyGames.hidden = true
                    }
                    
                    //println("Game Info: \(GameInfo)")
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.KolodaViewSegemnt = 1
                        //   self.AddGameArrayInfo(self.GameInfo)
                        
                        DispatchQueue.main.async(execute: {
                            self.kolodaView.resetCurrentCardNumber()
                            //  self.TableView.reloadData()
                            //  self.actInd.stopAnimating()
                        })
                        
                        
                        
                    })
                    
                    
                    
                    //    print("Users turn info =\(self.UsersTurnInfo)")
                    //     print("Users turn ID info =\(self.UsersTurnIDInfo)")
                    //print(GameNameInfo)
                    
                } else {
                    
                    print("no games available")
                    
                }
                
            })
            
            backgroundThread(background: {
                //self.GetPublicTurns()
                }, completion: {
                    
                    
                    if self.StealTurnSearchArray.count < 1 {
                        // self.NoGamesLBL.hidden = false
                        //   self.restartMyGames.hidden = false
                        self.GetStealTurns()
                        print("No Steal Turns available")
                    }
                   // print("Done Getting Steal Turns")
            })

            
            //self.GetPublicTurns()
            
        }
            
        else
            
        {
            
            
            SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        }
        
    }
    
    func GetPublicTurns() {
        print("Getting public Turns")
        /*
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
            }
        }
        
        requestImage("") { (image) -> Void in
            let myImage = image
        }
        */
        
        self.StealTurnSearchArray.removeAll()
        
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            
            //println("Username value check: \(username)")
            
            // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
            DispatchQueue.main.async(execute: {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    print("Loading Turn Info")
                    let URLData = GetUserGameData(self.username, userID: self.userID, type: "public")
                    //println(test)
                    self.PublicTurnSearchArray = self.FilterPublicTurnData(URLData)
                    
                    // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                    
                    //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                    
                    if self.PublicTurnSearchArray.count < 1 {
                        // self.NoGamesLBL.hidden = false
                        //   self.restartMyGames.hidden = false
                        
                        print("showing no games label")
                    } else {
                        
                        print("hidding no games label Steal")
                        //  self.NoGamesLBL.hidden = true
                        //  self.restartMyGames.hidden = true
                    }
                    
                    //println("Game Info: \(GameInfo)")
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.KolodaViewSegemnt = 2
                        //   self.AddGameArrayInfo(self.GameInfo)
                        
                        DispatchQueue.main.async(execute: {
                           self.kolodaView.resetCurrentCardNumber()
                            //  self.TableView.reloadData()
                            //  self.actInd.stopAnimating()
                        })
                        
                        
                        
                    })
                    
                    
                    
                    //    print("Users turn info =\(self.UsersTurnInfo)")
                    //     print("Users turn ID info =\(self.UsersTurnIDInfo)")
                    //print(GameNameInfo)
                    
                } else {
                    
                    print("no games available")
                    
                }
                
            })
            
            let priority = DispatchQueue.GlobalQueuePriority.default
            DispatchQueue.global(priority: priority).async {
                // do some task
               // self.GetMyTurns()
                DispatchQueue.main.async {
                    // update some UI
                }
            }
           
        //    self.GetMyTurns()
            
            
            
        }
            
        else
            
        {
            
            
            SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        }
        
    }
        
        
    func GetMyTurns() {
        print("Getting My Turns Turns")
        self.MyTurnSearchArray.removeAll()
        
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            
            //println("Username value check: \(username)")
            
            // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
            DispatchQueue.main.async(execute: {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    print("Loading Turn Info")
                    let URLData = GetUserGameData(self.username, userID: self.userID, type: "My Turns")
                    //println(test)
                    self.MyTurnSearchArray = self.FilterMyTurnData(URLData)
                    
                    // print("GameSearchArray: \(self.GameSearchArray[0].GameName)")
                    
                    //  print("Game Search Info Count = \(self.GameSearchArray.count)")
                    
                    if self.MyTurnSearchArray.count < 1 {
                        // self.NoGamesLBL.hidden = false
                        //   self.restartMyGames.hidden = false
                        
                        print("showing no games label")
                    } else {
                        
                        print("hidding no games label my turns")
                        //  self.NoGamesLBL.hidden = true
                        //  self.restartMyGames.hidden = true
                    }
                    
                    //println("Game Info: \(GameInfo)")
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        //   self.AddGameArrayInfo(self.GameInfo)
                        //self.kolodaView.resetCurrentCardNumber()
                        DispatchQueue.main.async(execute: {
                            
                            //  self.TableView.reloadData()
                            //  self.actInd.stopAnimating()
                        })
                        
                        
                        
                    })
                    
                    
                    
                    //    print("Users turn info =\(self.UsersTurnInfo)")
                    //     print("Users turn ID info =\(self.UsersTurnIDInfo)")
                    //print(GameNameInfo)
                    
                } else {
                    
                    print("no games available")
                    
                }
                
            })
            
            backgroundThread(background: {
            //self.GetStealTurns()
                }, completion: {
            print("Done Getting Steal Turns")
                    
                    if self.MyTurnSearchArray.count < 1 {
                        // self.NoGamesLBL.hidden = false
                        //   self.restartMyGames.hidden = false
                        self.GetStealTurns()
                        print("No My Turns available")
                    }
                    
                    
            })
          //self.GetStealTurns()
            
            
        }
            
        else
            
        {
            
            
            SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        }
        
    }
    
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TakeTurn" {
            
            if let destination = segue.destination as? GameViewController {
                
                destination.GameName = GameNameInfoBTN
                destination.GameID = GameIDInfoBTN
                destination.CurrentTurn = TurnNumberInfoBTN
                destination.IsComplete = IsCompleteInfoBTN
                destination.GameStyle = GameStyleInfoBTN
                destination.IsTurnAvailable = CanTakeTurnInfoBTN
                
                destination.CurrentUser = CurrentUserInfoBTN
                
                destination.NumComments = NumComments
                
                destination.ContentRating = theContent
                
                //destination.NumComments = NumComments
               // destination.GameID = GameSelected
              //  destination.GameNameSelected = GameNameInfoBTN
                //destination.ReplyUser = username
                //destination.ReplyUserID = userID
                //                    destination.Reply
                
            }
            
        }
        
        if segue.identifier == "login" {
            if let destination = segue.destination as? LoginViewController {
                destination.FromMyTurns = true
            }
        }
        
    }
    
    
    func backgroundThread(_ delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
       // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
          DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if(background != nil){ background!(); }
            
            let popTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    
    @objc func pokePlayerClicked(_ sender: UIButton!) {
       let  GameRowSelected = sender.tag
        let DeviceTKN = "FIND"
        let TurnInfoTest = "Test"
        
        var gametype : GameTypeSwipe?
        
        switch KolodaViewSegemnt {
            
            
        case 0:
            gametype = MyTurnSearchArray[GameRowSelected]
        case 1:
            gametype = StealTurnSearchArray[GameRowSelected]
        case 2:
            gametype = PublicTurnSearchArray[GameRowSelected]
            // return UInt(MyTurnImages.count)
            
        default:
            gametype = PublicTurnSearchArray[GameRowSelected]
            //self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
            // self.taketurnLBL.text = "Take Turn!"
            //return 0
        }
        
        GameSelected = gametype!.GameID as NSString
        
        GameSelected =  gametype!.GameID as NSString
        GameIDInfoBTN = gametype!.GameID as NSString
        TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
        IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
        GameStyleInfoBTN = gametype!.GameGameStyle as NSString
        CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
        CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
        UserTurnIDInfoBTN = gametype!.GameUsersTurnID as NSString
        
        
        
        //let selectedResult = indexPath.item
        CurrentTurn = gametype!.GameTurnNumber as NSString
        
        
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Soft Poke") {
            let AlertType = "pokeSoft"
            
            SendTurnNotice(TurnInfoTest as NSString, token: DeviceTKN as NSString, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType as NSString, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        theAlert.addButton("Medium Poke") {
            let AlertType = "pokeMedium"
            
            SendTurnNotice(TurnInfoTest as NSString, token: DeviceTKN as NSString, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType as NSString, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        theAlert.addButton("Hard Poke") {
            let AlertType = "pokeHard"
            
            SendTurnNotice(TurnInfoTest as NSString, token: DeviceTKN as NSString, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType as NSString, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN, myID: self.userID)
        }
        
        
        
        
        theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poke Player?", subTitle: "How hard would you like to them?", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
    }
    
}

//MARK: KolodaViewDelegate
extension SwipeTurnBackgroundViewController: KolodaViewDelegate {
    
    
    func koloda(_ koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
        
        print("Swiped card in direction \(direction)")
        
        
        var gametype : GameTypeSwipe?
        
        switch KolodaViewSegemnt {
            
            
        case 0:
            gametype = MyTurnSearchArray[Int(index)]
        case 1:
            gametype = StealTurnSearchArray[Int(index)]
        case 2:
            gametype = PublicTurnSearchArray[Int(index)]
            // return UInt(MyTurnImages.count)
            
        default:
            gametype = PublicTurnSearchArray[Int(index)]
            //self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
            // self.taketurnLBL.text = "Take Turn!"
            //return 0
        }

        
        GameNameInfoBTN = gametype!.GameName as NSString
        GameIDInfoBTN = gametype!.GameID as NSString
        TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
        IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
        GameStyleInfoBTN = gametype!.GameGameStyle as NSString
        CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
        
        CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
        
        NumComments = gametype!.GameCommentInfo as NSString
        
        theContent = gametype!.GameContent as NSString
        
        
        switch direction {
            
            
        case SwipeResultDirection.right:

        DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "TakeTurn", sender: self)
        })
            
            
        case SwipeResultDirection.left:
            print("Do nothing")
            
            
        default:
            break
        }
        
        /*
        if index >= 3 {
            numberOfCards = 6
            kolodaView.reloadData()
        }
        
        */
    }
    
    
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        print("Reset cards Start, KolodaViewSegment = \(KolodaViewSegemnt)")
        
        switch KolodaViewSegemnt {
       
          
        case 0:
            KolodaViewSegemnt = 1
           // return UInt(StealTurnImages.count)
            self.LoadStealTurns()
            self.yesView.layer.backgroundColor =  UIColor.orange.cgColor
            self.taketurnLBL.text = "Steal Turn!"
        case 1:
            KolodaViewSegemnt = 2
            self.LoadPublicTurns()
           // return UInt(PublicTurnImages.count)
            self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            self.taketurnLBL.text = "Take Turn!"
        case 2:
            // return UInt(MyTurnImages.count)
            self.KolodaViewSegemnt = 0
            self.LoadMyTurns()
            self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            self.taketurnLBL.text = "Take Turn!"
        default:
            self.KolodaViewSegemnt = 0
            self.LoadPublicTurns()
            self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            self.taketurnLBL.text = "Take Turn!"
            //return 0
        }
        
        print("Reset cards End, KolodaViewSegment = \(KolodaViewSegemnt)")
        DispatchQueue.main.async(execute: {
        self.kolodaView.resetCurrentCardNumber()
        })
        
        
        
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        
        var gametype : GameTypeSwipe?
        
        switch KolodaViewSegemnt {
            
            
        case 0:
            gametype = MyTurnSearchArray[Int(index)]
        case 1:
            gametype = StealTurnSearchArray[Int(index)]
        case 2:
            gametype = PublicTurnSearchArray[Int(index)]
            // return UInt(MyTurnImages.count)
           
        default:
            gametype = PublicTurnSearchArray[Int(index)]
            //self.yesView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
           // self.taketurnLBL.text = "Take Turn!"
            //return 0
        }

        
        
        
        GameNameInfoBTN = gametype!.GameName as NSString
        GameIDInfoBTN = gametype!.GameID as NSString
        TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
        IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
        GameStyleInfoBTN = gametype!.GameGameStyle as NSString
        CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
        
        CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
        
        NumComments = gametype!.GameCommentInfo as NSString
        
        theContent = gametype!.GameContent as NSString
        
        DispatchQueue.main.async(execute: {
        self.performSegue(withIdentifier: "TakeTurn", sender: self)
        })
        
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func koloda(kolodaShouldApplyAppearAnimation koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaShouldMoveBackgroundCard koloda: KolodaView) -> Bool {
        return false
    }
    
    func koloda(kolodaShouldTransparentizeNextCard koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

//MARK: KolodaViewDataSource
extension SwipeTurnBackgroundViewController: KolodaViewDataSource {
    
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
       
        //print("Game Search Array Count  \(UInt(GameSearchArray.count))")
        //return numberOfCards
        //return UInt(GameSearchArray.count)
        
        switch KolodaViewSegemnt {
        case 0:
            
            return UInt(MyTurnSearchArray.count)
            /*
            if (MyTurnImages.count == 0) {
                self.KolodaViewSegemnt = 1
                //kolodaView.resetCurrentCardNumber()
                return 0
            } else {
                return UInt(MyTurnImages.count)
            }
            */
        case 1:
            return UInt(StealTurnSearchArray.count)
            /*
            if (StealTurnImages.count == 0) {
                self.KolodaViewSegemnt = 2
              //  kolodaView.resetCurrentCardNumber()
              return 0
            } else {
            return UInt(StealTurnImages.count)
            }
            
            */
        case 2:
            return UInt(PublicTurnSearchArray.count)
            /*
            if (PublicTurnImages.count == 0) {
                self.KolodaViewSegemnt = 0
            //  kolodaView.resetCurrentCardNumber()
              return 0
            } else {
                return UInt(PublicTurnImages.count)
            }
            */
        default:
            
           return 0
        }
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        var gametypeLast: GameTypeSwipe?
        var gametypeLastTwo: GameTypeSwipe?
        var gametype : GameTypeSwipe?
        var theImage = UIImage()
        
        
       // var TakeTurnButtonIndex = Int()
        
        //index - 2
        
        print("Current KolodaView Segment = \(KolodaViewSegemnt)")
        print("Current index = \(index.description)")
        switch KolodaViewSegemnt {
        case 0:
            
           // theImage = MyTurnImages[Int(index)]
            gametype = MyTurnSearchArray[Int(index)]
            if index > 0 {
            gametypeLast = self.MyTurnSearchArray[Int(index - 1)]
            gametypeLastTwo = self.MyTurnSearchArray[Int(index - 1)]
            } else {
             gametypeLast = MyTurnSearchArray[Int(index)]
            }
            
            if index > 1 {
                gametypeLastTwo = self.MyTurnSearchArray[Int(index - 2)]
            }
         
           // print("My Turn Search Array = \(MyTurnSearchArray)")
            print("My Turn Search Array count = \(MyTurnSearchArray.count)")
            
        case 1:
          //  theImage = StealTurnImages[Int(index)]
            gametype = StealTurnSearchArray[Int(index)]
             if index > 0 {
            gametypeLast = self.StealTurnSearchArray[Int(index - 1)]
            gametypeLastTwo = self.StealTurnSearchArray[Int(index - 1)]
             } else {
              gametypeLast = StealTurnSearchArray[Int(index)]
            }
            
            if index > 1 {
                gametypeLastTwo = self.StealTurnSearchArray[Int(index - 2)]
            }

            
          //  print("My Turn Search Array = \(StealTurnSearchArray)")
            print("Steal Turn Search Array count = \(StealTurnSearchArray.count)")
        case 2:
         //   theImage = PublicTurnImages[Int(index)]
            gametype = PublicTurnSearchArray[Int(index)]
            
            if index > 0 {
            gametypeLast = self.PublicTurnSearchArray[Int(index - 1)]
            gametypeLastTwo = self.PublicTurnSearchArray[Int(index - 1)]
            } else {
            gametypeLast = PublicTurnSearchArray[Int(index)]
            }
            
            if index > 1 {
                 gametypeLastTwo = self.PublicTurnSearchArray[Int(index - 2)]
            }
            
         //   print("My Turn Search Array = \(PublicTurnSearchArray)")
            print("Public Turn Search Array count = \(PublicTurnSearchArray.count)")
            
        default:
          //  theImage = PublicTurnImages[Int(index)]
            gametype = PublicTurnSearchArray[Int(index)]
            
            if index > 0 {
            gametypeLast = self.PublicTurnSearchArray[Int(index - 2)]
            gametypeLastTwo = self.PublicTurnSearchArray[Int(index - 2)]
            } else {
            gametypeLast = PublicTurnSearchArray[Int(index)]
            }
        }
        
        
        
        
        
        
        
        
        
        
       // let gametype: GameTypeSwipe = self.GameSearchArray[Int(index)]
      //  gametypeLast = self.MyTurnSearchArray[Int(index - 1)]

        
       // let url = NSURL(string: "\(self.ServerURL)Game\(gametype.GameID)Turn\(gametype.GameTurnNumber).\(mediaSuf)")

       // print("the Temp URL = \(urlTemp)")
        
      //  print("Game Search Array at Koloda View: \(self.GameSearchArray)")
        
        
        //let url = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game548Turn1.jpg")
        
       
        let data = try? Data(contentsOf: URL(string: gametype!.TheMediaType)!)
      
        
        
        let nextTurnView:TurnView = UINib(nibName: "TurnView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TurnView
        
        nextTurnView.titleView?.layer.masksToBounds = true
        nextTurnView.titleView?.clipsToBounds = true
        nextTurnView.gamebyView?.layer.masksToBounds = true
        nextTurnView.gamebyView?.clipsToBounds = true
        nextTurnView.nextPlayerView?.layer.masksToBounds = true
        nextTurnView.nextPlayerView?.clipsToBounds = true
        
        //nextTurnView.gamebySubView?.alpha = 0.7
        //nextTurnView.titleSubView?.alpha = 0.7
        nextTurnView.gamebySubView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        nextTurnView.titleSubView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        nextTurnView.nextPlayerSubView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        
        nextTurnView.GameTitle?.text = gametype!.GameName
        nextTurnView.GameByUser?.text = "By: \(gametype!.GamePlayer1)"
        
        nextTurnView.turnTypeBannerView?.layer.cornerRadius = 60
        nextTurnView.turnTypeBannerView?.layer.masksToBounds = true
        nextTurnView.turnTypeBannerView?.clipsToBounds = true
        nextTurnView.pokeBGView?.alpha = 0.5
        nextTurnView.pokeBTN.tag = Int(index)
        nextTurnView.pokeBTN.addTarget(self, action: #selector(SwipeTurnBackgroundViewController.pokePlayerClicked(_:)), for: .touchUpInside)
        
        switch KolodaViewSegemnt {
        case 0:
            nextTurnView.turnTypeBannerView.isHidden = true
            nextTurnView.turnBannerLBL?.text = "Your Turns!"
            nextTurnView.turnTypeBannerView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).cgColor
            nextTurnView.currentTurnUserLBL?.text = "It's your turn!"
            
            let request: URLRequest = URLRequest(url: URL(string: (gametype?.TheMediaType)!)!)
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the imge in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    DispatchQueue.main.async(execute: {
                        
                        
                        if ((gametype?.TheMediaType.range(of: ".gif")) != nil) {
                        nextTurnView.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                        } else {
                        
                        //= UIImage.animatedImageWithAnimatedGIFData(data!)
                        nextTurnView.TurnImage?.image = image
                            
                        }
                        
                        /*
                        
                        //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                        //if let cellToUpdate = TableView.cel
                        if let cellToUpdate = nextTurnView[index] {
                        
                        //cellForRowAtIndexPath(indexPath) {
                        
                        if gametype.theMediaType == "gif" {
                        //image
                        } else if gametype.theMediaType == "image" {
                        
                        nextTurnView.TurnImage?.image = image
                        
                        } else {
                        
                        
                        
                        nextTurnView.TurnImage?.image = image
                        
                        }
                        nextTurnView.TurnImage?.image = image
                        }
                        
                        */
                    })
                }
                else {
                    
                    nextTurnView.TurnImage?.image = UIImage(named: "noImage.png")!
                    
                    print("Error: \(error!.localizedDescription)")
                }
            })

            
            if index > 0 {
                
                
                
                GameNameInfoBTN = gametypeLast!.GameName as NSString
                GameIDInfoBTN = gametypeLast!.GameID as NSString
                TurnNumberInfoBTN = gametypeLast!.GameTurnNumber as NSString
                IsCompleteInfoBTN = gametypeLast!.GameIsComplete as NSString
                GameStyleInfoBTN = gametypeLast!.GameGameStyle as NSString
                CanTakeTurnInfoBTN = gametypeLast!.GameCanTakeTurn as NSString
                CurrentUserInfoBTN = gametypeLast!.GameUsersTurn as NSString
                NumComments = gametypeLast!.GameCommentInfo as NSString
                theContent = gametypeLast!.GameContent as NSString
                
                GameNameInfoBTNTwo = gametypeLastTwo!.GameName as NSString
                GameIDInfoBTNTwo = gametypeLastTwo!.GameID as NSString
                TurnNumberInfoBTNTwo = gametypeLastTwo!.GameTurnNumber as NSString
                IsCompleteInfoBTNTwo = gametypeLastTwo!.GameIsComplete as NSString
                GameStyleInfoBTNTwo = gametypeLastTwo!.GameGameStyle as NSString
                CanTakeTurnInfoBTNTwo = gametypeLastTwo!.GameCanTakeTurn as NSString
                CurrentUserInfoBTNTwo = gametypeLastTwo!.GameUsersTurn as NSString
                NumCommentsTwo = gametypeLastTwo!.GameCommentInfo as NSString
                theContentTwo = gametypeLastTwo!.GameContent as NSString

                
                print("Game Name if selected = \(GameNameInfoBTN)")
                
                //   nextTurnView.turnTypeBannerView?.hidden = true
            } else {
                
                
                
                GameNameInfoBTN = gametype!.GameName as NSString
                GameIDInfoBTN = gametype!.GameID as NSString
                TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
                IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
                GameStyleInfoBTN = gametype!.GameGameStyle as NSString
                CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
                CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
                NumComments = gametype!.GameCommentInfo as NSString
                theContent = gametype!.GameContent as NSString
                
                print("Game Name if selected = \(GameNameInfoBTN)")
                
                //  nextTurnView.turnTypeBannerView?.hidden = false
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    // do some task
                    // self.GetMyTurns()
                    DispatchQueue.main.async {
                        // update some UI
                    }
                }
                
            }
            
            if index == 1 {
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    // do some task
                   // self.GetStealTurns()
                    DispatchQueue.main.async {
                        // update some UI
                    }
                }
            }
            

        case 1:
            nextTurnView.turnTypeBannerView.isHidden = false
            nextTurnView.turnBannerLBL?.text = "Poke Player!"
            nextTurnView.currentTurnUserLBL?.text = "It's \(gametype!.GameUsersTurn)'s turn!"
            let randomBox = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
            let tempBlurImage = self.BlurryImages[randomBox]
            nextTurnView.TurnImage.image = tempBlurImage
            //nextTurnView.turnTypeBannerView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
            
            //UIColor.orangeColor().CGColor
            
            if index > 0 {
                
                
                
                GameNameInfoBTN = gametypeLast!.GameName as NSString
                GameIDInfoBTN = gametypeLast!.GameID as NSString
                TurnNumberInfoBTN = gametypeLast!.GameTurnNumber as NSString
                IsCompleteInfoBTN = gametypeLast!.GameIsComplete as NSString
                GameStyleInfoBTN = gametypeLast!.GameGameStyle as NSString
                CanTakeTurnInfoBTN = gametypeLast!.GameCanTakeTurn as NSString
                CurrentUserInfoBTN = gametypeLast!.GameUsersTurn as NSString
                NumComments = gametypeLast!.GameCommentInfo as NSString
                theContent = gametypeLast!.GameContent as NSString
                
                print("Game Name if selected = \(GameNameInfoBTN)")
                //   nextTurnView.turnTypeBannerView?.hidden = true
            } else {
                
                
                
                GameNameInfoBTN = gametype!.GameName as NSString
                GameIDInfoBTN = gametype!.GameID as NSString
                TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
                IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
                GameStyleInfoBTN = gametype!.GameGameStyle as NSString
                CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
                CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
                NumComments = gametype!.GameCommentInfo as NSString
                theContent = gametype!.GameContent as NSString
                
                print("Game Name if selected = \(GameNameInfoBTN)")
                
                //  nextTurnView.turnTypeBannerView?.hidden = false
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    // do some task
                    // self.GetMyTurns()
                    DispatchQueue.main.async {
                        // update some UI
                    }
                }
                
            }
        
        case 2:
            nextTurnView.turnTypeBannerView.isHidden = true
            nextTurnView.turnBannerLBL?.text = "Public Turns!"
            nextTurnView.currentTurnUserLBL?.text = "    Join Now!"
            
        //nextTurnView.pokeBGView?.layer.backgroundColor = UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0).CGColor
            
            
            
            let request: URLRequest = URLRequest(url: URL(string: (gametype?.TheMediaType)!)!)
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the imge in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    DispatchQueue.main.async(execute: {
                        
                        nextTurnView.TurnImage?.image = image
                        
                        /*
                        
                        //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                        //if let cellToUpdate = TableView.cel
                        if let cellToUpdate = nextTurnView[index] {
                        
                        //cellForRowAtIndexPath(indexPath) {
                        
                        if gametype.theMediaType == "gif" {
                        //image
                        } else if gametype.theMediaType == "image" {
                        
                        nextTurnView.TurnImage?.image = image
                        
                        } else {
                        
                        
                        
                        nextTurnView.TurnImage?.image = image
                        
                        }
                        nextTurnView.TurnImage?.image = image
                        }
                        
                        */
                    })
                }
                else {
                    
                    nextTurnView.TurnImage?.image = UIImage(named: "noImage.png")!
                    
                    print("Error: \(error!.localizedDescription)")
                }
            })

            
            
        if index > 0 {
            
          
            
            GameNameInfoBTN = gametypeLast!.GameName as NSString
            GameIDInfoBTN = gametypeLast!.GameID as NSString
            TurnNumberInfoBTN = gametypeLast!.GameTurnNumber as NSString
            IsCompleteInfoBTN = gametypeLast!.GameIsComplete as NSString
            GameStyleInfoBTN = gametypeLast!.GameGameStyle as NSString
            CanTakeTurnInfoBTN = gametypeLast!.GameCanTakeTurn as NSString
            CurrentUserInfoBTN = gametypeLast!.GameUsersTurn as NSString
            NumComments = gametypeLast!.GameCommentInfo as NSString
            theContent = gametypeLast!.GameContent as NSString
            print("Game Name if selected = \(GameNameInfoBTN)")
            
         //   nextTurnView.turnTypeBannerView?.hidden = true
        } else {
            
            
            
            GameNameInfoBTN = gametype!.GameName as NSString
            GameIDInfoBTN = gametype!.GameID as NSString
            TurnNumberInfoBTN = gametype!.GameTurnNumber as NSString
            IsCompleteInfoBTN = gametype!.GameIsComplete as NSString
            GameStyleInfoBTN = gametype!.GameGameStyle as NSString
            CanTakeTurnInfoBTN = gametype!.GameCanTakeTurn as NSString
            CurrentUserInfoBTN = gametype!.GameUsersTurn as NSString
            NumComments = gametype!.GameCommentInfo as NSString
            theContent = gametype!.GameContent as NSString
            print("Game Name if selected = \(GameNameInfoBTN)")
            
          //  nextTurnView.turnTypeBannerView?.hidden = false
            let priority = DispatchQueue.GlobalQueuePriority.default
            DispatchQueue.global(priority: priority).async {
                // do some task
               // self.GetMyTurns()
                DispatchQueue.main.async {
                    // update some UI
                }
            }
            
            }

        default:
            break
        }
        
       
        
        print("View At Index: Game Name = \(GameNameInfoBTN)")
        print("View At Index: Turn Number = \(TurnNumberInfoBTN)")
        print("View At Index: Is Complete = \(IsCompleteInfoBTN)")
        print("View At Index: Game Style = \(GameStyleInfoBTN)")
        print("View At Index: Can Take Turn = \(CanTakeTurnInfoBTN)")
        print("View At Index: Current User = \(CurrentUserInfoBTN)")
        print("View At Index: Num Comments = \(NumComments)")
        print("View At Index: The Content = \(theContent)")
        print("View At Index: Game ID = \(GameIDInfoBTN)")
        
     


        
       // nextTurnView.TurnImage?.image = UIImage(named: "noImage.png")!
       // nextTurnView.TurnImage?.image = UIImage(data: data!)
      //  nextTurnView.TurnImage?.image = theImage
        
       // nextTurnView.TurnImage?.image = theImage
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 200;
        let startY = (DeviceH / 2) - 200;
        
        
        //  nextTurnView.alpha = 0.0
        //  nextTurnView.theView.layer.cornerRadius = 10
        //  nextTurnView.theView.layer.masksToBounds = true
        //  nextTurnView.theView.clipsToBounds = true
        nextTurnView.frame = UIScreen.main.bounds
        
        //self.view.addSubview(myRemindView)
        return nextTurnView
        
        
        //return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
    //func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> TurnView? {
        /*
        let cell = NSBundle.mainBundle().loadNibNamed("TurnView", owner: self, options: nil).first as? TurnView
        
        let runs = self.run[Int(index)]
        cell!.textLabel!.text = runs.type
        
        return cell!
        
        */
        
        
    //    dispatch_async(dispatch_get_main_queue(), {
            
        
            
          //  UIView.animateWithDuration(0.25, animations: {
          //      myRemindView.alpha = 1.0
          //  })
            
            
      //  })
        
        
      
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
        
        
    }
}
