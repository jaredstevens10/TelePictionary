//
//  GameViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/9/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import iAd

protocol GameViewControllerDelegate
{
    //func saveText(var strText : NSString)
}


class GameViewController: UIViewController, QuoteViewControllerDelegate, ImageViewControllerDelegate, ADBannerViewDelegate {
    
     var delegate : GameViewControllerDelegate?
    
    var IsUnwinding = Bool()
    var quoteviewcontroller: QuoteViewController = QuoteViewController()
    var NumComments = NSString()
    var imageviewcontroller: ImageViewController = ImageViewController()
    
    @IBOutlet weak var bannerView1: ADBannerView!
   // var bannerView: ADBannerView!
    
    @IBOutlet weak var cirProgress: KDCircularProgress!
    
    var HolderStatus = Bool()
    var GameName = NSString()
    var GameID = NSString()
    var CurrentTurn = NSString()
    var GameSegue = NSString()
    var IsComplete = NSString()
    var GameStyle = NSString()
    var IsTurnAvailable = NSString()
    var Error_Msg = String()
    var strLabel = UILabel()
    var messageFrame = UIView()
    var username = NSString()
    var CurrentUser = NSString()
    var userid = NSString()
    var ContentRating = NSString()
    var dismissVC = Bool()
    
    var ActivityInd = UIActivityIndicatorView()
    
    let timeInterval:TimeInterval = 0.1
    var PQTimer:Timer!
    
    @IBOutlet var LoadingView: UIView!
    
    var currentCount = Int()
    var maxCount = Int()
    
    @IBOutlet var LoadingImage: UIImageView!
    
    var LoadingNumber = Int()
    
    @IBOutlet var LoadingLBL: UILabel!
    
