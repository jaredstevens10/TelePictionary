//
//  AppDelegate.swift

//
//  Created by Jared Stevens on 7/8/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData
//import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import AVFoundation
import iAd

//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


//@available(iOS 9.0, *)
//@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //@available(iOS 9.0, *)
    //print("app delegate called")
    var shortcutItem: AnyObject?
    //var GameID = NSString()
    //UIApplicationShortcutItem?
//    var popover:INPopoverController
    //var commentsViewController: CommentsViewController

    
    var CurrentTurn = String()

    
    let DT = NSString()
    
    var scheme: String! // = String()
    var path: String! //= String()
    var query2: String! //y: = String()
    var nsurl: URL!
    
    enum Actions:String{
        case increment = "INCREMENT_ACTION"
        case decrement = "DECREMENT_ACTION"
        case reset = "RESET_ACTION"
    }
    
    var categoryID:String{
        get{
            return "COUNTER_CATEGORY"
        }
    }

    var window: UIWindow?
    
    var loadedEnoughToDeepLink : Bool = false
    var deepLink : RemoteNotificationDeepLink?
    
    // Deep Link Methods
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("shortcut tapped")
        print("shortcut Type = \(shortcutItem.type)")
        completionHandler( handleShortcut(shortcutItem))
        
        
        /*
        dispatch_async(dispatch_get_main_queue(),{

            NSNotificationCenter.defaultCenter().postNotificationName("HandleShortcutVC", object: nil, userInfo: ["type":"newgame"])

        })
*/
        
    }
    
    
   
    
    @available(iOS 9.0, *)
    func handleShortcut( _ shortcutItem: UIApplicationShortcutItem) -> Bool {
        print("handling shortcut item now, in app delegate")
        var succeeded = false
        
        let rootNavigationViewController = window!.rootViewController as? UINavigationController
        let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?
        //Pop to root view controller so that approperiete segue can be performed
        rootNavigationViewController?.popToRootViewController(animated: false)
        
        let prefs:UserDefaults = UserDefaults.standard
        
        
        if (shortcutItem.type == "newgame.PQ.createnewgame") {
            
            print("shortcut item matched NewGame")
            
            
            prefs.setValue("NEWGAME", forKey: "SHORTCUT")
            
            /*
            let splitViewController = self.window!.rootViewController as! ViewController
           // let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
            let masterViewController = navigationController.viewControllers[0] as! ViewController
            masterViewController.insertNewObject(UIButton())
*/
            print("should segue NOW")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleShortcutVC"), object: nil, userInfo: ["type":"newgame"])
            /*
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController: NewViewController = storyboard.instantiateViewControllerWithIdentifier("NewGameVC") as! NewViewController
            
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
 */
            
            /*
              dispatch_async(dispatch_get_main_queue(),{
          
                print("should segue NOW")
                
                
                
                var storyboard = UIStoryboard(name: "Main", bundle: nil)
                var viewController: NewViewController = storyboard.instantiateViewControllerWithIdentifier("viewController") as! NewViewController
                
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()

                
                
                
                
                
            rootViewController?.performSegueWithIdentifier("select_newgame", sender: nil)
            
           //   NSNotificationCenter.defaultCenter().postNotificationName("HandleShortcutVC", object: nil, userInfo: ["type":"newgame"])
            
      //      NSNotificationCenter.defaultCenter().po
                
                })

*/
            //NSNotificationCenter.defaultCenter().postNotification("HandleShortcutVC")
            /*
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let NewGameVC = mainSB.instantiateViewControllerWithIdentifier(self, "NewGameViewController") as! NewGameViewController
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.pushViewController(NewGameVC, animated: true)
            */
            succeeded = true
            print("succedded = true")
        }
        
        
        if (shortcutItem.type == "mygames.PQ.gotomygames") {
            
            print("shortcut item matched mygames")
            
            
          //  let rootNavigationViewController = window!.rootViewController as? UINavigationController
           // let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?
           // rootViewController?.performSegueWithIdentifier("select_newgame", sender: nil)
             prefs.setValue("MYGAMES", forKey: "SHORTCUT")
            
            
              DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleShortcutVCmyGames"), object: nil, userInfo: ["type":"mygames"])
                })
            
            
            
            //NSNotificationCenter.defaultCenter().postNotification("HandleShortcutVC")
            /*
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let NewGameVC = mainSB.instantiateViewControllerWithIdentifier("NewGameViewController") as! NewGameViewController
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.pushViewController(NewGameVC, animated: true)
            */
            succeeded = true
            print("succedded = true")
        }
        
        if (shortcutItem.type == "leaders.PQ.gotoleaderboards") {
            /*
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController: LeadersTabBarController = storyboard.instantiateViewControllerWithIdentifier("LeaderboardsVC") as! LeadersTabBarController
            
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            */
            
             prefs.setValue("LEADERBOARDS", forKey: "SHORTCUT")
            
            DispatchQueue.main.async(execute: {

            print("shortcut item matched leaders")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleShortcutVCleaders"), object: nil, userInfo: ["type":"leaders"])
                
                })
            //NSNotificationCenter.defaultCenter().postNotification("HandleShortcutVC")
            /*
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let NewGameVC = mainSB.instantiateViewControllerWithIdentifier("NewGameViewController") as! NewGameViewController
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.pushViewController(NewGameVC, animated: true)
            */
            succeeded = true
            print("succedded = true")
        }

        
        return succeeded
    }
    
    
  
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplicaition)
        
        print("url  = \(url)")
        print("Source Application = \(sourceApplication)")
       // print("Annotation = \(annotation)")
       
        if (url as NSURL).isFileReferenceURL() {
            print("file reference URL")
            print("url file = \(url.path)")
        }
        
        nsurl = url
        scheme = url.scheme
        print("facebook scheme: \(scheme)")
        path = url.path
        query2 = url.query
        
        
        if url.host == nil
        {
            return true;
        }
        
        let urlString = url.absoluteString
        let queryArray = urlString.components(separatedBy: "/")
        let query = queryArray[2]
        
        // Check if article
        /*
        if scheme == "fb669563119812230" {
            println("FaceBook URL tried to load")
        } else
         */
            if query.range(of: "article") != nil
        {
            let data = urlString.components(separatedBy: "/")
            if data.count >= 3
            {
                let parameter = data[3]
                let userInfo = [RemoteNotificationDeepLinkAppSectionKey : parameter ]
                self.applicationHandleRemoteNotification(application, didReceiveRemoteNotification: userInfo)
            }
        }
        
        let facebookload = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        print("url = \(url)")
     //   print("annotation = \(annotation)")
        print("Facebook app load url? : \(facebookload)")
        
        //return true
        return facebookload
    }
    
   
    
    func applicationHandleRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        
         // UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        
      //  application.applicationIconBadgeNumber = 0;
       
       let numAlertBadges =  UserDefaults.standard.integer(forKey: "numAlertBadges")
        
        print("num Alert Badges = \(numAlertBadges)")
        
       let newNumAlertBadges = numAlertBadges + 1
        
        UserDefaults.standard.set(newNumAlertBadges, forKey: "numAlertBadges")
        
        print("New Num Alert Badges = \(newNumAlertBadges)")
        
        let numTurnBadges =  UserDefaults.standard.integer(forKey: "numTurns")
        
        let ShownBadges = numTurnBadges + newNumAlertBadges
        
         print("Num Shown Badges = \(ShownBadges)")
        
        application.applicationIconBadgeNumber = ShownBadges
        
        
        // prefs.integer
        
        print("received Remote Notification, will now handle")
        
        
        if application.applicationState == UIApplication.State.background || application.applicationState == UIApplication.State.inactive
        {
            let notificationDetails: NSDictionary = userInfo as NSDictionary
            
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

            
            var jsonAlert = JSON(notificationDetails)
            let NotificationMessage = jsonAlert["aps"]["alert"].stringValue
            let gameBy = jsonAlert["aps"]["gameBy"].stringValue
            let category = jsonAlert["aps"]["category"].stringValue
            let gameId = jsonAlert["aps"]["gameId"].stringValue
            let TurnInfo = jsonAlert["aps"]["turninfo"].stringValue
            let gameType = jsonAlert["aps"]["gameType"].stringValue
            
         
            
            print("TurnInfo From Delegate: \(TurnInfo)")
            
            
            // println("tiggering action notificaiton - local")
            //  triggerActionNotification(attackedBy, message: NotificationMessage, theCategory: category)
            
            print("received push notification while in the background")
            /*
            let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
            
                let theAlert = SCLAlertView()
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "test", subTitle: "test", duration: nil, completeText: "test", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            switch category {
                
                case "pokeHard":
                print("Got Poked hard in switch")
                self.window?.rootViewController?.presentViewController(theAlert, animated: true, completion: nil)
                //self.window?.rootViewController?.view
                    
                   // theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "test", subTitle: "test", duration: nil, completeText: "test", style: .Custom, colorStyle: 1, colorTextButton: 1)
    
            default:
                print("defaul notification received")
                
                
            }
            */
            if category == "GameSuggestion" {
                
                
                QuoteExample = jsonAlert["aps"]["QuoteExample"].stringValue
                player1 = jsonAlert["aps"]["player1"].stringValue
                player2 = jsonAlert["aps"]["player2"].stringValue
                player3 = jsonAlert["aps"]["player3"].stringValue
                player4 = jsonAlert["aps"]["player4"].stringValue
                player5 = jsonAlert["aps"]["player5"].stringValue
                player6 = jsonAlert["aps"]["player6"].stringValue
                player7 = jsonAlert["aps"]["player7"].stringValue
                player8 = jsonAlert["aps"]["player8"].stringValue
                player9 = jsonAlert["aps"]["player9"].stringValue
                player10 = jsonAlert["aps"]["player10"].stringValue
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType, "quote":QuoteExample, "player1":player1, "player2":player2, "player3":player3, "player4":player4, "player5":player5, "player6":player6, "player7":player7, "player8":player8, "player9":player9, "player10":player10])
                
            } else {
            

            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
            
            
            }

            /*
            var canDoNow = loadedEnoughToDeepLink
            
            self.deepLink = RemoteNotificationDeepLink.create(userInfo)
            
            if canDoNow
            {
                self.triggerDeepLinkIfPresent()
            }
*/
        }
    }
    
    func triggerDeepLinkIfPresent() -> Bool
    {
        print("Triggered Deep Link from AppDelegate")
        self.loadedEnoughToDeepLink = true
        let ret = (self.deepLink?.trigger() != nil)
        self.deepLink = nil
        return ret
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
      //  UIViewController.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
    //    UIViewController.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Manual
        
        
        //UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
       // let numAlertBadges =  NSUserDefaults.standardUserDefaults().integerForKey("numAlertBadges")
        // let newNumAlertBadges = numAlertBadges + 1
        let newNumAlertBadges = 0
        UserDefaults.standard.set(newNumAlertBadges, forKey: "numAlertBadges")
        
        let numTurnBadges =  UserDefaults.standard.integer(forKey: "numTurns")
        let ShownBadges = numTurnBadges + newNumAlertBadges
        application.applicationIconBadgeNumber = ShownBadges
        
        
        var performShortcutDelegate = true
        
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                
                print("shortcut Item available in App Delegate")
                self.shortcutItem = shortcutItem
                performShortcutDelegate = false
                print("SHORTCUT KEY NOT CLEARED")
            } else {
                print("Cleared shortcut key")
                let prefs:UserDefaults = UserDefaults.standard
                 prefs.setValue("", forKey: "SHORTCUT")
                
            }
          //  return performShortcutDelegate
            
            
            
        } else {
            print("ios 9 is not availble to hanlde shortcut item")
            // Fallback on earlier versions
        }
        
        let remoteNotif: AnyObject? = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as AnyObject?
        
        //Accept push notification when app is not open
        if ((remoteNotif) != nil) {
            
          //  self.handleRemoteNotification(remoteNotif!)
            self.applicationHandleRemoteNotification(application, didReceiveRemoteNotification: remoteNotif as! [AnyHashable: Any])
        }


        
   /*
        //var rootView: SWRevealViewController = SWRevealViewController()
        
        var rootView: ViewController = ViewController()
        if let window = self.window{
            window.rootViewController = rootView
        }
     */
        
        
       // return true
        
       // application.registerUserNotificationSettings(UIUserNot)
        
        print("Did finishing launching")
        
        if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
            // if (UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:")))
            
            // {
            print("responds to user notifications selector")
            /*
            let notificationCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            notificationCategory.identifier = "INVITE_CATEOGRY"
            notificationCategory.setActions([replyAction], forContext: UIUserNotificationActionContext.Default)
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[.Sound, .Alert, .Badge], categories: nil))
            
            } else {
            
            }
            */
            if #available(iOS 9.0, *) {
                print("trying to register for notification in ios 9")
            }
            
            if #available(iOS 8.0, *) {
                
              //  print("Responds to register notice")
                let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
                let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
                
                
                application.registerUserNotificationSettings(settings)
                
             //   print("registering for Remote notifications")
                application.registerForRemoteNotifications()
            } else {
                application.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        } else {
            let types: UIRemoteNotificationType = [UIRemoteNotificationType.badge, UIRemoteNotificationType.alert, UIRemoteNotificationType.sound]
            application.registerForRemoteNotifications(matching: types)
            
         
        }
        let prefs:UserDefaults = UserDefaults.standard

    //    print("did pass by user notifiction settings")
        
        let RecNot =  application.isRegisteredForRemoteNotifications
        
        prefs.set(RecNot, forKey: "RECNOT")
        
        
        let type: UIUserNotificationType = UIApplication.shared.currentUserNotificationSettings!.types
        
      //  print("User Notification Types = \(type.rawValue)")

        var notType = NSString()
        
        switch type.rawValue {
        case 7:
            notType = "All"
            prefs.set(true, forKey: "NOTIFYISON")
        case 5:
            notType = "NoSounds"
            prefs.set(true, forKey: "NOTIFYISON")
        case 4:
            notType = "NoSoundsNoBadges"
            prefs.set(true, forKey: "NOTIFYISON")
       // case 4:
       //     notType = "NoSoundsNoBadgesNoShowOnLock"
        case 6:
            notType = "NoBadges"
            prefs.set(true, forKey: "NOTIFYISON")
        case 0:
            notType = "None"
            prefs.set(false, forKey: "NOTIFYISON")
        
        default:
        break
        }
        
        print("Notifications setting = \(notType)")
    
        print("User Receiving Remote Notifications = \(RecNot)")
        
      
        
            
            
       // #define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice]]])
        
       // return performShortcutDelegate
        
       // let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let song = "ComedicFun.mp3"
        
        let VolumeMute = prefs.bool(forKey: "VolumeMute")
        
        
        /*
        
        var musicPlayer: AVAudioPlayer!
        let url = NSBundle.mainBundle().URLForResource("ComedicFun", withExtension: ".mp3")
        
        if VolumeMute {
            prefs.setBool(true, forKey:"VolumeMute")
        } else {
            do {
                musicPlayer = try AVAudioPlayer(contentsOfURL: url!)
            } catch {
                print(error)
            }
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            prefs.setBool(false, forKey: "VolumeMute")
        }
        
        */
        
        print("did finish Launching")
        
   //     FBLoginView.self
   //     FBProfilePictureView.self
     //   FB

        
        //Parse.setApplicationId("TjJm4euTBenCptEJE0BYB4MKUsIwLxo5azOZQoHD", clientKey: "jPbmJSPwUzyMb5AxPoXvWvIOZuKqF9O5Mr6Czeco")
        
        
        
       /*
        let types: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound, UIUserNotificationType.Badge]
      //  let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        let restartGameCategory = UIMutableUserNotificationCategory()
        restartGameCategory.identifier = "RESTART_CATEGORY"
       // restartGameCategory.setActions([, forContext: <#T##UIUserNotificationActionContext#>)
        
        let settings = UIUserNotificationSettings(forTypes: types, categories: (NSSet(array: [restartGameCategory])) as? Set<UIUserNotificationCategory>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
       */
        
        
        if application.applicationState != UIApplication.State.background {
            print("responds to background state")
            let preBackgroundPush = !application.responds(to: #selector(getter: UIApplication.backgroundRefreshStatus))
            let oldPushHandlerOnly = !self.responds(to: "application:didReceiveRemoteNotification")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplication.LaunchOptionsKey.remoteNotification] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
             //   PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
            }

        }

        /*
        var pageControl = UIPageControl.appearance()
        
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        pageControl.backgroundColor = UIColor.whiteColor()
*/
        //registerNotification()
        
    //    let notificationType = UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert
     //   let settings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)
        
        
      //  application.registerUserNotificationSettings(settings)
      //  application.registerForRemoteNotifications()
        
  //      UIApplication.sharedApplication().registerUserNotificationSettings(settings)
  //      UIApplication.sharedApplication().registerForRemoteNotifications()
        
        /*
        switch(getMajorSystemVersion()) {
        case 7:
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert)
        case 8:
            let pushSettings: UIRe
            UIRemoteNotificationSettings = UIRemoteNotificationSettings(
                forTypes:
                UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        default: return true
        }
*/
        
   // func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
   //     NSURLProtocol.registerClass(MyURLProtocol)
        // Override point for customization after application launch.
        
       // FBLoginView.self
       // FBProfilePictureView.self
          let LaunchFB = FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
            
          if LaunchFB  {
            return LaunchFB
        }
        
        print("Facebook launched ? : \(LaunchFB)")
        
        return true
       // return LaunchFB
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("did register for remote notifications with device token")
        print("Device Token: \(deviceToken)")
        
        let DT = deviceToken.description
        
     //   println("Device DT: \(DT)")
        
      //  let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
      //  currentInstallation.setDeviceTokenFromData(deviceToken)
