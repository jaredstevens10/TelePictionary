//
//  GameCompleteViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/19/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import iAd
import StoreKit


class GameCompleteViewController: UIViewController, LikesViewControllerDelegate, FailViewControllerDelegate, UIPopoverPresentationControllerDelegate, ADInterstitialAdDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var DemoViewedPage = 0
    var ViewedDemo1 = Bool()
    var ViewedDemo2 = Bool()
    var ViewedDemo3 = Bool()
    var ViewedDemo4 = Bool()
    var ViewedDemo5 = Bool()
    var ViewedDemo6 = Bool()
    var ViewedDemo7 = Bool()
    var ViewedDemo11 = Bool()
    
     @IBOutlet weak var swipeTOP: NSLayoutConstraint!
     @IBOutlet weak var swipeIconRIGHT: NSLayoutConstraint!
     @IBOutlet weak var swipeImage: UIImageView!
    
    let SwipeHUD = ProgressHUDHow(text: "Swipe to view next turn")
    let LikeHUD = ProgressHUDHow(text: "Tap 'Like' to like turns!")
    let FailHUD = ProgressHUDHow(text: "or Tap 'Fail' if you don't.")
    let ShareHUD = ProgressHUDHow(text: "Share with your friends")
    let commentHUD = ProgressHUDHow(text: "Talk about the game")
    let wholikesHUD = ProgressHUDHow(text: "Who else Liked it?")
    let whofailedHUD = ProgressHUDHow(text: "Who else Failed it?")
    let BackHUD = ProgressHUDHow(text: "Tap Arrow to return to menu")
    
     @IBOutlet var collectionView: UICollectionView?
    var GameDataAddress = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/"
    var CollectionImageArray = [String]()
    
    var imageNSData = Data()
    var iMinSessions = 10
    var iTryAgainSessions = 10
    var product_id: NSString?;
    var product_id_all: NSString?;
    var product_id_ads: NSString?;
    var interAd: ADInterstitialAd?
    var interAdView = UIView()
    var closeButton = UIButton(type: UIButtonType.system)
    var imageURL = NSString()
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var shareImage: UIImageView!
    
    var theImage = UIImage()
    var theQuote = NSString()
    var thePreviousQuote = NSString()
    var PreviousImageLikeFail = UIImage()
    var FailPlayer: AVAudioPlayer!
    var LikePlayer: AVAudioPlayer!
    var LevelPlayer: AVAudioPlayer!
    var AudioClipPrevious = Data()
    
    var QBoxImage = UIImage(named: "QuoteBoxImage.png")
    let failURL1 = Bundle.main.url(forResource: "Aww", withExtension: ".mp3")
    
    let failURL2 = Bundle.main.url(forResource: "fail trombone", withExtension: ".mp3")
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    var likeURL1: URL!
    
    
    //let likeURL1 = NSBundle.mainBundle().URLForResource("tada", withExtension: ".caf")
    var DoUploadImage = Bool()
    var MuteAudio = Bool()
    let OtherUserProfile = true
   // var profileID = NSString()
   // let FailSounds = [failURL1, failURL2]
    
    var likeviewcontroller: LikesViewController = LikesViewController()
    
    var LikePushed = Bool()
    var failviewcontroller: FailViewController = FailViewController()
    
    var numberImageName = UIImage()
    
    var LikedTurn = Bool()
    var FailedPushed = Bool()
    var FailTurn = Bool()
    var replyUser = NSString()
    var LikeID = NSString()
    var FailID = NSString()
    var userID = NSString()
    var hideBorder = Bool()
    
    var FirstLoad = Bool()
    
    @IBOutlet var NewLikeBTN: UIButton!
    let prefs:UserDefaults = UserDefaults.standard
    
    var username = NSString()
    var replyUserID = NSString()
    @IBOutlet var NewFailBTN: UIButton!
    
    @IBOutlet var failBTN: UIButton!
    @IBOutlet var heartIMG: UIView!
    var GameID = NSString()
    var TurnNumber = NSString()
    var TurnNumber2 = NSString()
    
    @IBOutlet var failView: UIView!
    @IBOutlet var RadioView: UIView!
    
    @IBOutlet var RadioTimeLBL: UILabel!
    let timeInterval:TimeInterval = 0.1
    var musicTimer = Timer()
    
    var MediaTypeTemp = NSString()
    var MediaTypeTemp2 = NSString()
    var MediaTypePrevious = NSString()
    
    var player:AVAudioPlayer!
    
    var images = [UIImage]()
    
    var TurnInfo = NSString()
    
    var TheAudioClip = Data()
    var Audio_Data = Data()
    var Data2 = NSString()
    
    
    @IBOutlet var failsLBL: UILabel!
    
    var Likes = Int()
    var Fails = Int()
    
    var ViewHowTo = Bool()
   // let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var playBTN: UIButton!
    @IBOutlet var stopBTN: UIButton!
    var playImage = UIImage()
    var stopImage = UIImage()
    
    var playHidden = Bool()
    var stopHidden = Bool()
    
    @IBOutlet var CloseBTN: UIButton!
    @IBOutlet var View1: UIView!
    @IBOutlet var ViewHolder: UIView!
    
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    @IBOutlet var View1TOP: NSLayoutConstraint!
    //@IBOutlet weak var heartIMG: UIImageView!
    @IBOutlet weak var LikeLBL: UILabel!
    
   // @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentView2: UIView!
    
    @IBOutlet weak var finalImage: UIImageView!
    
    
    @IBOutlet weak var c1image: UIImageView!
    
    @IBOutlet weak var c2image: UIImageView!
    
    @IBOutlet weak var c3image: UIImageView!
    
    @IBOutlet weak var c4image: UIImageView!
    @IBOutlet weak var c5image: UIImageView!
    
    @IBOutlet weak var c6image: UIImageView!
    
    @IBOutlet weak var c7image: UIImageView!
    
    @IBOutlet weak var c8image: UIImageView!
    
    
    @IBOutlet weak var c9image: UIImageView!
    
    @IBOutlet weak var c10image: UIImageView!
    

    
    @IBOutlet weak var numberImage: UIImageView!
    
    
    var scrollView: UIScrollView!
    var imageViewScroll: UIImageView!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    var strLabel = UILabel()
    var messageFrame = UIView()
    
    var ActivityInd = UIActivityIndicatorView()
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var FrameImageView: UIImageView!
    
    @IBOutlet weak var QuoteBoxImage: UIImageView!
    @IBOutlet weak var labelTXT: UILabel!
    
    @IBOutlet weak var Quotetxt: UILabel!
    
    var TurnNumberPrevious = NSString()
    
    var pageIndex = Int()
    var titleText = String()
    var imageName = UIImage()
    var ImageFrame = UIImage()
    var QuoteImageName = UIImage()
    var QuoteText = String()
    var QuoteTextPrevious = String()
    
    func progressBarDisplayer(_ msg:String, _ indicator:Bool){
        print(msg)
        strLabel = UILabel(frame: CGRect(x:50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            ActivityInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            ActivityInd.startAnimating()
            messageFrame.addSubview(ActivityInd)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //CollectionImageArray.removeAll()
        //CollectionImageArray.append(imageURL as String)
        //CollectionImageArray.append("\(imageURL).gif")
        //CollectionImageArray.append("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(GameID)\(self.TurnNumber2).gif")
        
       // collectionView?.reloadData()
        
        if username == replyUser {
visibleView.isHidden = false
        } else {
            visibleView.isHidden = true
        }
        
        /*
        if FirstLoad {
            let AC = JSController("Like & Fail", MyMessage: "Don't forget to Like or Fail other players turns using the Like/Fail Buttons.",Color: "Red")
            self.presentViewController(AC, animated: true, completion: nil)
            
           // FirstLoad = false

        }
        */
        print("First Load = \(FirstLoad)")
        
        
        //UNCOMMENT BELOW TO ASK USER TO BUY NO ADS
       // CheckForNoAds()
        
       // prepareAd()
        
        print("COLLECTION ARRAY - VIEW DID APPEAR = \(CollectionImageArray)")
        
        
        if GameID == "demo" {
            
            let DeviceH = self.view.frame.height
            let LFY = DeviceH - 70
            let DeviceW = self.view.frame.width
           // let midD = (DeviceW / 2) - 25
            
            
            
            self.swipeImage.image = UIImage(named: "SwipeIcon.png")
            swipeImage.isHidden = false
            self.swipeTOP.constant = 70
            
          //  if self.TurnNumber == "Turn1" {
                
                
        switch self.TurnNumber {
         case "Turn1":
            
            
            if !ViewedDemo1 {
            
                DemoViewedPage += 1
                print("Demo Viewed page \(DemoViewedPage)")
                
                print("Demo Show Swipe Turn 1")
            
      //  let DeviceW = self.view.frame.width
        let midD = (DeviceW / 2) - 25
        
        
        let delayA = 2.0 * Double(NSEC_PER_SEC)
        let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: timeA) {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                
                
                self.swipeImage.center.x = self.swipeImage.center.x - (midD + 100)
                self.swipeIconRIGHT.constant = midD
                
            })
            
            
        }
        
        let delay = 6.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                
                self.swipeImage.center.x = self.swipeImage.center.x + (midD + 100)
                self.swipeIconRIGHT.constant = -100
                
            })
          }
          ViewedDemo1 = true
        }
        
        case "Turn2":
            
            if !ViewedDemo2 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = DeviceH - 100
                
               // self.view.addSubview(self.LikeHUD)
                
                
                print("Demo Show Swipe Turn 2")
                
               // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                     self.view.addSubview(self.LikeHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                        self.swipeImage.center.x = self.swipeImage.center.x - ((DeviceW - 40) + 100)
                        self.swipeIconRIGHT.constant = ((DeviceW / 2) + (DeviceW / 4)) - 10
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        let tempx = ((DeviceW / 2) + (DeviceW / 4)) - 10
                        
                        self.swipeImage.center.x = self.swipeImage.center.x + (tempx + 100)
                        self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.LikeHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
             ViewedDemo2 = true
            }
            
            
        case "Turn3":
            
            if !ViewedDemo3 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = DeviceH - 100
                
               // self.view.addSubview(self.FailHUD)
                
                
                print("Demo Show Swipe Turn 3")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                    
                    self.view.addSubview(self.FailHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                        self.swipeImage.center.x = self.swipeImage.center.x - (25 + 100)
                        self.swipeIconRIGHT.constant = 10
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        self.swipeImage.center.x = self.swipeImage.center.x + (25 + 100)
                        self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.FailHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo3 = true
            }
            
        case "Turn4":
            
            if !ViewedDemo4 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = LFY + 50
                
               // self.view.addSubview(self.ShareHUD)
                
                
                print("Demo Show Swipe Turn 4")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                     self.view.addSubview(self.ShareHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                     //   self.swipeImage.center.x = self.swipeImage.center.x - (35 + 100)
                     //   self.swipeIconRIGHT.constant = 35
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                     //   self.swipeImage.center.x = self.swipeImage.center.x + (35 + 100)
                     //   self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.ShareHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo4 = true
                //prefs.setBool(true, forKey: "VIEWCOMPLETEDDEMOGAME")
            }
            
        case "Turn5":
            
            if !ViewedDemo5 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = LFY + 50
                
               // self.view.addSubview(self.commentHUD)
                
                
                print("Demo Show Swipe Turn 4")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                    
                    self.view.addSubview(self.commentHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x - (35 + 100)
                        //   self.swipeIconRIGHT.constant = 35
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x + (35 + 100)
                        //   self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.commentHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo5 = true
                //prefs.setBool(true, forKey: "VIEWCOMPLETEDDEMOGAME")
            }
            
        case "Turn6":
            
            if !ViewedDemo6 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = LFY + 50
                
               //self.view.addSubview(self.wholikesHUD)
                
                
                print("Demo Show Swipe Turn 4")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                    self.view.addSubview(self.wholikesHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x - (35 + 100)
                        //   self.swipeIconRIGHT.constant = 35
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x + (35 + 100)
                        //   self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.wholikesHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo6 = true
               // prefs.setBool(true, forKey: "VIEWCOMPLETEDDEMOGAME")
            }
            
        case "Turn7":
            
            if !ViewedDemo7 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = LFY + 50
                
               // self.view.addSubview(self.whofailedHUD)
                
                
                print("Demo Show Swipe Turn 4")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                    
                    self.view.addSubview(self.whofailedHUD)
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                      //  self.view.addSubview(self.whofailedHUD)
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x - (35 + 100)
                        //   self.swipeIconRIGHT.constant = 35
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x + (35 + 100)
                        //   self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.whofailedHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo7 = true
                //prefs.setBool(true, forKey: "VIEWCOMPLETEDDEMOGAME")
            }
            
        case "Turn11":
            
            if !ViewedDemo11 {
                
                self.swipeImage.image = UIImage(named: "SwipeIconTAP.png")
                self.swipeTOP.constant = LFY + 50
                
               // self.view.addSubview(self.BackHUD)
                
                
                print("Demo Show Swipe Turn 4")
                
                // let DeviceW = self.view.frame.width
                let midD = (DeviceW / 2) - 25
                let likeX = (DeviceW / 2) - 25
                
                
                let delayA = 2.0 * Double(NSEC_PER_SEC)
                let timeA = DispatchTime.now() + Double(Int64(delayA)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: timeA) {
                    
                     self.view.addSubview(self.BackHUD)
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x - (35 + 100)
                        //   self.swipeIconRIGHT.constant = 35
                        
                    })
                    
                    
                }
                
                let delay = 6.5 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
                        
                        //   self.swipeImage.center.x = self.swipeImage.center.x + (35 + 100)
                        //   self.swipeIconRIGHT.constant = -100
                        
                    })
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.BackHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                    })
                    
                }
                ViewedDemo11 = true
                prefs.set(true, forKey: "VIEWCOMPLETEDDEMOGAME")
            }
            
             default:
            break
            
            }
            
        }
        
    }

    override func viewDidLoad() {
        
        swipeImage.layer.cornerRadius = 25
        swipeImage.layer.masksToBounds = true
        swipeImage.clipsToBounds = true
        swipeImage.isHidden = true
        
        visibleView.isHidden = true
        let likepath = dirpath.stringByAppendingPathComponent("tada.caf") as String
        likeURL1 = URL(fileURLWithPath: likepath)
        
         product_id_ads = "com.ClavenSolutions.TelePictionary.adfree"
        
        if GameID != "demo" {
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.automatic
        }
        
        //FirstLoad = true
        MuteAudio = prefs.bool(forKey: "MuteGameAudio")
       // FailPlayer = AVAudioPlayer(contentsOfURL: failURL1!
        do {
        try FailPlayer = AVAudioPlayer(contentsOf: failURL1!)
        } catch {
            print("player not available")
        }
        FailPlayer.prepareToPlay()
        
        do {
            try LikePlayer = AVAudioPlayer(contentsOf: likeURL1)
        } catch {
            print("player not available")
        }
        LikePlayer.prepareToPlay()
        
        do {
            try LevelPlayer = AVAudioPlayer(contentsOf: likeURL1)
        } catch {
            print("player not available")
        }
        LevelPlayer.prepareToPlay()
        
        
        super.viewDidLoad()
        
         SKPaymentQueue.default().add(self)
        
        
        
        /////Configure iAd Button
        
        // Define a close button size:
        closeButton.frame = CGRect(x: 20, y: 20, width: 70, height: 44)
        closeButton.layer.cornerRadius = 10
        // Give the close button some coloring layout:
        closeButton.backgroundColor = UIColor.white
        closeButton.layer.borderColor = UIColor.black.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.setTitleColor(UIColor.black, for: UIControlState())
        // Wire up the closeAd function when the user taps the button
        closeButton.addTarget(self, action: #selector(GameCompleteViewController.closeAd(_:)), for: UIControlEvents.touchDown)
        // Some funkiness to get the title to display correctly every time:
        closeButton.isEnabled = false
        closeButton.setTitle("skip", for: UIControlState())
        closeButton.isEnabled = true
        closeButton.setNeedsLayout()
        
        ///////Done with iAd Button
        
        
        print("liked button pushed = \(LikePushed)")
        LikedTurn = LikePushed
  
        
        if !LikedTurn {
        NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayBlur.png")
        } else {
       NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayGreen.png")
        }
        
        /*
        if !FailTurn {
          NewFailBTN.imageView?.image = UIImage(named: "FailIconGrayBlur.png")
        } else {
            NewFailBTN.imageView?.image = UIImage(named: "FailIconWhiteRed.png")
        }
       */
         NewFailBTN.imageView?.image = UIImage(named: "FailIconWhiteRed.png")
        
        if prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
             userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            username = "tempName"
        }
        
        print("Game ID = \(GameID)")
        failsLBL.transform = CGAffineTransform(rotationAngle: 18.6)
        //160
        
        //(CGFloat(M_PI_4))
            failsLBL.textColor = UIColor.red
      //  let tap = UITapGestureRecognizer(target: self, action: Selector("ViewLikes"))
        
      //  heartIMG.addGestureRecognizer(tap)
       // heartIMG.userInteractionEnabled = true
       // failView.layer.cornerRadius = 20
       // failView.layer.borderWidth = 1
       // failView.layer.borderColor = UIColor.whiteColor().CGColor
        likeviewcontroller.likedelegate=self
        failviewcontroller.faildelegate=self
        print("Media Type from GAME COMPLETE = \(MediaTypeTemp)")
        print("Media Type from GAME COMPLETE2 = \(MediaTypeTemp2)")
       // contentView.hidden = true
        contentView2.isHidden = true
        self.bgImage.image = UIImage(named: "chalkboard bg.png")
        
     //   self.ImageView.image = UIImage(named: imageName)
        
       // self.ImageView.image = UIImage.animatedImageWithAnimatedGIFData(imageNSData)
        
       // print("MEdiaTypeTemp2 = \(MediaTypeTemp2)")
        
         if MediaTypeTemp2 == "gif" {
        
         print("is MediaType2")
            
            
            
         let TheImageURL2 = "\(imageURL).gif"
         self.ImageView.isHidden = true
         self.collectionView?.isHidden = false
           // CollectionImageArray.append("\(imageURL).gif")
        print("IMage URL = \(TheImageURL2)")
       // CollectionImageArray.removeAll()
      //  CollectionImageArray.append("http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(GameID)\(self.TurnNumber2).gif")
            
        collectionView?.reloadData()
            /*
        let url = NSURL(string: TheImageURL2 as String)
        let data = NSData(contentsOfURL: url!)
            
             dispatch_async(dispatch_get_main_queue(), {

        self.ImageView.image = UIImage.animatedImageWithAnimatedGIFData(data)
        
            })
            */
            
        } else {
             print("is not MediaType2")
         self.collectionView?.isHidden = true
         self.ImageView.isHidden = false
         self.ImageView.image = imageName
        }
        
        
        
        self.QuoteBoxImage.image = QuoteImageName
        self.numberImage.image = numberImageName
        
        //self.playBTN.imageView!.image = playImage
       // self.stopBTN.imageView!.image = stopImage
        //playBTN.hidden = playHidden
       // stopBTN.hidden = stopHidden
        self.RadioView.isHidden = playHidden
        
        
       /*
        if imageName == "blank_image.png" {
            QuoteBoxImage.hidden = false
        } else {
            QuoteBoxImage.hidden = true
        }
*/
        
        //ImageView.contentMode = .ScaleAspectFit //3
        
        self.labelTXT.layer.cornerRadius = 10
        self.labelTXT.layer.borderWidth = 2
        self.labelTXT.layer.borderColor = UIColor.white.cgColor
        
        self.LikeLBL.layer.borderColor = UIColor.white.cgColor
        
        self.LikeLBL.layer.cornerRadius = 10
            
          //  self.LikeLBL.layer.borderWidth = 2
        
        self.labelTXT.text = self.titleText
        
        self.Quotetxt.text = self.QuoteText
        
        self.labelTXT.alpha = 0.1
        
        self.LikeLBL.text = "\(self.Likes)"
        
        self.failsLBL.text = "\(self.Fails)"
        
        
       // self.LikeLBL.layer.borderWidth = 2
        //self.LikeLBL.layer.borderColor = UIColor.redColor().CGColor
        //self.LikeLBL
        if Fails == 1 {
        failBTN.imageView!.image = UIImage(named: "numFailsIcon1.png")
        } else {
        failBTN.imageView!.image = UIImage(named: "numFailsIcon1.png")
        }
        
       
        
        print("Turn Number Previous = \(TurnNumberPrevious)")
        print("Game ID IS = \(GameID)")
        print("TURN NUMBER = \(self.TurnNumber)")
        print("TURN NUMBER2 = \(self.TurnNumber2)")
        print("theQuote = \(theQuote)")
        print("thePrewviousQuote = \(thePreviousQuote)")

        
        
        
        if self.titleText == "Game Complete" {
            
            /*
            c1image.image = images[0]
            c2image.image = images[1]
            c3image.image = images[2]
            c4image.image = images[3]
            c5image.image = images[4]
            c6image.image = images[5]
            c7image.image = images[6]
            c8image.image = images[7]
            c9image.image = images[8]
            c10image.image = images[9]
          */
            self.finalImage.image = images[10]
            self.heartIMG.isHidden = true
            
            contentView2.isHidden = false
            ImageView.isHidden = true
            
            scrollView = UIScrollView(frame: view.bounds)
            scrollView.backgroundColor = UIColor.black
            scrollView.contentSize = finalImage.bounds.size
            scrollView.contentSize.height = 3000;
            
            scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            
            scrollView.addSubview(ImageView)
            view.addSubview(scrollView)
            scrollView.addSubview(contentView2)
            //scrollView.addSubview(images[1])
            
            
        }

        
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in self.labelTXT.alpha = 1.0
        })
        
      
        // Do any additional setup after loading the view.
        /*
        View1.layer.cornerRadius = 10
        CloseBTN.layer.cornerRadius = 10
        
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
        
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_FinalGameView")
        
        if !AlreadySeenHowTo {
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
                self.ViewHowTo = true
            })
        }
*/
        switch MediaTypeTemp2 {
            case "audio":
            DoUploadImage = false
            case "image":
            DoUploadImage = false
            case "quote":
            DoUploadImage = true
            default:
            DoUploadImage = false
        }
        
        if MediaTypeTemp2 == "audio" {
           if TheAudioClip != nil {
            
        do {
            
           
       // Data2 = try NSString(data: TheAudioClip, encoding: NSUTF8StringEncoding)!
        } catch {
            print("error = \(error)")
        }
        
        // print("Sound Data2 = \(Image64Data2)")
        
        do {
        //Audio_Data = try NSData(base64EncodedString: Data2 as String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        } catch {
            print("Error = \(error)")
        }
      }
    
    }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: ImageView.frame.size.height)
        //layout.itemSize = CGSize(width: ImageView.frame.size.width, height: ImageView.frame.size.height)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
       // print("COLLECTION ARRAY - VIEW DID LOAD = \(CollectionImageArray)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return 1
        //CollectionImageArray.count
        //        return Photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        var ShowImageTest = Bool()
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LikeFailPhotoCell
    
        
        var cellImageURL = String()
         print("MediaType  from Cell = \(self.MediaTypeTemp)")
        if self.MediaTypeTemp == "gif" {
            self.ImageView.isHidden = true
            
            self.collectionView!.isHidden = false
            print("is MediaType")
           // cellImageURL = "\(imageURL).gif"
            print("GIF URL = http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(GameID)\(self.TurnNumber).gif")
            cellImageURL =  "\(GameDataAddress)Game\(GameID)\(self.TurnNumber).gif"
            ShowImageTest = true
        } else if self.MediaTypeTemp == "picture" {
            //cellImageURL = "\(imageURL).jpg"
            print("GIF URL2 = http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/Game\(GameID)\(self.TurnNumber).jpg")
            cellImageURL =  "\(GameDataAddress)Game\(GameID)\(self.TurnNumber).jpg"
            self.ImageView.isHidden = false
            self.collectionView!.isHidden = true
            ShowImageTest = true
            
        } else {
            self.ImageView.isHidden = false
            self.collectionView!.isHidden = true
            ShowImageTest = false
            
        }
        
       // print("Cell Image URL = \(cellImageURL)")
       // print("MediaType From Cell = \(self.MediaTypeTemp)")
        print("MediaType 2 from Cell = \(self.MediaTypeTemp2)")
        
        
        print("Cell Image URL = \(cellImageURL)")
        
        if ShowImageTest {
        let request: URLRequest = URLRequest(url: URL(string: cellImageURL)!)
        let mainQueue = OperationQueue.main
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Store the image in to our cache
                //  self.imageCache[urlString] = image
                // Update the cell
                DispatchQueue.main.async(execute: {
                    if let cellToUpdate = collectionView.cellForItem(at: indexPath) {
                        
                        // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                        
                        if self.MediaTypeTemp == "gif" {
                            print("Image is a gif, FROM CELL")
                            cell.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                            cell.TurnImage?.isHidden = false
                            
                        } else {
                            
                            print("Image is NOT a gif, FROM CELL")
                            cell.TurnImage?.isHidden = true
                            cell.TurnImage?.image = image
                            
                        }
                        //let GIFData = NSData
                        
                        // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                        //cellToUpdate.TurnImage?.image = image
                    }
                })
            }
            else {
                cell.TurnImage?.isHidden = true
               // cell.TurnImage?.image = MyTurnData.theImage as UIImage
                print("Image is NOT a gif, ERROR FROM CELL")
                print("Error: \(error!.localizedDescription)")
            }
        })
        }
        
        
        return cell
        
    }
    
    @IBAction func ShowProfileBTN(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y + 1000
                
                self.ViewHolderTOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        self.prefs.set(true, forKey: "DidShowHowTo_FinalGameView")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func stop(_ sender: UIButton) {
        print("stop")
        
        //recorder?.stop()
        player?.stop()
        
        musicTimer.invalidate()
        
        // recordButton.setTitle("Record", forState:.Normal)
        
        
        let session = AVAudioSession.sharedInstance()
        
        
        do {
            try session.setActive(false)
            playBTN.isEnabled = true
            stopBTN.isEnabled = false
            // recordButton.enabled = true
        } catch let error as NSError {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
        
        //recorder = nil
    }
    
    @IBAction func play(_ sender: UIButton) {
        play()
    }
    
    func play() {
        stopBTN.isEnabled = true
        //playBTN.enabled = false
        //let url = Audio_Data
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
            // .setCategory(AVAudioSessionCategoryPlayback, error: nil)
            
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(data: TheAudioClip, fileTypeHint: AVFileTypeAppleM4A)
            // player = AVAudioPlayer(data: url, fileTypeHing: AVFileTypeMPEGLayer3, error: nil)
            player.prepareToPlay()
            player.play()
            
            self.musicTimer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                target:self,
                selector:#selector(GameCompleteViewController.updateMusicMeter(_:)),
                userInfo:nil,
                repeats:true)
            
            
        } catch {
            print("errors = \(error)")
        }
        //        let url = soundFileURLTemp
        
        
        /*
        if self.recorder != nil {
        url = self.recorder.url
        } else {
        url = self.soundFileURL!
        }
        */
        
     //   print("playing \(url)")
        
        /*
        do {
        self.player = try AVAudioPlayer(contentsOfURL: url)
        //stopButton.enabled = true
        player.delegate = self
        player.prepareToPlay()
        player.volume = 1.0
        player.play()
        } catch let error as NSError {
        self.player = nil
        print(error.localizedDescription)
        }
        */
    }
    
    func checkHeadphones() {
        // check NewDeviceAvailable and OldDeviceUnavailable for them being plugged in/unplugged
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count > 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    print("headphones are plugged in")
                    break
                } else {
                    print("headphones are unplugged")
                }
            }
        } else {
            print("checking headphones requires a connection to a device")
        }
    }
    
    
    func updateMusicMeter(_ timer:Timer) {
        
        //  if recorder.recording {
        let min = Int((player?.currentTime)! / 60)
        
        let sec = Int((player?.currentTime)!.truncatingRemainder(dividingBy: 60))
        
        let s = String(format: "%02d:%02d", min, sec)
        RadioTimeLBL.text = s
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didmoveButton(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ShowProfile" {
            
            
            if let destination = segue.destination as? LevelInfoViewController {
                
                destination.OtherUserProfile = self.OtherUserProfile
                destination.ShowB2 = true
                
                destination.playerID = self.replyUserID
                print("Profile show segue")
            }
        }

        
        
        if let destination = segue.destination as? FailViewController {
            
            destination.gameid = GameID
            destination.turnnumber = TurnNumber
            destination.replyuser = titleText as NSString
            
            
            
        }
        
        if let destination = segue.destination as? LikesViewController {
            
            destination.gameid = GameID
            destination.turnnumber = TurnNumber
            destination.replyuser = titleText as NSString
            
            
            
        }

        
        print("Segue Identifier = \(segue.identifier)")
        
        if segue.identifier == "Like" {
            
            let RepeatFriendViewController = segue.destination
            RepeatFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            RepeatFriendViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? LikesViewController {
                
                destination.gameid = GameID
                destination.turnnumber = TurnNumber
                 destination.replyuser = titleText as NSString
            
            }
            
        }
        
        
        if segue.identifier == "Fail" {
            
            let FBFriendViewController = segue.destination
            FBFriendViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            FBFriendViewController.popoverPresentationController!.delegate = self
            
            if let destination = segue.destination as? FailViewController {
                
                destination.gameid = GameID
                destination.turnnumber = TurnNumber
                destination.replyuser = titleText as NSString
                
                
                
            }
            
        }
        
    }
    @IBAction func ViewFail(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Fail") as! FailViewController
        
        savingsInformationViewController.faildelegate = self
        savingsInformationViewController.gameid = self.GameID
        savingsInformationViewController.turnnumber = self.TurnNumber
        
        savingsInformationViewController.replyuser  = self.titleText as NSString
        savingsInformationViewController.pageIndex  = self.pageIndex
        savingsInformationViewController.turnnumber  = self.TurnNumber
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
             popoverController2.sourceView = sender as! UIView
          //  popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            var middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = sender.bounds
            //CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .down
                //.Any
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func ViewLikes(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Like") as! LikesViewController
        
        savingsInformationViewController.likedelegate = self
        savingsInformationViewController.gameid = self.GameID
        savingsInformationViewController.turnnumber = self.TurnNumber
        savingsInformationViewController.pageIndex  = self.pageIndex
        savingsInformationViewController.replyuser  = self.titleText as NSString
        
        savingsInformationViewController.turnnumber  = self.TurnNumber
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
             popoverController2.sourceView = sender as! UIView
          //  popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            var middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = sender.bounds
            //CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .down
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        super.viewDidLoad()
        print("popover dismissed")
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    @IBAction func AddFailBTN(_ sender: AnyObject) {
        
        if username == replyUser {
           
           // let AC = JSController("Hey that's yours..", MyMessage: "You can't mark you own turn as a 'Fail'.",Color: "Red")
           // self.presentViewController(AC, animated: true, completion: nil)
            
            
             //SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Uh..that's yours.", subTitle: "You're trying to 'Fail' your own turn...nope.")
            
                      // theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor.redColor(), title: "Uh..that's yours.", subTitle: "You're trying to 'Fail' your own turn...nope.")
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh..that's yours", subTitle: "You're trying to 'Fail' your own turn...nope.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            
          
            
        
          //  if !MuteAudio {
        FailPlayer?.play()
         //   }
        if !FailTurn {
            FailTurn = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.NewFailBTN.alpha = 0.0
                }, completion: {
                (finished: Bool) -> Void in
      //  })
            self.NewFailBTN.imageView?.image = UIImage(named: "FailIconWhiteRed.png")
                
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self.NewFailBTN.alpha = 1.0
                    }, completion: nil)
    })
    
            SaveLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "fail", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaTypeTemp)" as NSString)
            
            switch TurnNumber {
            case "Turn1":
                TurnNumberPrevious = ""
            case "Turn2":
                TurnNumberPrevious = "Turn1"
            case "Turn3":
                TurnNumberPrevious = "Turn2"
            case "Turn4":
                TurnNumberPrevious = "Turn3"
            case "Turn5":
                TurnNumberPrevious = "Turn4"
            case "Turn6":
                TurnNumberPrevious = "Turn5"
            case "Turn7":
                TurnNumberPrevious = "Turn6"
            case "Turn8":
                TurnNumberPrevious = "Turn7"
            case "Turn9":
                TurnNumberPrevious = "Turn8"
            case "Turn10":
                TurnNumberPrevious = "Turn9"
            default:
                TurnNumberPrevious = ""
            }
            
            
          //  DoUploadImage = true
            
            
         //   if DoUploadImage {
                
                //UPLOADS CURRENT IMAGE
               // var TempImageCurrent = CreateTempImage(QuoteText)
                print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
              print("The Media type, before image upload is = \(MediaTypeTemp)")
              print("The Media type2, before image upload is = \(MediaTypeTemp2)")
                //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
             //   UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)")
             
                if MediaTypeTemp == "image" {
                  
                  let TempImageCurrent = CreateTempImage(QuoteTextPrevious as String)
                    
                    UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                    
                    DispatchQueue.main.async(execute: {
                        
                    if self.MediaTypePrevious == "audio" {
                         UploadGameFileNSData(self.AudioClipPrevious, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "audio")
                    } else {
                    
               
                    UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "image")
                     
                        }
                    })

                    
                }
                
            if MediaTypeTemp == "quote" {

                DispatchQueue.main.async(execute: {
                    
                    if self.MediaTypePrevious == "audio" {
                        DispatchQueue.main.async(execute: {
                            UploadGameFileNSData(self.Audio_Data, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "audio")
                        })
                        
                    } else {
                        
                        
                        let TempImageQuoteCurrent = self.CreateTempImage(self.QuoteText)
                        //print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
                        
                        //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                        DispatchQueue.main.async(execute: {
                            UploadGameFile(TempImageQuoteCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                        })
                    }

                })
            }

            
            

            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AddFail"), object: nil, userInfo: ["fails":"1","index":"\(pageIndex)"])
            
            
            DispatchQueue.main.async(execute: {
                
                var numPoints = Int()
                var LevelUpTime = Bool()
                (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "1", levelpoints: "1")
                //numPoints = FilterUPData(UPurldata)
                print("number of points = \(numPoints)")
                
                // let AC = JSController("Pixie Points!", MyMessage: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!",Color: "Green")
                
                
                
             //   if self.GameID != "demo" {
                
                DispatchQueue.main.async(execute: {
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Ok", action: {
                    
                     if self.GameID != "demo" {
                    
                    if LevelUpTime {
                        var PointsNew = NSInteger()
                        var LevelNew = NSInteger()
                        
                        (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")
                        
                        
                        let theAlert2 = SCLAlertView()
                        
                        theAlert2.addButton("Ok", action: {
                            theAlert2.dismiss(animated: true, completion: {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
                            })
                            
                        })
                        
                        theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Level \(LevelNew.description) - Level Up!", subTitle: "You just got a Level up on your Pixie! Congrats", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                        
                        /*
                        let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
                        self.presentViewController(AC, animated: true, completion:
                        {
                        NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                        }
                        
                        )
                        
                        */
                        
                        self.LevelPlayer?.play()
                        
                        
                    }
                    
                    }
                    
                })
                
                theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You earn Points to level up your Pixie by Failing Turns.  You just earned one!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
                
                })
                
             //   }
                
                
                
                /*
                
                
                let alertController = UIAlertController(title: "Pixie Points!", message: "You earn Points to level up your Pixie by Failing Turns.  You just earned one!", preferredStyle: .Alert)
                
                let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                    print("Ok button pressed")
                    
                    if LevelUpTime {
                        
                        
                        
                        
                        self.LevelPlayer?.play()
                        
                        var PointsNew = NSInteger()
                        var LevelNew = NSInteger()
                        
                        (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")
                        
                        let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
                        self.presentViewController(AC, animated: true, completion: {  NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                        })
                        
                    }
                    
                    
                }
                
                
                
                alertController.addAction(OkAction);
                
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
             
              */
                
            })
            
            

            
        } else {
            FailTurn = false
        
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.NewFailBTN.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    //  })
                    self.NewFailBTN.imageView?.image = UIImage(named: "FailIconGrayBlur.png")
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self.NewFailBTN.alpha = 1.0
                        }, completion: nil)
            })
            //DeleteLikeFailData(FailID)
            //DeleteLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.titleText)
        }

    }
}
    
    @IBAction func AddLikeBTN(_ sender: AnyObject) {
        
        if username == replyUser {
            
        //    let AC = JSController("Hey that's yours..", MyMessage: "You can't 'Like' you own turn.",Color: "Red")
         //   self.presentViewController(AC, animated: true, completion: nil)
            
            
         //  SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Hey that's yours..", subTitle: "You can't 'Like' you own turn.")
           
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Hey that's yours..", subTitle: "You can't 'Like' you own turn.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
        
       //     if !MuteAudio {
        LikePlayer?.play()
       //     }
        if !LikedTurn {
        LikedTurn = true
      
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.NewLikeBTN.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    //  })
                    self.NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayGreen.png")
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self.NewLikeBTN.alpha = 1.0
                        }, completion: nil)
            })
            
            
            SaveLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaTypeTemp)" as NSString)
            
            switch TurnNumber {
            case "Turn1":
                TurnNumberPrevious = ""
            case "Turn2":
                TurnNumberPrevious = "Turn1"
            case "Turn3":
                TurnNumberPrevious = "Turn2"
            case "Turn4":
                TurnNumberPrevious = "Turn3"
            case "Turn5":
                TurnNumberPrevious = "Turn4"
            case "Turn6":
                TurnNumberPrevious = "Turn5"
            case "Turn7":
                TurnNumberPrevious = "Turn6"
            case "Turn8":
                TurnNumberPrevious = "Turn7"
            case "Turn9":
                TurnNumberPrevious = "Turn8"
            case "Turn10":
                TurnNumberPrevious = "Turn9"
            default:
                TurnNumberPrevious = ""
            }
            
            
            print("The Media type2, before image upload is = \(MediaTypeTemp2)")
             print("The Media type, before image upload is = \(MediaTypeTemp)")
            print("The Media type Previous, before image upload is = \(MediaTypePrevious)")
            if MediaTypeTemp == "image" {
                
                let TempImageCurrent = CreateTempImage(QuoteTextPrevious as String)
           
                UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                
                
                DispatchQueue.main.async(execute: {
                    
                    if self.MediaTypePrevious == "audio" {
                        UploadGameFileNSData(self.AudioClipPrevious, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "audio")
                    } else {
                        
                        
                        UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "image")
                        
                    }
                })
                
            }
            
            if MediaTypeTemp == "quote" {
                 DispatchQueue.main.async(execute: {
                    
                    if self.MediaTypePrevious == "audio" {
                        
                        if self.AudioClipPrevious != nil {
                        
                        DispatchQueue.main.async(execute: {
                            UploadGameFileNSData(self.Audio_Data, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "audio")
                        })
                      }

                    } else {
                    
                    
                let TempImageQuoteCurrent = self.CreateTempImage(self.QuoteText)
                //print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
                
                //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                 DispatchQueue.main.async(execute: {
                    UploadGameFile(TempImageQuoteCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                  })
                }
              })
            }
            

            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AddLike"), object: nil, userInfo: ["likes":"1","index":"\(pageIndex)"])
            
            
            
            DispatchQueue.main.async(execute: {
                
                var numPoints = Int()
                var LevelUpTime = Bool()
                (numPoints, LevelUpTime) = UPData(self.username, userid: self.userID, type: "add", points: "1", levelpoints: "1")
                //numPoints = FilterUPData(UPurldata)
                print("number of points = \(numPoints)")
                
               // let AC = JSController("Pixie Points!", MyMessage: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!",Color: "Green")
                
                
                
                DispatchQueue.main.async(execute: {
                
                let theAlert = SCLAlertView()
                
                theAlert.addButton("Ok", action: {
                    
               if self.GameID != "demo" {
                    
                    if LevelUpTime {
                        var PointsNew = NSInteger()
                        var LevelNew = NSInteger()
                        
                        (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")
                        
                        
                        let theAlert2 = SCLAlertView()
                        
                        theAlert2.addButton("Ok", action: {
                            theAlert2.dismiss(animated: true, completion: {
                             NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePixie"), object: nil)
                            })
                            
                            })
                        
                        theAlert2.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Level \(LevelNew.description) - Level Up!", subTitle: "You just got a Level up on your Pixie! Congrats", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)

                        
                        /*
                        let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
                        self.presentViewController(AC, animated: true, completion:
                            {
                                NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                            }
                            
                        )
                        
                        */
                        
                        self.LevelPlayer?.play()
                        
                        
                    }
                    
                    }
                    
                })
                    
                    theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                })
                
                /*
                
                let alertController = UIAlertController(title: "Pixie Points!", message: "You earn Points to level up your Pixie by Liking Turns.  You just earned one!", preferredStyle: .Alert)
                
                let OkAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                    print("Ok button pressed")
                    
                    
                    if LevelUpTime {
                        var PointsNew = NSInteger()
                        var LevelNew = NSInteger()
                        
                        (PointsNew, LevelNew) = UserLevelUp(self.username, userid: self.userID, type: "add", level: "1")

                        let AC = JSController("Level \(LevelNew.description) - Level Up!", MyMessage: "You just got a Level up on your Pixie! Congrats",Color: "Green")
                        self.presentViewController(AC, animated: true, completion:
                            {
                                  NSNotificationCenter.defaultCenter().postNotificationName("updatePixie", object: nil)
                            }
                        
                        )
                        
                        self.LevelPlayer?.play()

                        
                    }
                    
                    
                }

                
               
                alertController.addAction(OkAction);
               
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                */
                
                /*
                self.presentViewController(AC, animated: true, completion: {
                    print("presented Pixie Points alert")
                    print("LevelUpTime = \(LevelUpTime)")
                    
                    
                    
                    
                    if LevelUpTime {
                        print("Show the Level Up Alert")
                        
                        dispatch_async(dispatch_get_main_queue(),{

                        let AC = JSController("Level Up!", MyMessage: "You just got a Level up on your Pixie!",Color: "Green")
                        self.presentViewController(AC, animated: true, completion: nil )
                            
                            
                            
                            
                            
                            let image = UIImage(named: "CharacterNormal.png")
                            
                            
                            let alertController = UIAlertController(title: "Level Up!", message: "You just got a Level up on your Pixie!", preferredStyle: .Alert)
                            
                            let CancelAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
                                print("Cancel button pressed")
                                
                            }
                            
                            var action = UIAlertAction(title: "title", style: .Default, handler: nil)
                            action.setValue(image, forKey: "image")
                          
                            
                            
                            
                            let SoftAction = UIAlertAction(title: "Soft Poke", style: .Default) { (action:UIAlertAction) in
                                print("Soft button pressed")
                                
                                // self.ClearHiddenYes()
                             //   let AlertType = "pokeSoft"
                                
                               // SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID:  self.UserTurnIDInfoBTN)
                                
                                
                            }
                            
                            let MedAction = UIAlertAction(title: "Regular Poke", style: .Default) { (action:UIAlertAction) in
                                print("Soft button pressed")
                                
                             //   let AlertType = "pokeMedium"
                                //  self.ClearHiddenYes()
                               // SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID: self.UserTurnIDInfoBTN)
                                
                            }
                            
                            let HardAction = UIAlertAction(title: "HARD Poke", style: .Default) { (action:UIAlertAction) in
                                print("Soft button pressed")
                                
                             //   let AlertType = "pokeHard"
                               // SendTurnNotice(TurnInfoTest, token: DeviceTKN, gameid: self.GameIDInfoBTN, turninfo: self.TurnNumberInfoBTN, alertType: AlertType, gameType: self.GameStyleInfoBTN, turninfoID: self.UserTurnIDInfoBTN)          //  self.ClearHiddenYes()
                                
                            }
                          //  alertController.addAction(SoftAction);
                          //  alertController.addAction(MedAction);
                            
                          //  alertController.addAction(HardAction);
                            alertController.addAction(action)
                            alertController.addAction(CancelAction);
                            alertController.view.tintColor = UIColor.blackColor();
                            //alertController.view.backgroundColor = UIColor(red: 0.4, green: 1, blue: 0.69, alpha: 1.0)
                            //CHANGE ERROR
                            /*
                            var subView = alertController.view.subviews.first as! UIView
                            var contentView = subView.subviews.first as! UIView
                            var contentView2 = subView.subviews.last as! UIView
                            
                            contentView.backgroundColor = UIColor(red: 0.807, green: 0.576, blue: 0.58, alpha: 1.0)
                            contentView.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
                            // contentView.
                            contentView2.tintColor = UIColor(red: 0.929, green: 0.113, blue: 0.145, alpha: 1.0)
                            */
                            
                         //   self.presentViewController(alertController, animated: true, completion: nil)
                            

                            
                            
                        
                        })

*/
                    
                   // }
                    
                    
                })
            
        
            
            
            
        } else {
            LikedTurn = false
      
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.NewLikeBTN.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    //  })
                    self.NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayBlur.png")
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self.NewLikeBTN.alpha = 1.0
                        }, completion: nil)
            })
            //DeleteLikeFailData(LikeID)
            //DeleteLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.titleText)
        }
        
     }
    }
    
    
    func CreateTempImage (_ TempQuote: String) -> UIImage {
        // let font = UIFont(name: "ChalkboardSE-Regular", size: 11.0)
        
        print("Creating image with quote = \(TempQuote)")
        var TempImage = UIImage()
        
        
        let font = UIFont.init(name: "DK Cool Crayon", size: 30.0)
        
        let fontTitle = UIFont.init(name: "Chalkduster", size: 30.0)
        
        
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        
        let textColor = UIColor.black
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.white
        shadow.shadowOffset = CGSize(width: 0,height: 1)
        // let textColorShadow = UIColor.whiteColor()
        
        var textFontAttributes: [String : AnyObject]?
        
        
        if let actualFont = font {
            textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
            
        }
        
        let ih = self.QBoxImage!.size.height
        let iw = self.QBoxImage!.size.width
        
        let newSize = CGSize(width: iw, height: ih)
        
        
        UIGraphicsBeginImageContext(newSize)
        
        
        
        let Rect2 = CGRect(x: 0,y: 0,width: iw,height: ih)
        
        
        let picRect = CGRect(x: 25,y: 85,width: iw,height: ih)
        
        QBoxImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
        
        
        let qRect1 = CGRect(x: 10,y: 130,width: iw-20,height: ih)
        
      //  let PreviousQTemp = "\(PreviousQuote) -\(CurrentPlayer)"
        
        TempQuote.draw(in: qRect1, withAttributes: textFontAttributes)
        TempImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return TempImage

    }
    
    
    

    @IBAction func ShareSettings(_ sender: AnyObject) {
        
        var PublicIcon = UIImage(named: "PublicIcon3.png")
        var MeIcon = UIImage(named: "MeIcon2.png")
        var FriendsIcon = UIImage(named: "FriendsIcon2-1.png")
        var BestFriendsIcon = UIImage(named: "BestFriendsIcon.png")
        let PublicIconCK = UIImage(named: "PublicIconChecked.png")
        let MeIconCK = UIImage(named: "MeIconChecked2.png")
        let FriendsIconCK = UIImage(named: "FriendsIconChecked2.png")
        let BestFriendsIconCK = UIImage(named: "BestFriendsIconChecked.png")
        
        let PhotoSelected = "Game\(self.GameID)\(self.TurnNumber)"
        print("Content Selected ID = \(PhotoSelected)")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Update Sharing Status", message: "Select the sharing status for this content.  This will not remove it from this game, but will limit who can view it on the leaderboards.", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let FBAction: UIAlertAction = UIAlertAction(title: "Public", style: .default) { action -> Void in
            
            UpdateTurnViewStatus("public", GameTurnID: PhotoSelected as NSString)
            
            self.shareImage.image = PublicIconCK
 
        }
        
        actionSheetController.addAction(FBAction)
        
        let TweetAction: UIAlertAction = UIAlertAction(title: "Friends", style: .default) { action -> Void in
            
            UpdateTurnViewStatus("friends", GameTurnID: PhotoSelected as NSString)

           self.shareImage.image = FriendsIconCK
            
        }
        
        actionSheetController.addAction(TweetAction)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Best Friends", style: .default) { action -> Void in
            
            UpdateTurnViewStatus("bestfriends", GameTurnID: PhotoSelected as NSString)

            self.shareImage.image = BestFriendsIconCK
        }
        
        actionSheetController.addAction(nextAction)
        
        let SMSAction: UIAlertAction = UIAlertAction(title: "Just Me", style: .default) { action -> Void in
            
            UpdateTurnViewStatus("me", GameTurnID: PhotoSelected as NSString)
            self.shareImage.image = MeIconCK
            
        }
        
        actionSheetController.addAction(SMSAction)
        
        
        
        
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            //save to images
            
        }
        
        actionSheetController.addAction(CancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
   
    
    func prepareAd() {
        print(" --- AD: Try Load ---")
        // Attempt to load a new ad:
        interAd = ADInterstitialAd()
        interAd?.delegate = self
    }
 
    func showAd() -> Bool {
        if interAd != nil && interAd!.isLoaded {
            interAdView = UIView()
            interAdView.frame = self.view!.bounds
            self.view?.addSubview(interAdView)
            
            interAd!.present(in: interAdView)
            UIViewController.prepareInterstitialAds()
            
            interAdView.addSubview(closeButton)
        }
        
        // Return true if we're showing an ad, false if an ad can't be displayed:
        return interAd?.isLoaded ?? false
    }
    
    // When the user clicks the close button, route to the adFinished function:
    func closeAd(_ sender: UIButton) {
        adFinished()
    }
    
    // A function of common functionality to run when the user returns to your app:
    func adFinished() {
        closeButton.removeFromSuperview()
        interAdView.removeFromSuperview()
        // (Do whatever is next in your app)
    }
    
    // The ad loaded successfully (we don't need to do anything for the basic implementation)
    func interstitialAdDidLoad(_ interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Load Success ---")
    }
    
    // The ad unloaded (we don't need to do anything for the basic implementation)
    func interstitialAdDidUnload(_ interstitialAd: ADInterstitialAd!) {
        print(" --- AD: Unload --- ")
    }
    
    // This is called if the user clicks into the interstitial, and then finishes interacting with the ad
    // We'll call our adFinished function since we're returning to our app:
    func interstitialAdActionDidFinish(_ interstitialAd: ADInterstitialAd!) {
        print(" --- ADD: Action Finished --- ")
        adFinished()
    }
    
    func interstitialAdActionShouldBegin(_ interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    // Error in the ad load, print out the error
    func interstitialAd(_ interstitialAd: ADInterstitialAd!, didFailWithError error: Error!) {
        print(" --- AD: Error --- ")
        print(error.localizedDescription)
    }
    
    fileprivate func showIntersitialAd() { //call this method whenever you want to show an interstitial
        self.requestInterstitialAdPresentation()
    }
    
    
    
    
    func purchaseitems(){
        
        print("About to fetch the products");
        
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id_ads!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fething Products");
        }else{
            print("can't make purchases");
        }
        
    }
    
    func buyProduct(_ product: SKProduct){
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
    
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let count : Int = response.products.count
        if (count>0) {
            var validProducts = response.products
            let validProduct: SKProduct = response.products[0]
            if (validProduct.productIdentifier == self.product_id_ads as! String) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
    }
    
    
    
    
    
    func CheckForNoAds() {
        
        var numLaunches = prefs.integer(forKey: "numAdLaunches") + 1
        let neverRate = prefs.bool(forKey: "NoAdsPurchased")
        

        if (!neverRate && (numLaunches == iMinSessions || numLaunches >= (iMinSessions + iTryAgainSessions + 1 ))) {
            print("NoAds not purchased")
            
            ShowForNoAds()
            
            numLaunches = iMinSessions + 1
        }
        prefs.set(numLaunches, forKey: "numAdLaunches")
    }
    
    func ShowForNoAds() {


            let actionSheetController: UIAlertController = UIAlertController(title: "Are you tired of the Ads?", message: "Would you like to get rid of the Ads for only $0.99?", preferredStyle: .alert)
            
            //Create and add the Cancel action
            // let cancelAction: UIAlertAction = UIAlertAction(title: "No thanks", style: .Cancel) { action -> Void in
            //Do some stuff
            //  }
            //  actionSheetController.addAction(cancelAction)
            //Create and an option action
            let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                
                self.purchaseitems()
            }
            
            let noAction: UIAlertAction = UIAlertAction(title: "no", style: .default) { action -> Void in
                
            }
            
            actionSheetController.addAction(yesAction)
            
            actionSheetController.addAction(noAction)
            
            self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("No Ads Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                   // prefs.setBool(true , forKey: "Purchased")
                    prefs.set(true, forKey: "NoAdsPurchased")
                    
                    /*
                    let UserUpdate = UserStatusCheck(username, status: "photo", action: "update")
                    if UserUpdate{
                        print("user profile updated")
                    } else {
                        print("user profile not updated")
                    }
                    */
                    
                    //   overlayView.hidden = true
                    break;
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                    
                    
                    
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                   // prefs.setBool(true , forKey: "Purchased")
                    prefs.set(true, forKey: "NoAdsPurchased")
                    /*
                    let UserUpdate = UserStatusCheck(username, status: "photo", action: "update")
                    if UserUpdate{
                        print("user profile updated")
                    } else {
                        print("user profile not updated")
                    }
                    */
                    
                default:
                    break;
                }
            }
        }
        
    }

   
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset: CGFloat = CGFloat(0)
        //self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
  
    

    
    
}
extension GameCompleteViewController {
    //}: FBFriendsViewControllerDelegate {
    func FailViewControllerFinished(_ failviewController: FailViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        
        
    }
}
extension GameCompleteViewController {
    //}: FBFriendsViewControllerDelegate {
    func LikesViewControllerFinished(_ likesviewController: LikesViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        

        
    }
}