    @IBAction func unwindToRed(_ unwindSegue: UIStoryboardSegue) {
        if let blueViewController = unwindSegue.source as? QuoteViewController {
            print("Coming from Quote")
            self.dismiss(animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "BackToMyGamesAgain", sender: self)
        }
        else if let redViewController = unwindSegue.source as? ImageViewController {
            print("Coming from Image")
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "BackToMyGamesAgain", sender: self)

        }
        else if let CompleteViewController = unwindSegue.source as? PageIntroViewController {
            print("Coming from Completed")
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "BackToMyGamesAgain", sender: self)

        }
        
    }
    
    

    func HandleAlertMessageGC(_ notification:Notification) {
        
        print("Did Receive Remote Notification While In Game Controller")
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let CurrentTurnTest = delegate.CurrentTurn
        
        print("CurrentTurnTest From Game Controller = \(CurrentTurnTest)")
        
        
        
        /*
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
        */
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        //print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        let NotificationMessage = jsonAlert["message"].stringValue
        let gameBy = jsonAlert["gameBy"].stringValue
        GameID = jsonAlert["gameId"].stringValue as NSString
        let category = jsonAlert["category"].stringValue
        CurrentTurn = jsonAlert["turninfo"].stringValue as NSString
        GameStyle = jsonAlert["gameType"].stringValue as NSString

       
        
        IsTurnAvailable = "yes"
        
        
        
    }
    
    
    override func viewDidLoad() {
        
        print("Unwinding = \(IsUnwinding)")
        
        if IsUnwinding {
            print("is unwinding from quote imge or completed")
            self.dismiss(animated: true, completion: nil)
            
        } else {
        
        //    var strImg : String = "http://www.drodd.com/images8/funny-gif/funny-gif17.gif"
        //    var url: NSURL = NSURL(string: strImg)!
            
//         let url : URL = Bundle.main.url(forResource: "PQLoadingGif", withExtension: "gif")!
//            do {
//               LoadingImage.image = UIImage.animatedImage(withAnimatedGIFURL: url)
//            } catch {
//                print("error loading PQLoadingGif")
//            }
            
            let name = "PQLoadingGif"
            var GifFound: Bool = true
            
            
            guard let url = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
                    GifFound = false
                    print("SwiftGif: This image named \"\(name)\" does not exist")
                    //return nil
                    return
            }
            
            if GifFound {
                LoadingImage.image = UIImage.animatedImage(withAnimatedGIFURL: url)
            }
            
            
//        if let url : URL = Bundle.main.url(forResource: "PQLoadingGif", withExtension: "gif")! {
//        
//        LoadingImage.image = UIImage.animatedImage(withAnimatedGIFURL: url)
//        
//            
//        } else {
//            
//            
//        }
        
       // bannerView = ADBannerView(adType: .Banner)
      //  bannerView1.translatesAutoresizingMaskIntoConstraints = false
        self.bannerView1.delegate = self
        
        bannerView1.isHidden = true
       // view.addSubview(bannerView)
        
        self.canDisplayBannerAds = true
        
        let viewsDictionary = ["bannerView": bannerView]
  //      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
   //     view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        
        
        
        
        
        
        
        print("Game VC - GAME ID = \(GameID)")
        super.viewDidLoad()
               LoadingNumber = 4
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.increaseProgress(_:)), name: NSNotification.Name(rawValue: "progressLoader"), object: nil);
            
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.DismissVC(_:)), name: NSNotification.Name(rawValue: "DismissVC"), object: nil);
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.StopTimerNotification(_:)), name: NSNotification.Name(rawValue: "StopTimerNotification"), object: nil)
            
            
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.HandleAlertMessageGC(_:)), name: NSNotification.Name(rawValue: "HandleAlertMessageGC"), object: nil)
        
        quoteviewcontroller.fdelegate=self
        imageviewcontroller.pdelegate=self
        
        let prefs:UserDefaults = UserDefaults.standard
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        userid = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        
        print("Curren Turn GVC: \(CurrentTurn)")
        print("GameStyle is \(GameStyle)")
        
       // println("is connected")
        let progressHUD = ProgressHUD2(text: "Loading Game Data")
      //  self.view.addSubview(progressHUD)
        
        print("Number of comments = \(NumComments)")
        
    //   self.view.addSubview(progressHUD)
        
        //dispatch_async(dispatch_get_main_queue
     //   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
        
        /*

        self.PQTimer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval,
        target:self,
        selector:"PQLoadingMeter:",
        userInfo:nil,
        repeats:true)
        NSRunLoop.currentRunLoop().addTimer(self.PQTimer, forMode: NSRunLoopCommonModes)
       */
     //   });
     


        
       
 // self.view.backgroundColor = UIColor.blackColor()
        
        
      //  progressBarDisplayer("Getting Game Data", true)        // Do any additional setup after loading the view.
        
       // progress = KDCircularProgress(
       // cirProgress.clockwise = true
        cirProgress.gradientRotateSpeed = 2
        cirProgress.roundedCorners = false
      //  cirProgress.glowMode = .Forward
      //  cirProgress.glowAmount = 0.9
        
        cirProgress.angle = 0
        

        }
        
       // cirProgress.
    }
    
    func newAngle() -> Int {
        return Int(360 * (currentCount / maxCount))
    }
    
    
    func DismissVC(_ notification: Notification){
        IsUnwinding = true
        
        dismissVC = true
        print("dismiss VC called")
        
        
        if self.CurrentTurn == "10" {
            self.CurrentTurn == "11"
        }
        print("Unwinding = \(IsUnwinding)")
      //  self.dismissViewControllerAnimated(false, completion: nil)
    }

    func increaseProgress(_ notification: Notification){
        
        let resultdict = (notification as NSNotification).userInfo as! NSDictionary
        print("Result Dict Progress: \(resultdict)")
        // let data : NSArray = resultdict.objectForKey("data") as! NSArray
        let progressPercent = resultdict.value(forKey: "progress") as! Int;
        cirProgress.animate(toAngle: Double(progressPercent), duration: 0.5, completion: nil)
      //  cirProgress.animateToAngle(progressPercent, duration: 0.5, completion: nil)
        
        /*
        if currentCount != maxCount {
            currentCount += 1
            let newAngleValue = newAngle()
            cirProgress.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
        }
*/
    }
    
    
    func StopTimerNotification(_ notification: Notification) {
        print("adding to progress bar")
        if currentCount != maxCount {
           // currentCount += 1
            currentCount = currentCount + 20
            let newAngleValue = newAngle()
            cirProgress.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
         //   cirProgress.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
        }
        /*
        if currentCount != maxCount {
            currentCount += 1
            let newAngleValue = newAngle()
            cirProgress.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
        }
*/
//    }Function(){
    //self.PQTimer.invalidate()
        
        print("Load Timer Stopped")
    }
    
    func PQLoadingMeter(_ timer:Timer) {
        
        if LoadingNumber == 4 {
            LoadingImage.image = UIImage(named: "PQLoading1.png")
            LoadingLBL.text = "               Loading."
            LoadingNumber = 1
            print("loading 1")
        }
        
        
        if LoadingNumber == 1 {
            LoadingImage.image = UIImage(named: "PQLoading2Only.png")
            LoadingLBL.text = "               Loading.."
            LoadingNumber = 2
            print("loading 2")
        }
        
        
        if LoadingNumber == 2 {
            LoadingImage.image = UIImage(named: "PQLoading3Only.png")
            LoadingLBL.text = "               Loading..."
            LoadingNumber = 3
            print("loading 3")
        }
        
        
        if LoadingNumber == 3 {
            LoadingImage.image = UIImage(named: "PQLoading4Only.png")
            LoadingLBL.text = "               Loading...."
            LoadingNumber = 4
            print("loading 4")
        }
    }
  /*
    override func viewDidUnload() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        
        
        if IsUnwinding {
            
            print("Is Unwinding View Did Appear")
           // print("is unwinding from quote imge or completed")
            self.dismiss(animated: true, completion: nil)
            
        } else {
      //  progressBarDisplayer("Getting Game Data", true)
        
        /*
        cirProgress.animateFromAngle(0, toAngle: 360, duration: 10) { completed in
            if completed {
                print("completed")
                
            } else {
                print("progress interupted")
            }

        }
             
             
       */
            
            //SWIFT 3 Error UNUSED??
            print("Swift 3 error")
            /*
        DispatchQueue.global(priority: Int(DispatchQoS.QoSClass.userInteractive.rawValue)).async {
            /*
            self.PQTimer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval,
                target:self,
                selector:"PQLoadingMeter:",
                userInfo:nil,
                repeats:true)
            NSRunLoop.currentRunLoop().addTimer(self.PQTimer, forMode: NSRunLoopCommonModes)
*/
        }
     */
 
        
        
        print("dismiss view controller did appear = \(dismissVC)")
        
        if dismissVC {
            self.dismiss(animated: true, completion: nil)
        } else {

        
            /*
            if ( IsComplete == "yes") {
            self.performSegueWithIdentifier("Complete", sender: self)
            
            }
            */

            print("dismiss view controller will appear = \(dismissVC)")
            /*
            
            if dismissVC {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            */
            
            var CurrentTurnUpdate = "User\(CurrentTurn)"
        
        
        if CurrentTurn != "11" {
        
        let (HolderStatus2, Error_Msg2) = TurnHolder(GameID, username: username, turninfo: CurrentTurn, status: "Get", userid: userid)
            
            HolderStatus = HolderStatus2
            Error_Msg = Error_Msg2 as String
            
       // if CurrentTurn != "11" {

            
        } else {
            HolderStatus = true
            
        }
        
        print("holder status = \(HolderStatus)")
            
            if HolderStatus {
                print("holder status: game available")
                
                if IsTurnAvailable == "no" {
                    print("Turn Available = NO")
                    
                    if CurrentTurn == "11" {
                        
                        print("Game complete")
                        self.performSegue(withIdentifier: "Complete", sender: self)
                        
                    } else {
                        if CurrentUser == username {
                            
                            
                            if GameStyle == "quote" {
                                switch CurrentTurn
                                {
                                case "2","4","6","8","10":
                                    print("Picture Time")
                                    GameSegue = "Add_Picture"
                                    
                               //     PQTimer.invalidate()
                                    
                                    
                                    
                                    self.performSegue(withIdentifier: "Add_Picture", sender: self)
                                    
                                    
                                    
                                    
                                    
                                    
                                case "1","3","5","7","9":
                                    print("Quote Time")
                                    GameSegue = "Add_Quote"
                                    
                              //      PQTimer.invalidate()
                                    
                                    self.performSegue(withIdentifier: "Add_Quote", sender: self)
                                    
                                
                                    
                                    
                                    
                                   
                                case "11":
                                    print("Game complete")
                                    
                               //     PQTimer.invalidate()
                                    
                                    self.performSegue(withIdentifier: "Complete", sender: self)
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                case "User2","User4","User6","User8","User10":
                                    print("Picture Time User")
                                    GameSegue = "Add_Picture"
                                    
                               //     PQTimer.invalidate()
                                    self.performSegue(withIdentifier: "Add_Picture", sender: self)
                                    
                            
                                    
                                    
                                case "User1","User3","User5","User7","User9":
                                    print("Quote Time User")
                                    GameSegue = "Add_Quote"
                                    
                             //       PQTimer.invalidate()
                                    
                                    self.performSegue(withIdentifier: "Add_Quote", sender: self)
                                    
                                    
                                    
                                    
                                case "User11":
                                    print("Game complete User")
                                    PQTimer.invalidate()
                                    self.performSegue(withIdentifier: "Complete", sender: self)
                                    
                                    
                                default:
                                    print("Error")
                                }
                            } else if GameStyle == "picture" {
                                
                                ///
                                print("What is current turn Number? it is \(CurrentTurn)")
                                ///
                                
                                switch CurrentTurn
                                {
                                case "2","4","6","8","10":
                                    print("Quote Time")
                                    GameSegue = "Add_Quote"
                               //     PQTimer.invalidate()
                                    self.performSegue(withIdentifier: "Add_Quote", sender: self)
                                    
                                case "1","3","5","7","9":
                                    print("Picture Time")
                                    GameSegue = "Add_Picture"
                                    ///
                                    print("About to picture segue")
                                    ///
                                ////    PQTimer.invalidate()
                                    self.performSegue(withIdentifier: "Add_Picture", sender: self)
                                    
                                case "11":
                                    print("Game complete")
                                 //   PQTimer.invalidate()
                                    self.performSegue(withIdentifier: "Complete", sender: self)
                                default:
                                    print("Error unknown Current Turn number")
                                }
                            }
                            
                        } else {
                            
                            print("dismissing view controller")
                            self.dismiss(animated: true, completion: nil)
                            
                          //  let AC = JSController("It's not your turn", MyMessage: "The turn time limit has not ended or It's not your turn yet.",Color: "Red")
                           // self.presentViewController(AC, animated: true, completion: nil)
                            
                          DispatchQueue.main.async(execute: {
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "It's not your turn", subTitle: "The time limit has not ended yet", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            })
                            
                            
                        }
                        
                    }
                } else {
                    
                    print("turn available = Yes")
                    
                    if GameStyle == "quote" {
                        
                        print("Game Style = Quote")
                        
                        switch CurrentTurn
                        {
                            
                            
                        case "2","4","6","8","10":
                            print("Picture Time")
                            GameSegue = "Add_Picture"
                        //    PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Add_Picture", sender: self)
                            
                        case "1","3","5","7","9":
                            print("Quote Time")
                            GameSegue = "Add_Quote"
                        //    PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Add_Quote", sender: self)
                        case "11":
                            print("Game complete")
                        //    PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Complete", sender: self)
                            
                            
                            
                        case "User2","User4","User6","User8","User10":
                            print("Picture Time User")
                            GameSegue = "Add_Picture"
                         //   PQTimer.invalidate()
                            
                            self.performSegue(withIdentifier: "Add_Picture", sender: self)
                            
                        case "User1","User3","User5","User7","User9":
                            print("Quote Time User")
                            GameSegue = "Add_Quote"
                        //    PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Add_Quote", sender: self)
                        case "User11":
                            print("Game complete User")
                        //    PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Complete", sender: self)
                            
                            
                        default:
                            print("Error")
                        }
                    }
                        
                    else if GameStyle == "picture" {
                        
                        // else {
                        print("Game Style = Picture")
                        ///
                        print("What is current turn Number? it is \(CurrentTurn)")
                        ///
                        
                        switch CurrentTurn
                        {
                        case "2","4","6","8","10":
                            print("Quote Time")
                            GameSegue = "Add_Quote"
                         //   PQTimer.invalidate()
                            
                            self.performSegue(withIdentifier: "Add_Quote", sender: self)
                            
                        case "1","3","5","7","9":
                            print("Picture Time")
                            GameSegue = "Add_Picture"
                            ///
                            print("About to picture segue")
                            ///
                         //   PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Add_Picture", sender: self)
                            
                        case "11":
                            print("Game complete")
                         //   PQTimer.invalidate()
                            self.performSegue(withIdentifier: "Complete", sender: self)
                        default:
                            print("Error unknown Current Turn number")
                        }
                    }
                    
                    
                    
                }
                
                
            } else {
                print("holder status: game taken")
                
                self.dismiss(animated: true, completion: nil)
                /*
                let AC = JSController("Turn In Process", MyMessage: "Another player is currently taking this turn.",Color: "Red")
                self.presentViewController(AC, animated: true, completion: nil)
                */
                 DispatchQueue.main.async(execute: {
                if !self.IsUnwinding {
                
                let AC = JSController("Turn Unavailable", MyMessage:  self.Error_Msg as String ,Color: "Red")
               // self.presentViewController(AC, animated: true, completion: nil)
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Turn Unavailable", subTitle: self.Error_Msg as String, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                })
                    
                    
                
        }
                })
        
            }
            
            /*else {
            switch CurrentTurn
            {
            case "2","4","6","8","10":
            println("Picture Time")
            GameSegue = "Add_Picture"
            self.performSegueWithIdentifier("Add_Picture", sender: self)
            
            case "1","3","5","7","9":
            println("Quote Time")
            GameSegue = "Add_Quote"
            self.performSegueWithIdentifier("Add_Quote", sender: self)
            case "11":
            println("Game complete")
            self.performSegueWithIdentifier("Complete", sender: self)
            default:
            println("Error")
            }
            
            }
            */
          // Do any additional setup after loading the view.
      // self.view.addSubview(ProgessLoad)
        }
    }
}

    /*
    func progressBarDisplayer(msg:String, _ indicator:Bool){
        println(msg)
        strLabel = UILabel(frame: CGRect(x:50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            ActivityInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            ActivityInd.startAnimating()
            messageFrame.addSubview(ActivityInd)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    */


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? QuoteViewController {
            print("Prepare dismissVC")
            
            destination.dismissVC = dismissVC
            
        }

        
        
        if segue.identifier == "Add_Picture" {
            if let destination = segue.destination as? ImageViewController {
                
                print("Picture Style - Current Turn: \(CurrentTurn)")
           
                destination.GameTurn = CurrentTurn
                destination.GameID = GameID
                //self.messageFrame.removeFromSuperview()
            }
        }
        
        if segue.identifier == "Add_Quote" {
            if let destination = segue.destination as? QuoteViewController {
                
                 print("Quote Style - Current Turn: \(CurrentTurn)")
                
                destination.GameTurn = CurrentTurn
                destination.GameID_Orig = GameID
                //self.messageFrame.removeFromSuperview()
            }
        }
        
        if segue.identifier == "Complete" {
            if let destination = segue.destination as? PageIntroViewController {
                
              //  destination.GameTurn = CurrentTurn
                destination.GAME_ID = GameID
                destination.NumComments = NumComments
                //self.messageFrame.removeFromSuperview()
                
            }
        }
        
        
      }
        
    
    
    override func viewDidDisappear(_ animated: Bool) {
         //  self.messageFrame.removeFromSuperview()
       

    }