//        currentInstallation.saveInBackgroundWithBlock(nil)
        
        //NSUserDefaults.standardUserDefaults().setValue(DT, forKey: "DT")
        
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
      //  NSUserDefaults.standardUserDefaults().setValue(DT, forKey: "deviceToken")
        
        print("Setting current deviceToken: \(DT)")
        //NSUserDefaults.standardUserDefaults().synchronize()
        
        //DeviceToken = NSString(data: deviceToken, encoding: NSUTF8StringEncoding)
        //println("Device Token String: \(DeviceToken)")
        
      //  DeviceToken = deviceToken
        
        
        
        
        /*
        println("didRegisterForRemoteNotifications")
        
        let currentInstallation = PFInstallation.currentInstallation()
        */
    

    }
    
    
    //func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        
        print("Failed to register for Remote Notifications")
       // NSLog("Failed to get token; error: %@", error)
        print(error.localizedDescription)
    }

    func getMajorSystemVersion() -> Int {
       // var deviceID_String = UIDevice.current.systemVersion.characters[0] as String
       // var deviceID_Int = Int(deviceID_String)
      //  return deviceID_Int
        return 9
       // return Int(String(Array(UIDevice.current.systemVersion.characters)[0]))!
    }
    
    
   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
       // UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        //prefs
       //  NSUserDefaults.standardUserDefaults().
            
            //setInteger(turnCount, forKey: "numTurns")
        
        let numAlertBadges =  UserDefaults.standard.integer(forKey: "numAlertBadges")
        
        print("num Alert Badges 2 = \(numAlertBadges)")
        
        let newNumAlertBadges = numAlertBadges + 1
        
         print("New Num Alert Badges 2 = \(newNumAlertBadges)")
        
        UserDefaults.standard.set(newNumAlertBadges, forKey: "numAlertBadges")
        
        let numTurnBadges =  UserDefaults.standard.integer(forKey: "numTurns")
        
        let ShownBadges = numTurnBadges + newNumAlertBadges
        
        print("Num Shown Badges 2 = \(ShownBadges)")
        
        application.applicationIconBadgeNumber = ShownBadges
        
        
        
        
    
        
        
        
        
        
        
        print("Did Receive Remote Notification #2")
        
        if self.window!.rootViewController is ViewController {
            print("View Controller Showing 1")
        } else {
            print("View Controller not showing 1")
        }
        
        if application.applicationState == UIApplication.State.background || application.applicationState == UIApplication.State.inactive
        {
            
   
            let notificationDetails: NSDictionary = userInfo as NSDictionary
            
            
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
            
            
            var jsonAlert = JSON(notificationDetails)
            let NotificationMessage = jsonAlert["aps"]["alert"].stringValue
            let gameBy = jsonAlert["aps"]["gameBy"].stringValue
            let category = jsonAlert["aps"]["category"].stringValue
            let gameId = jsonAlert["aps"]["gameId"].stringValue
            let TurnInfo = jsonAlert["aps"]["turninfo"].stringValue
            let gameType = jsonAlert["aps"]["gameType"].stringValue
            
            
            
            
            print("TurnInfo From Delegate: \(TurnInfo)")
            
            
            // println("tiggering action notificaiton - local")
            //  triggerActionNotification(attackedBy, message: NotificationMessage, theCategory: category)
            
            print("received push notification while in the background")
            /*
            let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
            
            let theAlert = SCLAlertView()
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "test", subTitle: "test", duration: nil, completeText: "test", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            switch category {
                
            case "pokeHard":
                print("Got Poked hard in switch")
                self.window?.rootViewController?.presentViewController(theAlert, animated: true, completion: nil)
                //self.window?.rootViewController?.view
                
                // theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "test", subTitle: "test", duration: nil, completeText: "test", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
            default:
                print("defaul notification received")
                
                
            }
            */
            if category == "GameSuggestion" {
                
                
                QuoteExample = jsonAlert["aps"]["QuoteExample"].stringValue
                player1 = jsonAlert["aps"]["player1"].stringValue
                player2 = jsonAlert["aps"]["player2"].stringValue
                player3 = jsonAlert["aps"]["player3"].stringValue
                player4 = jsonAlert["aps"]["player4"].stringValue
                player5 = jsonAlert["aps"]["player5"].stringValue
                player6 = jsonAlert["aps"]["player6"].stringValue
                player7 = jsonAlert["aps"]["player7"].stringValue
                player8 = jsonAlert["aps"]["player8"].stringValue
                player9 = jsonAlert["aps"]["player9"].stringValue
                player10 = jsonAlert["aps"]["player10"].stringValue
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType, "quote":QuoteExample, "player1":player1, "player2":player2, "player3":player3, "player4":player4, "player5":player5, "player6":player6, "player7":player7, "player8":player8, "player9":player9, "player10":player10])
                
            } else {
                

            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
            }

        } else {
        
            
            
            /*
            let navigationController = self.window?.rootViewController as! UINavigationController
            let loadingViewController = navigationController.visibleViewController as ViewViewController
            loadingViewController.performSegueWithIdentifier("segueToLogin", sender: self)
            */
            
        
        let notificationDetails: NSDictionary = userInfo as NSDictionary
            
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
            
        
        var jsonAlert = JSON(notificationDetails)
        let NotificationMessage = jsonAlert["aps"]["alert"].stringValue
        let gameBy = jsonAlert["aps"]["gameBy"].stringValue
        let category = jsonAlert["aps"]["category"].stringValue
        let gameId = jsonAlert["aps"]["gameId"].stringValue
        let TurnInfo = jsonAlert["aps"]["turninfo"].stringValue
        let gameType = jsonAlert["aps"]["gameType"].stringValue
        
        print("TurnInfo From Delegate: \(TurnInfo)")
            
            
            CurrentTurn = TurnInfo
            
       //     NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])

        
        // println("tiggering action notificaiton - local")
        //  triggerActionNotification(attackedBy, message: NotificationMessage, theCategory: category)
            if category == "GameSuggestion" {
                
                
                QuoteExample = jsonAlert["aps"]["QuoteExample"].stringValue
                player1 = jsonAlert["aps"]["player1"].stringValue
                player2 = jsonAlert["aps"]["player2"].stringValue
                player3 = jsonAlert["aps"]["player3"].stringValue
                player4 = jsonAlert["aps"]["player4"].stringValue
                player5 = jsonAlert["aps"]["player5"].stringValue
                player6 = jsonAlert["aps"]["player6"].stringValue
                player7 = jsonAlert["aps"]["player7"].stringValue
                player8 = jsonAlert["aps"]["player8"].stringValue
                player9 = jsonAlert["aps"]["player9"].stringValue
                player10 = jsonAlert["aps"]["player10"].stringValue
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType, "quote":QuoteExample, "player1":player1, "player2":player2, "player3":player3, "player4":player4, "player5":player5, "player6":player6, "player7":player7, "player8":player8, "player9":player9, "player10":player10])
                
            } else {
                /*
                
                if category == "gameComment" {
                    
                    //GameID = gamedId
                    
                    let navigationController = application.windows[0].rootViewController as! SWRevealViewController
                  //  let activeViewCont = navigationController.visibleViewController
                    let activeViewCont = navigationController.presentedViewController
                    
                    NSUserDefaults.standardUserDefaults().setObject(gameId, forKey: "COMMENTGAMEID")
                    
                    let actionSheetController = DBAlertController(title: "New Comment", message: NotificationMessage, preferredStyle: .Alert)
                    
                    let PlaynowAction: UIAlertAction = UIAlertAction(title: "Check it out", style: .Default) { action -> Void in
                        
                        
                     //   let controller = self.popover.contentViewControler as! CommentsViewController
                        
                        //self.popover.presentPopoverFrom
                       // controller.web
                        /*
                        var window: UIWindow?
                        
                        if let viewControllers = self.navigationController?.viewControllers {
                            for viewController in viewControllers {
                                if viewController.isKindOfClass(ViewController) {
                                    
                                } else {
                                    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                                }
                            }
                        } else {
                            print("else showing")
                            
                            self.navigationController?.popToRootViewControllerAnimated(false)
                            UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
                            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                        }
                        */
                        dispatch_async(dispatch_get_main_queue(), {
                            print("THIS IS WHERE THE COMMENT SEQUE WILL GO")
                            /*
                            self.GameID = gameId
                            self.TurnNumber = turninfo
                            self.GameType = gameType
                            
                            print("GameID =\(self.GameID)")
                            print("TurnInfo =\(self.TurnNumber)")
                            print("Trying to take turn")
                            dispatch_async(dispatch_get_main_queue(), {
                                //  self.dismissViewControllerAnimated(false, completion: nil)
                                self.ViewComments()

                            })
*/
                        })
                        //self.performSegueWithIdentifier("Take_My_Turn", sender: self)
                        
                    }
                    
                    //Create and an option action
                    let PlaylaterAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
                        
                        
                    }
                    
                    
                    actionSheetController.addAction(PlaynowAction)
                    actionSheetController.addAction(PlaylaterAction)
                    
                  //  actionSheetController.show()
                    
                //    activeViewCont!.presentViewController(actionSheetController, animated: true, completion: nil)
                    
                    window!.rootViewController?.presentViewController(actionSheetController, animated: true, completion: nil)

                    
                } else {
              */
                
                /*
                let theAlert = SCLAlertView()
                
                let thisNotification = NSNotification(name: "HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                
                
                
                
                
                
                switch category {
                    
                    case "yourTurn":
                    print("your turn App delegate")
                    
                    theAlert.addButton("Play Now!", action: {
                        
                        
                         NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                        
                        
                    })
                    
                    
                    theAlert.addButton("Play Later", action: {
                        
                    })

                    
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "It's Your Turn...Yipee!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    case "userMessage":
                    print("userMessage App delegate")
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{

                        SCLAlertView().showCustomOK(UIImage(named: "pokeIcon.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Incoming Message", subTitle: NotificationMessage, duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                    })
                    
                case "pokeSoft":
                
                    theAlert.addButton("Play Now!", action: {
                        
                        print("should play now, current turn = \(self.CurrentTurn)")
                        
                         //dispatch_async(dispatch_get_main_queue(), {
                        
                          //  self.UseTheAlert(thisNotification)
                            
                         NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                      //  })
                        
                    })
                
                
                theAlert.addButton("Play Later", action: {
   
                })
                
                theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Poked Softly To Play.", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                    
                    
                case "pokeMedium":
                    
                    theAlert.addButton("Play Now!", action: {
                        
                         NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                        
                    })
                    
                    theAlert.addButton("Play Later", action: {
                        
                    })
                    
                      theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Poked to Play!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                case "pokeHard":
                    
                //    NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])

                    
                    theAlert.addButton("Play Now!", action: {
                        
                         NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                        
                        
                    })
                    
                    
                    theAlert.addButton("Play Later", action: {
                        
                    })
                    
                     theAlert.showCustomOK(UIImage(named: "pokeIconWhite.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Ouch! Hard Poked!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
               
                    
                case "newGame":
                    
                    theAlert.addButton("Play Later", action: {
                        
                    })
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "New Game!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
               
                case "GameComplete":
                    
                    
                    theAlert.addButton("Check it out!", action: {
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("HandleAlertMessageGC", object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
                        
                        
                    })
                    
                    theAlert.addButton("Later", action: {
                       
                    })
                    
                    
                    theAlert.showCustomOK(UIImage(named: "newGame.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Your Game is Complete!", subTitle: NotificationMessage, duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                default:
                    print("Default notice received")
                
            }
            */
                
                
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAlertMessage"), object: nil, userInfo: ["message":NotificationMessage, "gameBy":gameBy, "gameId":gameId, "category":category, "turninfo":TurnInfo, "gameType":gameType])
           
                //}
        }
            
            
    }
        
        
        if self.window!.rootViewController is ViewController {
            print("View Controller Showing 2")
        } else {
            print("View Controller not showing 2")
        }

        
        if self.window!.rootViewController is StartUpViewController {
            print("Start View Controller Showing 2")
        } else {
            print("Start View Controller not showing 2")
        }
        
    }

    /*
    func UseTheAlert (notification: NSNotification){
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
*/
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        FBSDKAppEvents.activateApp()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        let prefs:UserDefaults = UserDefaults.standard
print("APP ENTERED FOREGROUND FROM DELEGATE")
        
        let type: UIUserNotificationType = UIApplication.shared.currentUserNotificationSettings!.types
        
        //  print("User Notification Types = \(type.rawValue)")
        
        var notType = NSString()
        
        switch type.rawValue {
        case 7:
            notType = "All"
            prefs.set(true, forKey: "NOTIFYISON")
        case 5:
            notType = "NoSounds"
            prefs.set(true, forKey: "NOTIFYISON")
        case 4:
            notType = "NoSoundsNoBadges"
            prefs.set(true, forKey: "NOTIFYISON")
            // case 4:
            //     notType = "NoSoundsNoBadgesNoShowOnLock"
        case 6:
            notType = "NoBadges"
            prefs.set(true, forKey: "NOTIFYISON")
        case 0:
            notType = "None"
            prefs.set(false, forKey: "NOTIFYISON")
            
        default:
            break
        }
        
        
        let numAlertBadges =  UserDefaults.standard.integer(forKey: "numAlertBadges")
       // let newNumAlertBadges = numAlertBadges + 1
        let newNumAlertBadges = 0
        UserDefaults.standard.set(newNumAlertBadges, forKey: "numAlertBadges")
        
        let numTurnBadges =  UserDefaults.standard.integer(forKey: "numTurns")
        let ShownBadges = numTurnBadges + newNumAlertBadges
        application.applicationIconBadgeNumber = ShownBadges
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
       // UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        guard let shortcut = shortcutItem else { return }
        print("- Shortcut prperty has been set")
        if #available(iOS 9.0, *) {
            handleShortcut(shortcut as! UIApplicationShortcutItem)
        } else {
            // Fallback on earlier versions
        }
        
        
       
    //    var badges = application.applicationIconBadgeNumber
        
     //   badges = 0
        
        /*
        if badges != 0 {
            badges = 0
        }
*/
        //application.applicationIconBadgeNumber = 0;
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ClavenSolutions.TelePictionary" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "TelePictionary", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("TelePictionary.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          //  NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 //   NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
    /*
    func registerNotification() {
        
        // 1. Create the actions **************************************************
        
        // increment Action
        let incrementAction = UIMutableUserNotificationAction()
        incrementAction.identifier = Actions.increment.rawValue
        incrementAction.title = "ADD +1!"
        incrementAction.activationMode = UIUserNotificationActivationMode.Background
        incrementAction.authenticationRequired = true
        incrementAction.destructive = false
        
        // decrement Action
        let decrementAction = UIMutableUserNotificationAction()
        decrementAction.identifier = Actions.decrement.rawValue
        decrementAction.title = "SUB -1"
        decrementAction.activationMode = UIUserNotificationActivationMode.Background
        decrementAction.authenticationRequired = true
        decrementAction.destructive = false
        
        // reset Action
        let resetAction = UIMutableUserNotificationAction()
        resetAction.identifier = Actions.reset.rawValue
        resetAction.title = "RESET"
        resetAction.activationMode = UIUserNotificationActivationMode.Foreground
        // NOT USED resetAction.authenticationRequired = true
        resetAction.destructive = true
        
        
        // 2. Create the category ***********************************************
        
        // Category
        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = categoryID
        
        // A. Set actions for the default context
        counterCategory.setActions([incrementAction, decrementAction, resetAction],
            forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        counterCategory.setActions([incrementAction, decrementAction],
            forContext: UIUserNotificationActionContext.Minimal)
        
        
        // 3. Notification Registration *****************************************
        
        let types: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: counterCategory) as! Set<NSOBject>)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    */
    // Schedule the Notifications with repeat
    /*
    func scheduleNotification() {
        //UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        /*
        // Schedule the notification ********************************************
        if UIApplication.sharedApplication().scheduledLocalNotifications.count == 0 {
            
            let notification = UILocalNotification()
            notification.alertBody = "Hey! Update your counter ;)"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.fireDate = NSDate()
            notification.category = categoryID
            notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)

        }
*/
    */
    //}

    
    // MARK: Application Delegate
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        //scheduleNotification()
        UIApplication.shared.cancelAllLocalNotifications()
    print("Canceling Local Notifications")
    }
    
    
    
    func application(_ application: UIApplication,
        handleActionWithIdentifier identifier: String?,
        for notification: UILocalNotification,
        completionHandler: @escaping () -> Void) {
            
            print("handling local notifications")
            
            // Handle notification action *****************************************
            if notification.category == categoryID {
                
                let action:Actions = Actions(rawValue: identifier!)!
                let counter = Counter();
                
                switch action{
                    
                case Actions.increment:
                    counter++
                    print("Increment")
                    
                case Actions.decrement:
                    counter--
                    print("decrement")
                    
                case Actions.reset:
                    counter.currentTotal = 0
                    
                }
            }
            
            completionHandler()
    }

    func loginToFacebookWithSuccess(_ successBlock: () -> (), andFailure failureBlock: (NSError?) -> ()) {
        
    }
    
    
}