/*
    override func viewWillAppear(animated: Bool) {
     /*
        if ( IsComplete == "yes") {
            self.performSegueWithIdentifier("Complete", sender: self)
            
        }
      */
        
    
        
        
        
        print("dismiss view controller will appear = \(dismissVC)")
        
        if dismissVC {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        var CurrentTurnUpdate = "User\(CurrentTurn)"
        
        let HolderStatus = TurnHolder(GameID, username: username, turninfo: CurrentTurn, status: "Get")
        
        if HolderStatus {
            print("holder status: game available")
            
            if IsTurnAvailable == "no" {
                print("Turn Available = NO")
                
                if CurrentTurn == "11" {
                    
                    print("Game complete")
                    self.performSegueWithIdentifier("Complete", sender: self)
                    
                } else {
                    if CurrentUser == username {
                        
                        
                        if GameStyle == "quote" {
                            switch CurrentTurn
                            {
                            case "2","4","6","8","10":
                                print("Picture Time")
                                GameSegue = "Add_Picture"
                                
                                PQTimer.invalidate()
                                
                                self.performSegueWithIdentifier("Add_Picture", sender: self)
                                
                                
                            case "1","3","5","7","9":
                                print("Quote Time")
                                GameSegue = "Add_Quote"
                                
                                PQTimer.invalidate()
                                
                                self.performSegueWithIdentifier("Add_Quote", sender: self)
                            case "11":
                                print("Game complete")
                                
                                PQTimer.invalidate()
                                
                                self.performSegueWithIdentifier("Complete", sender: self)
                                
                                
                                
                            case "User2","User4","User6","User8","User10":
                                print("Picture Time User")
                                GameSegue = "Add_Picture"
                                
                                PQTimer.invalidate()
                                self.performSegueWithIdentifier("Add_Picture", sender: self)
                                
                            case "User1","User3","User5","User7","User9":
                                print("Quote Time User")
                                GameSegue = "Add_Quote"
                                
                                PQTimer.invalidate()
                                
                                self.performSegueWithIdentifier("Add_Quote", sender: self)
                            case "User11":
                                print("Game complete User")
                                PQTimer.invalidate()
                                self.performSegueWithIdentifier("Complete", sender: self)
                                
                                
                            default:
                                print("Error")
                            }
                        } else if GameStyle == "picture" {
                            
                            ///
                            print("What is current turn Number? it is \(CurrentTurn)")
                            ///
                            
                            switch CurrentTurn
                            {
                            case "2","4","6","8","10":
                                print("Quote Time")
                                GameSegue = "Add_Quote"
                                PQTimer.invalidate()
                                self.performSegueWithIdentifier("Add_Quote", sender: self)
                                
                            case "1","3","5","7","9":
                                print("Picture Time")
                                GameSegue = "Add_Picture"
                                ///
                                print("About to picture segue")
                                ///
                                PQTimer.invalidate()
                                self.performSegueWithIdentifier("Add_Picture", sender: self)
                                
                            case "11":
                                print("Game complete")
                                PQTimer.invalidate()
                                self.performSegueWithIdentifier("Complete", sender: self)
                            default:
                                print("Error unknown Current Turn number")
                            }
                        }
                        
                    } else {
                        
                        print("dismissing view controller")
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        let AC = JSController("It's not your turn", MyMessage: "The turn time limit has not ended or It's not your turn yet.",Color: "Red")
                        self.presentViewController(AC, animated: true, completion: nil)
                        
                    }
                    
                }
            } else {
                
                print("turn available = Yes")
                
                if GameStyle == "quote" {
                    
                    print("Game Style = Quote")
                    
                    switch CurrentTurn
                    {
                        
                        
                    case "2","4","6","8","10":
                        print("Picture Time")
                        GameSegue = "Add_Picture"
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Add_Picture", sender: self)
                        
                    case "1","3","5","7","9":
                        print("Quote Time")
                        GameSegue = "Add_Quote"
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Add_Quote", sender: self)
                    case "11":
                        print("Game complete")
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Complete", sender: self)
                        
                        
                        
                    case "User2","User4","User6","User8","User10":
                        print("Picture Time User")
                        GameSegue = "Add_Picture"
                        PQTimer.invalidate()
                        
                        self.performSegueWithIdentifier("Add_Picture", sender: self)
                        
                    case "User1","User3","User5","User7","User9":
                        print("Quote Time User")
                        GameSegue = "Add_Quote"
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Add_Quote", sender: self)
                    case "User11":
                        print("Game complete User")
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Complete", sender: self)
                        
                        
                    default:
                        print("Error")
                    }
                }
                    
                else if GameStyle == "picture" {
                    
               // else {
                    print("Game Style = Picture")
                    ///
                    print("What is current turn Number? it is \(CurrentTurn)")
                    ///
                    
                    switch CurrentTurn
                    {
                    case "2","4","6","8","10":
                        print("Quote Time")
                        GameSegue = "Add_Quote"
                        PQTimer.invalidate()
                        
                        self.performSegueWithIdentifier("Add_Quote", sender: self)
                        
                    case "1","3","5","7","9":
                        print("Picture Time")
                        GameSegue = "Add_Picture"
                        ///
                        print("About to picture segue")
                        ///
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Add_Picture", sender: self)
                        
                    case "11":
                        print("Game complete")
                        PQTimer.invalidate()
                        self.performSegueWithIdentifier("Complete", sender: self)
                    default:
                        print("Error unknown Current Turn number")
                    }
                }
                
                
                
            }
            
            
        } else {
            print("holder status: game taken")
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let AC = JSController("Turn In Process", MyMessage: "Another player is currently taking this turn.",Color: "Red")
            self.presentViewController(AC, animated: true, completion: nil)
            
            
        }

        /*else {
                switch CurrentTurn
                {
                case "2","4","6","8","10":
                    println("Picture Time")
                    GameSegue = "Add_Picture"
                    self.performSegueWithIdentifier("Add_Picture", sender: self)
                    
                case "1","3","5","7","9":
                    println("Quote Time")
                    GameSegue = "Add_Quote"
                    self.performSegueWithIdentifier("Add_Quote", sender: self)
                case "11":
                    println("Game complete")
                    self.performSegueWithIdentifier("Complete", sender: self)
                default:
                    println("Error")
                }

            }
*/
    }
 
 */

    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
    return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewWillLoadAd(_ banner: ADBannerView!) {
       print("bannerViewWillLoadAd")
    }

    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        bannerView1.isHidden = false
          print("Did Load Ad")
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        bannerView1.isHidden = true
        print("Failed to receive Ad")
    }
    
  /*
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -&gt; Bool {
    return willLeave
    }
*/
}

extension GameViewController{
    
//}: QuoteViewControllerDelegate {
    func QuoteViewControllerFinished(_ quoteviewController: QuoteViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        print("Quote View Controller Dismissed")
        
        self.dismissVC = quoteviewController.dismissVC
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension GameViewController {
    
//}: ImageViewControllerDelegate {
    func ImageViewControllerFinished(_ imageviewController: ImageViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        
        
        self.dismissVC = imageviewController.dismissVC
        
         self.dismiss(animated: true, completion: nil)
        
        
    }
}


/*

dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {


var CurrentTurnUpdate = "User\(self.CurrentTurn)"

let HolderStatus = TurnHolder(self.GameID, username: self.username, turninfo: self.CurrentTurn, status: "Get")

if HolderStatus {
print("holder status: game available")

if self.IsTurnAvailable == "no" {
print("Turn Available = NO")

if self.CurrentTurn == "11" {

print("Game complete")
self.performSegueWithIdentifier("Complete", sender: self)

} else {
if self.CurrentUser == self.username {


if self.GameStyle == "quote" {
switch self.CurrentTurn
{
case "2","4","6","8","10":
print("Picture Time")
self.GameSegue = "Add_Picture"

self.PQTimer.invalidate()

self.performSegueWithIdentifier("Add_Picture", sender: self)


case "1","3","5","7","9":
print("Quote Time")
self.GameSegue = "Add_Quote"

self.PQTimer.invalidate()

self.performSegueWithIdentifier("Add_Quote", sender: self)
case "11":
print("Game complete")

self.PQTimer.invalidate()

self.performSegueWithIdentifier("Complete", sender: self)



case "User2","User4","User6","User8","User10":
print("Picture Time User")
self.GameSegue = "Add_Picture"

self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Picture", sender: self)

case "User1","User3","User5","User7","User9":
print("Quote Time User")
self.GameSegue = "Add_Quote"

self.PQTimer.invalidate()

self.performSegueWithIdentifier("Add_Quote", sender: self)
case "User11":
print("Game complete User")
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Complete", sender: self)


default:
print("Error")
}
} else if self.GameStyle == "picture" {

///
print("What is current turn Number? it is \(self.CurrentTurn)")
///

switch self.CurrentTurn
{
case "2","4","6","8","10":
print("Quote Time")
self.GameSegue = "Add_Quote"
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Quote", sender: self)

case "1","3","5","7","9":
print("Picture Time")
self.GameSegue = "Add_Picture"
///
print("About to picture segue")
///
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Picture", sender: self)

case "11":
print("Game complete")
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Complete", sender: self)
default:
print("Error unknown Current Turn number")
}
}

} else {

print("dismissing view controller")
self.dismissViewControllerAnimated(true, completion: nil)

let AC = JSController("It's not your turn", MyMessage: "The turn time limit has not ended or It's not your turn yet.",Color: "Red")
self.presentViewController(AC, animated: true, completion: nil)

}

}
} else {

print("turn available = Yes")

if self.GameStyle == "quote" {

print("Game Style = Quote")

switch self.CurrentTurn
{


case "2","4","6","8","10":
print("Picture Time")
self.GameSegue = "Add_Picture"
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Picture", sender: self)

case "1","3","5","7","9":
print("Quote Time")
self.GameSegue = "Add_Quote"
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Quote", sender: self)
case "11":
print("Game complete")
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Complete", sender: self)



case "User2","User4","User6","User8","User10":
print("Picture Time User")
self.GameSegue = "Add_Picture"
self.PQTimer.invalidate()

self.performSegueWithIdentifier("Add_Picture", sender: self)

case "User1","User3","User5","User7","User9":
print("Quote Time User")
self.GameSegue = "Add_Quote"
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Quote", sender: self)
case "User11":
print("Game complete User")
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Complete", sender: self)


default:
print("Error")
}
}

//else if GameStyle == "picture"

else {
print("Game Style = Picture")
///
print("What is current turn Number? it is \(self.CurrentTurn)")
///

switch self.CurrentTurn
{
case "2","4","6","8","10":
print("Quote Time")
self.GameSegue = "Add_Quote"
self.PQTimer.invalidate()

self.performSegueWithIdentifier("Add_Quote", sender: self)

case "1","3","5","7","9":
print("Picture Time")
self.GameSegue = "Add_Picture"
///
print("About to picture segue")
///
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Add_Picture", sender: self)

case "11":
print("Game complete")
self.PQTimer.invalidate()
self.performSegueWithIdentifier("Complete", sender: self)
default:
print("Error unknown Current Turn number")
}
}



}


} else {
print("holder status: game taken")

self.dismissViewControllerAnimated(true, completion: nil)

let AC = JSController("Turn In Process", MyMessage: "Another player is currently taking this turn.",Color: "Red")
self.presentViewController(AC, animated: true, completion: nil)


}

}
*/
