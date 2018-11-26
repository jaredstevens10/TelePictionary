//
//  GalleryItemViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/15/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import AssetsLibrary
import CoreMedia
import MediaPlayer
import AVFoundation
import Haneke
import MessageUI
import Social
import CoreData

class GalleryItemViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, SocialViewControllerDelegate, UIPopoverPresentationControllerDelegate, LikesViewControllerDelegate, FailViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate {
    
    
    var TheGameStyle = String()
    var image1 = UIImage()
    var image2 = UIImage()
    var image3 = UIImage()
    var image4 = UIImage()
    var image5 = UIImage()
    var image6 = UIImage()
    var image7 = UIImage()
    var image8 = UIImage()
    var image9 = UIImage()
    var image10 = UIImage()
    
    var Audio1 = Data()
    var Audio2 = Data()
    var Audio3 = Data()
    var Audio4 = Data()
    var Audio5 = Data()
    var Audio6 = Data()
    var Audio7 = Data()
    var Audio8 = Data()
    var Audio9 = Data()
    var Audio10 = Data()
    
    var TurnStrings = [NSString]()
     var FullGameImage = UIImage()
     let progressHUDVideo = ProgressHUD(text: "Creating Video...")
    var VideoFile: URL!
    var documentController: UIDocumentInteractionController!
    
    var totallikes = Int()
    var totalfails = Int()
    var NewLike1 = Int()
    var NewLike2 = Int()
    var NewLike3 = Int()
    var NewLike4 = Int()
    var NewLike5 = Int()
    var NewLike6 = Int()
    var NewLike7 = Int()
    var NewLike8 = Int()
    var NewLike9 = Int()
    var NewLike10 = Int()
    
    var NewFail1 = Int()
    var NewFail2 = Int()
    var NewFail3 = Int()
    var NewFail4 = Int()
    var NewFail5 = Int()
    var NewFail6 = Int()
    var NewFail7 = Int()
    var NewFail8 = Int()
    var NewFail9 = Int()
    var NewFail10 = Int()
    @IBOutlet weak var numCommentsLBL: UILabel!
    
    
    @IBOutlet weak var TableView: UITableView!
    var ISLOGGEDIN = Bool()
    @IBOutlet weak var totalcommentsLBL: UILabel!
    @IBOutlet weak var totlafailsLBL: UILabel!
    @IBOutlet weak var totlalikesLBL: UILabel!
    var GameNameSelected = NSString()
    @IBOutlet weak var gameTitle: UILabel!
    var TurnNumber = NSString()
    var LikedTurn = Bool()
    var FailedPushed = Bool()
    var FailTurn = Bool()
    var FailPlayer: AVAudioPlayer!
    var LikePlayer: AVAudioPlayer!
    var MuteAudio = Bool()
    let failURL1 = Bundle.main.url(forResource: "Aww", withExtension: ".mp3")
    let failURL2 = Bundle.main.url(forResource: "fail trombone", withExtension: ".mp3")
    //var likeURL1 = NSURL()
    
    var LevelPlayer: AVAudioPlayer!
    
    var MediaTypeTemp = NSString()
    var replyUser = NSString()
    var replyUserID = NSString()
   // var CompleteGameInfoArray = CompleteGameDataNew()
    //var CompleteGameInfo = CompleteGameDataNew()
    var ThisGameTurnInfoArray = [ThisGameTurnInfo]()
    
     var socialviewcontroller: SocialViewController = SocialViewController()
    var likeviewcontroller: LikesViewController = LikesViewController()
    var CanCreateVideo = Bool()
    var failviewcontroller: FailViewController = FailViewController()
    
     var LikedPushedArray = [Bool]()
     var userNames = [NSString]()
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    var QuoteBox = [UIImage]()
    var  FunQuoteBox = [UIImage]()
    var QBoxImage = UIImage(named: "QuoteBoxImage.png")
    var ImageFrame = UIImage(named: "imageFrame.png")
    var ImageDataArray = [Data]()
    var likeURL1: URL!
    var username = NSString()
    var userID = NSString()
    var useimageURLArray = [NSString]()
    var imageURLArray = [NSString]()
    var PlayHidden = [Bool]()
    var StopHidden = [Bool]()
    var FrameImages = [UIImage]()
    var GameID = NSString()
    var AlreadyLoadedView = Bool()
    
    var IsGameCenter = Bool()
    @IBOutlet weak var ViewHolder2TOP: NSLayoutConstraint!
    var IsMyTurns = Bool()
    var PlayerMain: AVAudioPlayer!
    // var PlayerMain: AVPlayer!
    var theAudioData = Data()
    var theAudioDataURL = String()
    var MainImageURL = String()
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    
    @IBOutlet weak var View1TOP: NSLayoutConstraint!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var ViewHolder2: UIView!
    
    let threshold: CGFloat = 100.0
    let Topthreshold: CGFloat = 0.0
    var isLoadingMore = Bool()
    var isRefreshing = Bool()
    var TableYPos = CGFloat()
    
    @IBOutlet weak var View1BGimage: UIImageView!
    
    
    @IBOutlet weak var CloseBTN: UIButton!
    //@IBOutlet weak var audioBTN: UIButton!
    // @IBOutlet weak var audioBTNMAIN: UIButton!
    var TurnInfo = NSString()
    
    var PublicIcon = UIImage(named: "PublicIcon3.png")
    var MeIcon = UIImage(named: "MeIcon2.png")
    var FriendsIcon = UIImage(named: "FriendsIcon2-1.png")
    var BestFriendsIcon = UIImage(named: "BestFriendsIcon.png")
    var PublicIconCK = UIImage(named: "PublicIconChecked.png")
    var MeIconCK = UIImage(named: "MeIconChecked2.png")
    var FriendsIconCK = UIImage(named: "FriendsIconChecked2.png")
    var BestFriendsIconCK = UIImage(named: "BestFriendsIconChecked.png")
    
    var Turn1Quote = NSString()
    var Turn2Image = UIImage()
    var Turn3Quote = NSString()
    var Turn4Image = UIImage()
    var Turn5Quote = NSString()
    var Turn6Image = UIImage()
    var Turn7Quote = NSString()
    var Turn8Image = UIImage()
    var Turn9Quote = NSString()
    var Turn10Image = UIImage()
    
    
    var count = 0
    
    var TurnUser = NSString()
    var GameData = [NSArray]()
    var Game_Data_Array = [NSString]()
    var Game_Data_ArrayID = [NSString]()
   // var username = NSString()
    var gnameArray = [NSString]()
    var GameIdArray = [NSString]()
    var Player1Array = [NSString]()
    var Player2Array = [NSString]()
    var Player3Array = [NSString]()
    var Player4Array = [NSString]()
    var Player5Array = [NSString]()
    var Player6Array = [NSString]()
    var Player7Array = [NSString]()
    var Player8Array = [NSString]()
    var Player9Array = [NSString]()
    var Player10Array = [NSString]()
    var Turn1Array = [NSString]()
    var Turn2Array = [NSString]()
    var Turn3Array = [NSString]()
    var Turn4Array = [NSString]()
    var Turn5Array = [NSString]()
    var Turn6Array = [NSString]()
    var Turn7Array = [NSString]()
    var Turn8Array = [NSString]()
    var Turn9Array = [NSString]()
    var Turn10Array = [NSString]()
    var TurnNumberArray = [NSString]()
    var IsCompleteArray = [NSString]()
    var UsersTurnArray = [NSString]()
    
    
    var GameNameInfo = NSString()
    var GameIDInfo = NSString()
    
    var Player1Info  = NSString()
    
    var Player2Info = NSString()
    var Player3Info = NSString()
    var Player4Info = NSString()
    var Player5Info = NSString()
    var Player6Info = NSString()
    var Player7Info = NSString()
    var Player8Info = NSString()
    var Player9Info = NSString()
    var Player10Info = NSString()
    /*
    var Player2IDInfo = NSString()
    var Player3IDInfo = NSString()
    var Player4IDInfo = NSString()
    var Player5IDInfo = NSString()
    var Player6IDInfo = NSString()
    var Player7IDInfo = NSString()
    var Player8IDInfo = NSString()
    var Player9IDInfo = NSString()
    var Player10IDInfo = NSString()
    var Turn1Info = NSString()
    */
    var Turn1Info = NSString()
    var Turn2Info = NSString()
    var Turn3Info = NSString()
    var Turn4Info = NSString()
    var Turn5Info = NSString()
    var Turn6Info = NSString()
    var Turn7Info = NSString()
    var Turn8Info = NSString()
    var Turn9Info = NSString()
    var Turn10Info = NSString()
    var TurnNumberInfo = NSString()
    var IsCompleteInfo = NSString()
    var UsersTurnInfo = NSString()
    var GameStyleInfo = NSString()
    
    var Like1Info = NSString()
    var Like2Info = NSString()
    var Like3Info = NSString()
    var Like4Info = NSString()
    var Like5Info = NSString()
    var Like6Info = NSString()
    var Like7Info = NSString()
    var Like8Info = NSString()
    var Like9Info = NSString()
    var Like10Info = NSString()
    var LikeGameInfo = NSString()
    var LikeArray = [Int]()
    var MediaTypeArray = [NSString]()
    var theMediaType = NSString()
    var PreviousMediaType = NSString()
    var images = [UIImage]()
    var images2 = [UIImage]()
    var Fimages = [UIImage]()
    var AudioClips = [Data]()
    var Quotes = [NSString]()
    var pageTitles = [NSString]()
    var users = [NSString]()
    var index : Int?
    
    var EmptyAudio = Data()
  //  var TurnInfo = ["Turn1","Turn2","Turn3","Turn4","Turn5","Turn6","Turn7","Turn8","Turn9","Turn10","Turn11"]
    
    var ViewStatusArray = [NSString]()
  //  var MediaTypeArray = [NSString]()
    var MediaType = NSString()
    var NewTurnNumber = String()
    var MainImage = UIImage()
    fileprivate let reuseIdentifier = "LikeFailViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    @IBOutlet weak var infoLBL: UILabel!
    var PhotoID = [NSString]()
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var items: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    var HideAudioArray = [Bool]()
    
    var playerID = NSString()
    var TurnType = NSString()
    @IBOutlet var collectionView: UICollectionView?
    var UserIDArray = [NSString]()
    var UserNameArray = [NSString]()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    let boomBox = UIImage(named: "BoomBox1.png")
    
    var refreshControl:UIRefreshControl!
    var LFURLData = Data()
    var MyLFURLData = Data()
    
    var photoForIndexPath = [String]()
  //  var AudioClips = [NSData]()
    var AudioStringArray = [String]()
    var Photos = [UIImage]()
    var NumFails2 = [NSString]()
    var NumFails = [Int]()
    var PhotoST = [PhotoInfo]()
    var TurnStruc = [TurnSearchInfo]()
    var ViewHowTo = Bool()
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        gameTitle.text = GameNameSelected as String
        let likepath = dirpath.stringByAppendingPathComponent("tada.caf") as String
        likeURL1 = URL(fileURLWithPath: likepath)
        
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


        AlreadyLoadedView = false
        socialviewcontroller.socialdelegate=self
        failviewcontroller.faildelegate=self
        likeviewcontroller.likedelegate=self
        
        CloseBTN.layer.cornerRadius = 10
        
        self.View1BGimage.layer.cornerRadius = 5
        self.View1BGimage.layer.masksToBounds = true
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
        
        NumTurnsLoaded = 0
        
        print("Number of Turns Currently loaded AT VIEW DID LOAD = \(self.NumTurnsLoaded)")
        super.viewDidLoad()
        
        IsMyTurns = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(GalleryItemViewController.RefreshCommentData(_:)), for: UIControlEvents.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        
        
       // navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        /*
        self.title = "My Turns"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        */
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //  collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        
        if prefs.value(forKey: "PLAYERID") != nil {
            
            playerID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            playerID = ""
        }
        
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        TableView.delegate = self
        TableView.dataSource = self
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //  MyLFURLData = GetMyTurnData(self.playerID)
        
        
        
        /*
        LFURLData = GetUserTurnData(self.playerID)
        
        
        dispatch_async(dispatch_get_main_queue(),{
        
        self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
        
        
        print("Photos count = \(self.Photos.count)")
        dispatch_async(dispatch_get_main_queue(),{
        
        print("photos \(self.Photos.count)")
        print("Photo IDs \(self.PhotoID)")
        print("num fails \(self.NumFails)")
        print("audio String array \(self.AudioStringArray)")
        print("show audio array \(self.HideAudioArray)")
        print("Audio Clips Data \(self.AudioClips.count)")
        print("Audio Clips = \(self.AudioClips)")
        self.collectionView?.reloadData()
        print("done animating")
        self.actInd.stopAnimating()
        
        })
        
        })
        */
        
        
        // Do any additional setup after loading the view.
    }
    
    func RemoveAllFromArray(){
        
        
        self.TurnStruc.removeAll()
        
        /*
        self.ViewStatusArray.removeAll()
        self.AudioStringArray.removeAll()
        self.Photos.removeAll()
        self.NumFails.removeAll()
        self.PhotoID.removeAll()
        self.HideAudioArray.removeAll()
        self.MediaTypeArray.removeAll()
        */
    }
    
    func RefreshCommentData(_ sender:AnyObject) {
        
        /*
        print("removing array data")
        //Photos.removeAll()
        //LCountArray.removeAll()
        self.RemoveAllFromArray()
        
        print("adding array data")
        
        // dispatch_async(dispatch_get_main_queue(),{
        
        self.NumTurnsLoaded = 0
        
        LFURLData = GetUserTurnData(self.playerID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
            + 50))
        
        self.NumTurnsLoaded = self.NumTurnsLoaded + 50
        
        dispatch_async(dispatch_get_main_queue(),{
            
            // self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            
            self.TurnStruc = self.FilterTurnData(self.LFURLData)
            
            
            print("Photos count REFRESH = \(self.Photos.count)")
            dispatch_async(dispatch_get_main_queue(),{
                
                /*
                print("photos \(self.Photos.count)")
                print("Photo IDs \(self.PhotoID)")
                print("num fails \(self.NumFails)")
                print("audio String array \(self.AudioStringArray)")
                print("show audio array \(self.HideAudioArray)")
                print("Audio Clips Data \(self.AudioClips.count)")
                print("Audio Clips = \(self.AudioClips)")
                */
                self.collectionView?.reloadData()
                print("done animating")
                self.actInd.stopAnimating()
                self.refreshControl!.endRefreshing()
            })
            
        })
        */
        //  })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
        
        /*
        self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        
        if !self.IsGameCenter {
            
            self.actInd.stopAnimating()
            
            let Alert = SCLAlertView()
            Alert.addButton("Log in Now", action: {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    LogIntoGameCenterNew()
                    
                })
                
            })
            
            Alert.addButton("Later", action: {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Game Center", subTitle: "Without being logged into Game Center many of this games features are disabled.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                })
                
                
            })
            
            Alert.showCustomOK(UIImage(named: "GameCenter.png")!, color: UIColor(red: 0.235294, green: 0.62745, blue: 0.81960, alpha: 1.0), title: "Game Center", subTitle: "You need to be logged into Game Center to view your games.  Please log in now", duration: nil, completeText: "", style: .Custom, colorStyle: 1, colorTextButton: 1)
            
            
            
        } else {
            
            */
            
            ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
            
            let DeviceH = self.view.frame.height
            let middleScreenY = DeviceH / 2
            let middleY = middleScreenY - 200
            
            let AlreadySeenHowTo = ""
            prefs.bool(forKey: "DidShowHowTo_MyTurns")
            
            /*
            if !AlreadySeenHowTo {
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.View1TOP.constant = middleY
            
            self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1000
            
            self.ViewHolder2TOP.constant = 0
            //self.ViewShowing = true
            // ShowingInfo = true
            
            // self.ViewTransTOP.constant = 0
            self.ViewHowTo = true
            
            //   self.howtoPaintBTN.enabled = true
            
            })
            
            }
            */
            
            if !AlreadyLoadedView {
                
                
                print("view already loaded")
                //LFURLData = GetUserTurnData(self.playerID)
             //   LFURLData = GetGalleryGameData(self.GameID)
              //  print("RECEIVED THE NSDATA FOR THE TURNS, Gallery Game Data = \(LFURLData)")
                
              //  self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                
                
                DispatchQueue.main.async(execute: {
                    
                    //  self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
                    print("FILTERING TURN DATA NOW")
                 //   self.TurnStruc = self.FilterGameData(self.LFURLData)
                    
                    self.GetCompleteGameData ()
                    // print("Photos count = \(self.Photos.count)")
                    DispatchQueue.main.async(execute: {
                        
                        
                        //self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: TurnStruc., playerID: <#T##String#>, likes: <#T##String#>, fails: <#T##String#>, turnURL: <#T##String#>, mediaType: <#T##String#>))
                        /*
                        print("photos \(self.Photos.count)")
                        print("Photo IDs \(self.PhotoID)")
                        print("num fails \(self.NumFails)")
                        print("audio String array \(self.AudioStringArray)")
                        print("show audio array \(self.HideAudioArray)")
                        print("Audio Clips Data \(self.AudioClips.count)")
                        print("Audio Clips = \(self.AudioClips)")
                        */
                        self.TableView?.reloadData()
                       // self.collectionView?.reloadData()
                        print("done animating")
                        self.actInd.stopAnimating()
                        
                        /*
                        dispatch_async(dispatch_get_main_queue(),{
                          self.DownloadImage()
                        })
                        */
                        
                        self.backgroundThread(background: {
                            //self.GetPublicTurns()
                            self.DownloadImage()
                            }, completion: {
                                
                                DispatchQueue.main.async(execute: {
                                    //self.GetMyHUD.removeFromSuperview()
                                    //  self.tableView.reloadData()
                                    print("Downloaded all the images")
                                })
                                // print("Done Getting Steal Turns")
                                //   self.kolodaView.resetCurrentCardNumber()
                        })
                        
                    })
                    
                    /*
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        /*
                        
                        if !AlreadySeenHowTo {
                            
                            UIView.animateWithDuration(1.0, animations: { () -> Void in
                                
                                self.View1TOP.constant = middleY
                                
                                self.ViewHolder2.center.y = self.ViewHolder2.center.y - 1000
                                
                                self.ViewHolder2TOP.constant = 0
                                //self.ViewShowing = true
                                // ShowingInfo = true
                                
                                // self.ViewTransTOP.constant = 0
                                self.ViewHowTo = true
                                
                                //   self.howtoPaintBTN.enabled = true
                                
                            })
                            
                        }
                      */
                        
                    })
                    */
                })
               AlreadyLoadedView = true
                print("Downloading images now")
          
            }
            
            //AlreadyLoadedView = true
      //  }
        
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
    
    @IBAction func View1CloseBTN(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder2.center.y = self.ViewHolder2.center.y + 1000
                
                self.ViewHolder2TOP.constant = 1000
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = false
        }
        
        
        self.prefs.set(true, forKey: "DidShowHowTo_MyTurns")
        
    }
    
    func PlayAudioClicked(_ sender: UIButton!) {
        
        
        let RowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        let MyTurnData = ThisGameTurnInfoArray[RowSelected]
        
        let audioURLString = MyTurnData.turnURL
        // var audioURLString = self.AudioStringArray[RowSelected] as String
        //var AudioData = self.AudioClips[RowSelected] as NSData
        //    dispatch_async(dispatch_get_main_queue(),{
        //            let audioURL = NSURL(fileURLWithPath: audioURLString)
        
        let audioURL = URL(string:"\(audioURLString).mp3")
        
        if let AudioData = try? Data(contentsOf: audioURL!) {
            
            print("Audio URL = \(audioURLString)")
            //var GameSelected = GameIDInfo[GameRowSelected]
            do {
                // try self.PlayerMain = AVAudioPlayer(contentsOfURL: audioURL!)
                try self.PlayerMain = AVAudioPlayer(data: AudioData)
                // try self.PlayerMain = AVPlayer(URL: audioURL!)
            } catch {
                print("player not available")
            }
            //   self.PlayerMain.prepareToPlay()
            self.PlayerMain.play()
            
        } else {
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Audio Error", subTitle: "There is an error with this audio clip", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        }
        //   })
    }
    
    func TurnViewStatusClickedMe(_ sender: UIButton!) {
        let RowSelected = sender.tag
        
        let MyTurnData = TurnStruc[RowSelected]
        
        
        print("the turn rowselected: \(sender.tag)")
        //let PhotoSelected = PhotoID[RowSelected].description
        
        let PhotoSelected = MyTurnData.gameturnid
        
        print("the Photo ID Selected is \(PhotoSelected)")
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        // self.ViewStatusArray.insert("me", atIndex: RowSelected)
        
        //  let PhotoSelected = MyTurnData.gameturnid
        // let gameturnidTEMP = MyTurnData.gameturnid
        let mediatypeTEMP = MyTurnData.mediatype
        let gamenameTEMP = MyTurnData.gamename
        let viewstatusTEMP = MyTurnData.viewstatus
        let gameidTEMP = MyTurnData.gameid
        
        let theImageTEMP = MyTurnData.theImage
        let URLTEMP = MyTurnData.URL
        
        
        print("the Photo ID Selected is \(PhotoSelected)")
        
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        self.TurnStruc.remove(at: RowSelected)
        // self.ViewStatusArray.insert("bestfriends", atIndex: RowSelected)
        self.TurnStruc.insert(TurnSearchInfo(gameturnid: PhotoSelected, mediatype: mediatypeTEMP, gamename: gamenameTEMP, viewstatus: "me", gameid: gameidTEMP, theImage: theImageTEMP, URL: URLTEMP), at: RowSelected)
        
        
        UpdateTurnViewStatus("me", GameTurnID: PhotoSelected as NSString)
        
        self.collectionView?.reloadData()
        
    }
    
    func TurnViewStatusClickedBestFriends(_ sender: UIButton!) {
        let RowSelected = sender.tag
        let MyTurnData = TurnStruc[RowSelected]
        
        print("the turn rowselected: \(sender.tag)")
        // let PhotoSelected = PhotoID[RowSelected].description
        let PhotoSelected = MyTurnData.gameturnid
        
        // let gameturnidTEMP = MyTurnData.gameturnid
        let mediatypeTEMP = MyTurnData.mediatype
        let gamenameTEMP = MyTurnData.gamename
        let viewstatusTEMP = MyTurnData.viewstatus
        let gameidTEMP = MyTurnData.gameid
        
        let theImageTEMP = MyTurnData.theImage
        let URLTEMP = MyTurnData.URL
        
        
        print("the Photo ID Selected is \(PhotoSelected)")
        
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        self.TurnStruc.remove(at: RowSelected)
        // self.ViewStatusArray.insert("bestfriends", atIndex: RowSelected)
        self.TurnStruc.insert(TurnSearchInfo(gameturnid: PhotoSelected, mediatype: mediatypeTEMP, gamename: gamenameTEMP, viewstatus: "bestfriends", gameid: gameidTEMP, theImage: theImageTEMP, URL: URLTEMP), at: RowSelected)
        
        //), atIndex: <#T##Int#>)  .insert("bestfriends", atIndex: RowSelected)
        
        UpdateTurnViewStatus("bestfriends", GameTurnID: PhotoSelected as NSString)
        
        self.collectionView?.reloadData()
        
    }
    func TurnViewStatusClickedFriends(_ sender: UIButton!) {
        
        let RowSelected = sender.tag
        
        let MyTurnData = TurnStruc[RowSelected]
        
        print("the turn rowselected: \(sender.tag)")
        //  let PhotoSelected = PhotoID[RowSelected].description
        let PhotoSelected = MyTurnData.gameturnid
        
        print("the Photo ID Selected is \(PhotoSelected)")
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        // self.ViewStatusArray.insert("friends", atIndex: RowSelected)
        
        // let PhotoSelected = MyTurnData.gameturnid
        
        
        // let gameturnidTEMP = MyTurnData.gameturnid
        let mediatypeTEMP = MyTurnData.mediatype
        let gamenameTEMP = MyTurnData.gamename
        let viewstatusTEMP = MyTurnData.viewstatus
        let gameidTEMP = MyTurnData.gameid
        
        let theImageTEMP = MyTurnData.theImage
        let URLTEMP = MyTurnData.URL
        
        
        print("the Photo ID Selected is \(PhotoSelected)")
        
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        self.TurnStruc.remove(at: RowSelected)
        // self.ViewStatusArray.insert("bestfriends", atIndex: RowSelected)
        self.TurnStruc.insert(TurnSearchInfo(gameturnid: PhotoSelected, mediatype: mediatypeTEMP, gamename: gamenameTEMP, viewstatus: "friends", gameid: gameidTEMP, theImage: theImageTEMP, URL: URLTEMP), at: RowSelected)
        
        UpdateTurnViewStatus("friends", GameTurnID: PhotoSelected as NSString)
        
        
        self.collectionView?.reloadData()
        
    }
    
    func TurnViewStatusClickedPublic(_ sender: UIButton!) {
        
        let RowSelected = sender.tag
        
        let MyTurnData = TurnStruc[RowSelected]
        
        print("the turn rowselected: \(sender.tag)")
        //  let PhotoSelected = PhotoID[RowSelected].description
        let PhotoSelected = MyTurnData.gameturnid
        
        print("the Photo ID Selected is \(PhotoSelected)")
        //   self.ViewStatusArray.removeAtIndex(RowSelected)
        //   self.ViewStatusArray.insert("public", atIndex: RowSelected)
        
        // let PhotoSelected = MyTurnData.gameturnid
        
        
        // let gameturnidTEMP = MyTurnData.gameturnid
        let mediatypeTEMP = MyTurnData.mediatype
        let gamenameTEMP = MyTurnData.gamename
        _ = MyTurnData.viewstatus
        let gameidTEMP = MyTurnData.gameid
        
        let theImageTEMP = MyTurnData.theImage
        let URLTEMP = MyTurnData.URL
        
        
        print("the Photo ID Selected is \(PhotoSelected)")
        
        // self.ViewStatusArray.removeAtIndex(RowSelected)
        self.TurnStruc.remove(at: RowSelected)
        // self.ViewStatusArray.insert("bestfriends", atIndex: RowSelected)
        self.TurnStruc.insert(TurnSearchInfo(gameturnid: PhotoSelected, mediatype: mediatypeTEMP, gamename: gamenameTEMP, viewstatus: "public", gameid: gameidTEMP, theImage: theImageTEMP, URL: URLTEMP), at: RowSelected)
        
        UpdateTurnViewStatus("public", GameTurnID: PhotoSelected as NSString)
        
        
        self.collectionView?.reloadData()
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let theGameData = ThisGameTurnInfoArray[(indexPath as NSIndexPath).row]
        
        
        
        //var string = PhotoID[indexPath.row] as String
        
       // var string = theGame.gameturnid
        
        //PhotoID[indexPath.row] as String
        
        // var word = "Apple"
        // var string = "Hello Swift"
        /*
        if let range = string.rangeOfString("Turn") {
            let firstPart = string[string.startIndex..<range.startIndex]
            print(firstPart) // print Hello
            let lastPart = string[range.startIndex..<string.endIndex]
            print("last part = \(lastPart)")
            
            switch lastPart {
            case "Turn1":
                NewTurnNumber = ""
            case "Turn2":
                NewTurnNumber = "\(firstPart)Turn1"
            case "Turn3":
                NewTurnNumber = "\(firstPart)Turn2"
            case "Turn4":
                NewTurnNumber = "\(firstPart)Turn3"
            case "Turn5":
                NewTurnNumber = "\(firstPart)Turn4"
            case "Turn6":
                NewTurnNumber = "\(firstPart)Turn5"
            case "Turn7":
                NewTurnNumber = "\(firstPart)Turn6"
            case "Turn8":
                NewTurnNumber = "\(firstPart)Turn7"
            case "Turn9":
                NewTurnNumber = "\(firstPart)Turn8"
            case "Turn10":
                NewTurnNumber = "\(firstPart)Turn9"
            default:
                NewTurnNumber = ""
            }
            */
            //   let CTF: Character = "n"
            
            //   if let index = find(string, CTF) {
            
            //    NewTurnNumber = string.substringFromIndex(advance(firstPart, 1))
            //     print("new Turn Number = \(NewTurnNumber)")
            //  }
       // }
        /*
        theAudioData = AudioClips[indexPath.row]
        MainImage = Photos[indexPath.row]
        MediaType = MediaTypeArray[indexPath.row]
        TurnInfo = PhotoID[indexPath.row]
        */
        
        // theAudioData = MyTurnData.theImage
        
        /*
        MainImage = MyTurnData.theImage
        theAudioDataURL = MyTurnData.URL
        MainImageURL = MyTurnData.URL
        MediaType = MyTurnData.mediatype
        TurnInfo = MyTurnData.gameturnid
        */
      //  self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
       // return TurnInfo.count
        //        return Photos.count
        return ThisGameTurnInfoArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LikeFailPhotoCell
        //2
        
        
        //var gametype = ThisGameTurnInfoArray[indexPath.row]
        
       // gametype = ThisGameTurnInfoArray[indexPath.row]
        
      //  let MyTurnData = ThisGameTurnInfo[indexPath.row]
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.numberIMG?.image = UIImage(named: "num1.png")
        case 1:
            cell.numberIMG?.image = UIImage(named: "num2.png")
        case 2:
            cell.numberIMG?.image = UIImage(named: "num3.png")
        case 3:
            cell.numberIMG?.image = UIImage(named: "num4.png")
        case 4:
            cell.numberIMG?.image = UIImage(named: "num5.png")
        case 5:
            cell.numberIMG?.image = UIImage(named: "num6.png")
        case 6:
            cell.numberIMG?.image = UIImage(named: "num7.png")
        case 7:
            cell.numberIMG?.image = UIImage(named: "num8.png")
        case 8:
            cell.numberIMG?.image = UIImage(named: "num9.png")
        case 9:
            cell.numberIMG?.image = UIImage(named: "num10.png")
        default:
            break
        }
        
        let MyTurnData = ThisGameTurnInfoArray[(indexPath as NSIndexPath).row]
       // let MyTurnData = ThisGameTurnInfo[indexPath]
        
        cell.TurnImage?.layer.cornerRadius = 5
        cell.TurnImage?.layer.masksToBounds = true
        cell.TurnImage?.layer.borderWidth = 1
        cell.TurnImage?.layer.borderColor = UIColor.white.cgColor
        //UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).CGColor
        cell.playBTN?.tag = (indexPath as NSIndexPath).row
        cell.playBTN?.addTarget(self, action: #selector(GalleryItemViewController.PlayAudioClicked(_:)), for: .touchUpInside)
       // cell.playBTN?.tag = indexPath.row
        
        cell.meBTN?.addTarget(self, action: #selector(GalleryItemViewController.ShareImageClicked(_:)), for: .touchUpInside)
        cell.meBTN?.tag = (indexPath as NSIndexPath).row
        cell.friendsBTN?.addTarget(self, action: #selector(GalleryItemViewController.NewFailClicked(_:)), for: .touchUpInside)
        cell.friendsBTN?.tag = (indexPath as NSIndexPath).row
        cell.publicBTN?.addTarget(self, action: #selector(GalleryItemViewController.NewLikeClicked(_:)), for: .touchUpInside)
        cell.publicBTN?.tag = (indexPath as NSIndexPath).row
        cell.bestfriendsBTN?.addTarget(self, action: #selector(GalleryItemViewController.ViewCommentsClicked(_:)), for: .touchUpInside)
        cell.bestfriendsBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.playBTN?.isHidden = false
        
        cell.meBTN?.isHidden = true
        cell.friendsBTN?.isHidden = true
        cell.publicBTN?.isHidden = true
        cell.bestfriendsBTN?.isHidden = true
        // cell.myLabel.text = self.items[indexPath.item]
        
        var mediaSuf = NSString()
        print("cell media type = \(MyTurnData.mediaType)")
        switch MyTurnData.mediaType {
           case "quote":
            mediaSuf = ".jpg"
        case "image":
            mediaSuf = ".jpg"
        case "gif":
            mediaSuf = ".gif"
        case "audio":
            mediaSuf = ".mp3"
        
            
        default:
            break
            
            
        }
        
        print("Cell URL index \((indexPath as NSIndexPath).row) = \(MyTurnData.turnURL)\(mediaSuf)")
        
        if MyTurnData.mediaType == "audio" {
            
            cell.TurnImage?.image = boomBox
           // cell.TurnImage?.image = MyTurnData.theImage as UIImage
          //  cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = false
            
            
        } else {
            

            // if MyTurnData.mediatype == "image" {
            
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            
           
            
            
            let request: URLRequest = URLRequest(url: URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")!)
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
            
                    if !self.fileExists(URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")) {
                    print("file DOES NOT exists - \(MyTurnData.turnURL)\(mediaSuf)")
                    cell.TurnImage?.image = UIImage(named: "no Image.png")
                    
                    } else {
            print("file exists - \(MyTurnData.turnURL)\(mediaSuf)")
                    DispatchQueue.main.async(execute: {
                        if let cellToUpdate = collectionView.cellForItem(at: indexPath) {
                            
                            // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                            
                            if MyTurnData.mediaType == "gif" {
                                cell.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                            } else {
                                
                                cell.TurnImage?.image = image
                                
                            }
                            //let GIFData = NSData
                            
                            // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                            //cellToUpdate.TurnImage?.image = image
                        }
                    })
                   // }
                  }
                    
                }
                else {
                    //cell.TurnImage?.image = MyTurnData.theImage as UIImage
                    cell.TurnImage?.image = UIImage(named: "no Image.png")
                    print("Error: \(error!.localizedDescription)")
                }
            })
            
            
         //   }
            /*
            if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: MyTurnData.URL)) {
            // print("image Data = \(data)")
            //make sure your image in this url does exist, otherwise unwrap in a if let check
            cell.TurnImage?.image = UIImage(data: data)!
            } else {
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            }
            */
            
           // cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = true
            
            
        }
        
        /*
        
        if MyTurnData.mediatype == "audio" {
        
        cell.TurnImage?.image = MyTurnData.theImage as UIImage
        cell.CellLBL?.text = MyTurnData.gamename as String
        cell.playBTN?.hidden = false
        
        
        }
        
        */
        
        
        
        
        
        
        /*
        
        // cell.myLabel.text = self.items[indexPath.item]
        cell.TurnImage?.image = Photos[indexPath.row] as UIImage
        cell.TurnImage?.layer.cornerRadius = 5
        cell.TurnImage?.layer.masksToBounds = true
        
        cell.playBTN?.addTarget(self, action: "PlayAudioClicked:", forControlEvents: .TouchUpInside)
        
        cell.playBTN?.tag = indexPath.row
        
        
        
        cell.meBTN?.addTarget(self, action: "TurnViewStatusClickedMe:", forControlEvents: .TouchUpInside)
        cell.meBTN?.tag = indexPath.row
        cell.friendsBTN?.addTarget(self, action: "TurnViewStatusClickedFriends:", forControlEvents: .TouchUpInside)
        cell.friendsBTN?.tag = indexPath.row
        cell.publicBTN?.addTarget(self, action: "TurnViewStatusClickedPublic:", forControlEvents: .TouchUpInside)
        cell.publicBTN?.tag = indexPath.row
        cell.bestfriendsBTN?.addTarget(self, action: "TurnViewStatusClickedBestFriends:", forControlEvents: .TouchUpInside)
        cell.bestfriendsBTN?.tag = indexPath.row
        
        */
        
        // switch ViewStatusArray[indexPath.row] {
        /*
        switch MyTurnData.viewstatus {
            
        case "public":
            print("public")
            
            cell.publicIMG?.image = PublicIconCK
            cell.meIMG?.image = MeIcon
            cell.friendsIMG?.image = FriendsIcon
            cell.bestfriendsIMG?.image = BestFriendsIcon
            
        case "me":
            print("me")
            
            cell.publicIMG?.image = PublicIcon
            cell.meIMG?.image = MeIconCK
            cell.friendsIMG?.image = FriendsIcon
            cell.bestfriendsIMG?.image = BestFriendsIcon
            
        case "friends":
            print("friends")
            
            cell.publicIMG?.image = PublicIcon
            cell.meIMG?.image = MeIcon
            cell.friendsIMG?.image = FriendsIconCK
            cell.bestfriendsIMG?.image = BestFriendsIcon
            
        case "bestfriends":
            print("best Friends")
            
            cell.publicIMG?.image = PublicIcon
            cell.meIMG?.image = MeIcon
            cell.friendsIMG?.image = FriendsIcon
            cell.bestfriendsIMG?.image = BestFriendsIconCK
            
            
        default:
            print("Default")
            
            cell.publicIMG?.image = PublicIconCK
            cell.meIMG?.image = MeIcon
            cell.friendsIMG?.image = FriendsIcon
            cell.bestfriendsIMG?.image = BestFriendsIcon
            
            
        }
        */
        
        
        // cell.playBTN?.hidden = HideAudioArray[indexPath.row]
        
        
        /*
        if NumFails[indexPath.row] as String == "1" {
        cell.CellLBL?.text = "\(NumFails[indexPath.row] as String)"
        } else {
        cell.CellLBL?.text = "\(NumFails[indexPath.row] as String)"
        }
        
        */
        //cell.TurnImage?.image = PhotoST[indexPath.row].theImage as UIImage
        //let LikeFailPhoto = photoForIndexPath(indexPath)
        // cell.backgroundColor = UIColor.blackColor()
        //3
        //  cell.imageView.image = LIkeFailPhoto.thumbnail
        
        return cell
    }
    
    
    /*
    
    func load_images(ImageURLArray:[String]) -> [UIImage]
    {
    
    var ImagesReturned = [UIImage]()
    
    for stringImage in ImageURLArray {
    
    
    
    var imgURL: NSURL = NSURL(string: stringImage)!
    
    let data = NSData(contentsOfURL: imgURL) //make sure your image in this url does exist, otherwise unwrap in a if let check
    let theImage = UIImage(data: data!)
    ImagesReturned.append(theImage!)
    
    }
    return ImagesReturned
    }
    
    */
    
    
    @IBAction func ViewComments(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "ShowComments", sender: self)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showImage" {
            
            
            if let destination = segue.destination as? CollectionImageViewController {
                
                destination.MediaType = self.MediaType as String
                destination.MainImage = self.MainImage
                destination.MainImageURL = self.MainImageURL
                //destination.ShowB2 = true
                destination.NewTurnNumber = self.NewTurnNumber
                destination.AudioData = self.theAudioData
                destination.AudioDataURL = self.theAudioDataURL
                
                destination.IsMyTurns = true
                destination.TurnInfo = self.TurnInfo
                //  destination.playerID = self.replyUserID
                print("Profile show segue")
            }
        }
    
    
    if segue.identifier == "ShowComments" {
        if let destination = segue.destination as? CommentsViewController {
            
            //destination.NumComments = NumComments
            destination.GameID = GameID
            destination.ReplyUserID = userID
            destination.ReplyUser = username
            //
        }
    }
    
    if segue.identifier == "SocialMedia" {
        if let destination = segue.destination as? SocialViewController {
            
            destination.view.backgroundColor = UIColor.clear
            
            
            //
        }
    }
    
    
    }
    
    func FilterMyLikeFailPhotoData(_ urlData: Data) -> [PhotoInfo] {
        /*
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        */
        if !isLoadingMore {
            print("Should remove all since it's not loading")
            //self.RemoveAllFromArray()
        }
        
        let PhotoData = [PhotoInfo]()
        
        
        // var Game_ID_Array = [NSString]()
        //  var Game_CountArray = [NSString]()
        //  var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON MY LIKE FAIL: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["gameturnid"] != "NA") {
                
                // let gameidtemp = result["gameid"].stringValue
                //  let viewstatustemp = result["viewstatus"].stringValue
                let photo_ID = result["gameturnid"].stringValue
                //  let gamenametemp = result["gamename"].stringValue
                let mediatype_temp = result["mediatype"].stringValue
                // print("username = \(game_username)")
                
                
                
                let gameidtemp = "temp"
                let viewstatustemp = "temp"
                //   let photo_ID = result["gameturnid"].stringValue
                let gamenametemp = "temp"
                //  let mediatype_temp = "temp"
                
                
                // LvarNum++
                // LNumbers.append(LvarNum.description)
                
                var imgStringTemp = String()
                let tempNSData = Data()
                //  let game_likes = result["totallikes"].stringValue
                
                
                if mediatype_temp == "image" {
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).jpg"
                        let imgURLtemp = URL(string: imgStringTemp)
                        print("Temp URL String = \(imgStringTemp)")
                        var PhotoImageTemp = UIImage()
                        
                        
                        if let data = try? Data(contentsOf: imgURLtemp!) {
                            // print("image Data = \(data)")
                            //make sure your image in this url does exist, otherwise unwrap in a if let check
                            PhotoImageTemp = UIImage(data: data)!
                            
                            //  dispatch_async(dispatch_get_main_queue(),{
                            
                            // let TempPhotoInfo = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp)
                            
                            //  print("tempPhoto Info = \(TempPhotoInfo)")
                            //  PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                            
                            // self.AudioClips.append(data)
                            self.Photos.append(PhotoImageTemp)
                            
                        }
                        self.AudioClips.append(tempNSData)
                        self.MediaTypeArray.append(mediatype_temp as NSString)
                        self.AudioStringArray.append("")
                        self.NumFails2.append(gamenametemp as NSString)
                        self.PhotoID.append(photo_ID as NSString)
                        self.HideAudioArray.append(true)
                        self.ViewStatusArray.append(viewstatustemp as NSString)
                        //   })
                        
                    })
                    
                }
                
                
                
                if mediatype_temp == "audio" {
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).mp3"
                        
                        let imgURLtemp = URL(string: imgStringTemp)
                        
                        print("Temp URL String = \(imgStringTemp)")
                        
                        var PhotoImageTemp = UIImage()
                        
                        
                        if let data = try? Data(contentsOf: imgURLtemp!) {
                            //  print("image Data = \(data)")
                            //make sure your image in this url does exist, otherwise unwrap in a if let check
                            //  PhotoImageTemp = UIImage(data: data)!
                            
                            //  dispatch_async(dispatch_get_main_queue(),{
                            
                            // let TempPhotoInfo = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp)
                            
                            //  print("tempPhoto Info = \(TempPhotoInfo)")
                            // PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                            self.AudioClips.append(data)
                            //self.Photos.append(PhotoImageTemp)
                            
                        }
                        
                        
                        //   })
                        
                        
                        self.AudioStringArray.append(imgStringTemp)
                        self.Photos.append(self.boomBox!)
                        self.NumFails2.append(gamenametemp as NSString)
                        self.PhotoID.append(photo_ID as NSString)
                        self.HideAudioArray.append(false)
                        
                        self.MediaTypeArray.append(mediatype_temp as NSString)
                        self.ViewStatusArray.append(viewstatustemp as NSString)
                    })
                }
                
                /*
                else {
                self.Photos.append(self.boomBox!)
                self.NumFails.append(count_temp)
                self.PhotoID.append(photo_ID)
                
                }
                
                */
                
                //  PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                
                //var TempPhoto = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp)
                
                // Game_ID_Array.append(game_username)
                //  Game_CountArray.append(game_likes)
                //  GameUserIDArray.append(game_userID)
                
                
            }
            
        }
        
        print("PhotoData Struct FROM END FILTERING = \(PhotoData)")
        print("Photos Count FROM END FILTERING = \(Photos.count)")
        return PhotoData
        
    }
    
    
    func FilterLikeFailPhotoData(_ urlData: Data) -> [PhotoInfo] {
        /*
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        */
        //self.RemoveAllFromArray()
        
        let PhotoData = [PhotoInfo]()
        
        
        // var Game_ID_Array = [NSString]()
        //  var Game_CountArray = [NSString]()
        //  var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON ALL LIKE FAIL: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["username"] != "NA") {
                
                let gameidtemp = result["gameid"].stringValue
                let viewstatustemp = result["viewstatus"].stringValue
                let photo_ID = result["gameturnid"].stringValue
                let gamenametemp = result["gamename"].stringValue
                let mediatype_temp = result["mediatype"].stringValue
                // print("username = \(game_username)")
                
                // LvarNum++
                // LNumbers.append(LvarNum.description)
                
                var imgStringTemp = String()
                let tempNSData = Data()
                //  let game_likes = result["totallikes"].stringValue
                if mediatype_temp == "image" {
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).jpg"
                        let imgURLtemp = URL(string: imgStringTemp)
                        print("Temp URL String = \(imgStringTemp)")
                        var PhotoImageTemp = UIImage()
                        
                        
                        if let data = try? Data(contentsOf: imgURLtemp!) {
                            // print("image Data = \(data)")
                            //make sure your image in this url does exist, otherwise unwrap in a if let check
                            PhotoImageTemp = UIImage(data: data)!
                            
                            //  dispatch_async(dispatch_get_main_queue(),{
                            
                            // let TempPhotoInfo = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp)
                            
                            //  print("tempPhoto Info = \(TempPhotoInfo)")
                            //  PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                            
                            // self.AudioClips.append(data)
                            self.Photos.append(PhotoImageTemp)
                            
                        }
                        self.AudioClips.append(tempNSData)
                        self.MediaTypeArray.append(mediatype_temp as NSString)
                        self.AudioStringArray.append("")
                        self.NumFails2.append(gamenametemp as NSString)
                        self.PhotoID.append(photo_ID as NSString)
                        self.HideAudioArray.append(true)
                        self.ViewStatusArray.append(viewstatustemp as NSString)
                        //   })
                        
                    })
                    
                }
                
                
                
                if mediatype_temp == "audio" {
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).mp3"
                        
                        let imgURLtemp = URL(string: imgStringTemp)
                        
                        print("Temp URL String = \(imgStringTemp)")
                        
                        var PhotoImageTemp = UIImage()
                        
                        
                        if let data = try? Data(contentsOf: imgURLtemp!) {
                            //  print("image Data = \(data)")
                            //make sure your image in this url does exist, otherwise unwrap in a if let check
                            //  PhotoImageTemp = UIImage(data: data)!
                            
                            //  dispatch_async(dispatch_get_main_queue(),{
                            
                            // let TempPhotoInfo = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp)
                            
                            //  print("tempPhoto Info = \(TempPhotoInfo)")
                            // PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                            self.AudioClips.append(data)
                            //self.Photos.append(PhotoImageTemp)
                            
                        }
                        
                        
                        //   })
                        
                        
                        self.AudioStringArray.append(imgStringTemp)
                        self.Photos.append(self.boomBox!)
                        self.NumFails2.append(gamenametemp as NSString)
                        self.PhotoID.append(photo_ID as NSString)
                        self.HideAudioArray.append(false)
                        
                        self.MediaTypeArray.append(mediatype_temp as NSString)
                        self.ViewStatusArray.append(viewstatustemp as NSString)
                    })
                }
                
                /*
                else {
                self.Photos.append(self.boomBox!)
                self.NumFails.append(count_temp)
                self.PhotoID.append(photo_ID)
                
                }
                
                */
                
                //  PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                
                //var TempPhoto = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp)
                
                // Game_ID_Array.append(game_username)
                //  Game_CountArray.append(game_likes)
                //  GameUserIDArray.append(game_userID)
                self.collectionView?.reloadData()
                
            }
            
        }
        
        print("PhotoData Struct = \(PhotoData)")
        print("Photos Count = \(Photos.count)")
        return PhotoData
        
    }
    
    
    
    
    
    func FilterGameData(_ urlData: Data) -> [TurnSearchInfo] {
        /*
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        */
        //self.RemoveAllFromArray()
        
        var TurnStrucTemp = [TurnSearchInfo]()
        
        
        // var Game_ID_Array = [NSString]()
        //  var Game_CountArray = [NSString]()
        //  var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON ALL LIKE FAIL: \(json)")
        
        var MyTotalTurnsTemp = json["totalTurns"].stringValue
        if MyTotalTurnsTemp == "" {
            MyTotalTurnsTemp = "0"
        }
        MyTotalTurns = Int(MyTotalTurnsTemp)!
        
        print("My Total Turns = \(MyTotalTurns.description)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["gameid"] != "NA") {
                
                let gameidtemp = result["gameid"].stringValue
                let viewstatustemp = result["viewstatus"].stringValue
                let photo_ID = result["gameturnid"].stringValue
                let gamenametemp = result["gamename"].stringValue
                let mediatype_temp = result["mediatype"].stringValue
                // print("username = \(game_username)")
                
                // LvarNum++
                // LNumbers.append(LvarNum.description)
                
                var imgStringTemp = String()
                var tempImage = UIImage()
                //  var tempNSData = NSData()
                //  let game_likes = result["totallikes"].stringValue
                
                
                if mediatype_temp == "image" {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).jpg"
                    
                    
                    /*
                    if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: imgStringTemp)) {
                    // print("image Data = \(data)")
                    //make sure your image in this url does exist, otherwise unwrap in a if let check
                    tempImage = UIImage(data: data)!
                    
                    //  dispatch_async(dispatch_get_main_queue(),{
                    
                    // let TempPhotoInfo = PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp)
                    
                    //  print("tempPhoto Info = \(TempPhotoInfo)")
                    //  PhotoData.append(PhotoInfo(username: game_username, userid: game_userID, theImage: PhotoImageTemp, total: count_temp))
                    
                    // self.AudioClips.append(data)
                    //self.Photos.append(PhotoImageTemp)
                    Photos.append(tempImage)
                    
                    }
                    
                    */
                    
                    
                    tempImage = UIImage(named: "noImage.png")!
                    
                    //UIImage(
                } else if mediatype_temp == "audio" {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).mp3"
                    tempImage = self.boomBox!
                    Photos.append(tempImage)
                } else if mediatype_temp == "gif" {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).gif"
                    tempImage = UIImage(named: "noImage.png")!
                    Photos.append(tempImage)
                    
                } else {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).jpg"
                    tempImage = UIImage(named: "noImage.png")!
                    Photos.append(tempImage)
                    
                }
                
                
                TurnStrucTemp.append(TurnSearchInfo(gameturnid: photo_ID, mediatype: mediatype_temp, gamename: gamenametemp, viewstatus: viewstatustemp, gameid: gameidtemp, theImage: tempImage, URL: imgStringTemp))
            }
            
        }
        
        //  print("PhotoData Struct = \(TurnStrucTemp)")
        // print("Photos Count = \(Photos.count)")
        return TurnStrucTemp
        
    }
    
    
    
    
    struct PhotoInfo {
        var username: String
        var userid: String
        var theImage: UIImage
        var total: String
        init(username: String, userid: String, theImage: UIImage, total: String) {
            self.username = username
            self.userid = userid
            self.theImage = theImage
            self.total = total
        }
    }
    
    @IBAction func bestfriendsIconBTN(_ sender: AnyObject) {
        
        let AC = JSController("Best Friends", MyMessage: "This sets the turn to be viewable by only your best friends.  Add 'Best Friends' by going to 'My Friends' from the home screen or the main slide out menu.",Color: "Red")
        
        // self.presentViewController(AC, animated: true, completion: nil)
        
        
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "BestFriendsIcon.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Best Friends", subTitle: "This sets the turn to be viewable by only your best friends.  Add 'Best Friends' by going to 'My Friends' from the home screen or the main slide out menu.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    
    
    @IBAction func meIconBTN(_ sender: AnyObject) {
        
        let AC = JSController("Just Me", MyMessage: "This sets the turn to only be viewable by you...come on that's no fun.",Color: "Red")
        
        //self.presentViewController(AC, animated: true, completion: nil)
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "MeIcon2.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Just Me", subTitle: "This sets the turn to only be viewable by you...come on that's no fun.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    
    @IBAction func friendsIconBTN(_ sender: AnyObject) {
        let AC = JSController("Friends", MyMessage: "This sets the turn to be viewable by all your friends.  Add Friends by going to  'My Friends' from the home screen or the main slide out menu.",Color: "Red")
        
        //self.presentViewController(AC, animated: true, completion: nil)
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "FriendsIcon2-1.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Friends", subTitle: "This sets the turn to be viewable by all your friends.  Add Friends by going to  'My Friends' from the home screen or the main slide out menu.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    @IBAction func publicIconBTN(_ sender: AnyObject) {
        let AC = JSController("Public", MyMessage: "This sets the turn to be viewable by all players",Color: "Red")
        
        // self.presentViewController(AC, animated: true, completion: nil)
        
        DispatchQueue.main.async(execute: {
            
            SCLAlertView().showCustomOK(UIImage(named: "PublicIcon3.png")!, color: UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), title: "Public", subTitle: "This sets the turn to be viewable by all players", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        })
        
    }
    
    
    
    @IBOutlet weak var friendsIconBTN: UIButton!
    @IBOutlet weak var meIconBTN: UIButton!
    
    

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        //  print("ContentOffset = \(contentOffset)")
        //  print("maximumOffset = \(maximumOffset)")
        //   print("Threshold = \(threshold)")
        let cmm = maximumOffset - contentOffset
        //   print("max - content = \(cmm)")
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            
            
            if NumTurnsLoaded >= MyTotalTurns {
                print("No MORE TURNS TO LOAD")
                NumTurnsLoaded = MyTotalTurns
            } else {
                
                // let SaveProgressHUD3 = ProgressHUD(text: "Loading More...")
                //  self.view.addSubview(SaveProgressHUD3)
                
                print("is at bottom")
                // Get more data - API call
                //self.NumTurnsLoaded = self.NumTurnsLoaded + 5
                print("Number of Turns Currently loaded = \(self.NumTurnsLoaded)")
                
                self.isLoadingMore = true
                
               // self.LoadNextFive(self.NumTurnsLoaded)
                
                
                // Update UI
                
                
                DispatchQueue.main.async {
                    self.collectionView!.reloadData()
                    self.isLoadingMore = false
                    
                    
                    //   SaveProgressHUD3.removeFromSuperview()
                    
                }
            }
            
        }
        
        if !isLoadingMore && (maximumOffset - contentOffset >= (maximumOffset)) {
            
            
            print("is at top")
            
            //   print("table view height1 = \(self.collectionView!.contentSize.height)")
            
            /*
            if !isShareShowing {
            // self.TableViewBOTTOM.constant = -100
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            
            self.shareExpView.center.y = self.shareExpView.center.y + 110
            self.TableView.center.y = self.TableView.center.y + 110
            print("table view height2 = \(self.TableView.contentSize.height)")
            self.shareExpViewTOP.constant = 0
            
            }, completion: { (Bool) -> Void in
            })
            isShareShowing = true
            //  self.TableViewBOTTOM.constant = 0
            }
            */
            
            //    print("table view height3 = \(self.collectionView!.contentSize.height)")
            // Get more data - API call
            //  self.isLoadingMore = true
            
            // Update UI
            
            /*
            dispatch_async(dispatch_get_main_queue()) {
            TableView.reloadData()
            self.isLoadingMore = false
            }
            
            */
        }
        
        
        
        let yPos: CGFloat = -scrollView.contentOffset.y
        //   print("yPos = \(yPos)")
        
        let tHeight = scrollView.contentSize.height
        //  print("theight = \(tHeight)")
        // let tTop = scrollView.layer.
        
        
        if !isRefreshing {
            if yPos < TableYPos {
                print("Scrolling Down")
                
                if yPos < -150 {
                    
                    /*
                    if isShareShowing {
                    
                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                    
                    
                    self.shareExpView.center.y = self.shareExpView.center.y - 110
                    self.TableView.center.y = self.TableView.center.y - 110
                    print("table view height2 = \(self.TableView.contentSize.height)")
                    self.shareExpViewTOP.constant = -110
                    
                    }, completion: { (Bool) -> Void in
                    })
                    isShareShowing = false
                    
                    }
                    
                    */
                }
                
                
            } else {
                print("Scrolling Up")
                
                /*
                
                if !isShareShowing {
                
                // print("Scrolling up")
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                // self.shareExpView.frame = CGRectMake(0, 64, self.view.frame.width, 110)
                
                self.shareExpView.center.y = self.shareExpView.center.y + 110
                // self.TableView.center.y = self.TableView.center.y - 100
                self.shareExpViewTOP.constant = 0
                // self.TableView.contentOffset = CGPointMake(0, self.TableView.contentOffset.y - 110);
                //  self.TableView.contentInset =  UIEdgeInsets(top: self.view.bounds.height, left: 0, bottom: 0, right: 0)
                // self.TableViewTOP.constant = 110
                }, completion: { (Bool) -> Void in
                })
                isShareShowing = true
                
                }
                
                */
                
            }
            TableYPos = yPos
            
        } else {
            print("is refreshing, don't scroll")
            
            
            
            
            
        }
        /*
        if yPos < TableYPos {
        print("Scrolling Down")
        
        
        if isShareShowing {
        
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
        // self.shareExpView.frame = CGRectMake(0, 64, self.view.frame.width, 110)
        
        self.shareExpView.center.y = self.shareExpView.center.y - 110
        // self.TableView.center.y = self.TableView.center.y + 100
        self.shareExpViewTOP.constant = -110
        
        self.TableViewTOP.constant = 0
        }, completion: { (Bool) -> Void in
        })
        isShareShowing = false
        
        }
        
        
        
        
        } else {
        print("Scrolling up")
        
        
        
        if !isShareShowing {
        
        // print("Scrolling up")
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
        // self.shareExpView.frame = CGRectMake(0, 64, self.view.frame.width, 110)
        
        self.shareExpView.center.y = self.shareExpView.center.y + 110
        // self.TableView.center.y = self.TableView.center.y - 100
        self.shareExpViewTOP.constant = 0
        
        //  self.TableView.contentInset =  UIEdgeInsets(top: self.view.bounds.height, left: 0, bottom: 0, right: 0)
        self.TableViewTOP.constant = 110
        }, completion: { (Bool) -> Void in
        })
        isShareShowing = true
        
        }
        
        
        
        }
        TableYPos = yPos
        */
        
        if (yPos > 0) {
            
            /*
            if !isShareShowing {
            
            // print("Scrolling up")
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
            // self.shareExpView.frame = CGRectMake(0, 64, self.view.frame.width, 110)
            
            self.shareExpView.center.y = self.shareExpView.center.y + 110
            
            self.shareExpViewTOP.constant = 0
            // self.TableView.center.y = self.TableView.center.y - 100
            
            self.TableView.contentInset =  UIEdgeInsets(top: self.view.bounds.height, left: 0, bottom: 0, right: 0)
            self.TableViewTOP.constant = 100
            }, completion: { (Bool) -> Void in
            })
            isShareShowing = true
            
            }
            */
            
        } else {
            
            if (yPos < -0.5) {
                
                //   print("Scrolling down")
                
                
            }
            
        }
        
        
    }
    
    
    func downloadedFrom(link:String, ImageNumber: String) {
        
        //var image = UIImage(named: "noImage.png")!
        
        guard
            let url = URL(string: link)
            else {
                let image = UIImage(named: "noImage.png")!
                switch ImageNumber {
                    
                case "1":
                    self.image1 = image
                case "2":
                    self.image2 = image
                case "3":
                    self.image3 = image
                case "4":
                    self.image4 = image
                case "5":
                    self.image5 = image
                case "6":
                    self.image6 = image
                case "7":
                    self.image7 = image
                case "8":
                    self.image8 = image
                case "9":
                    self.image9 = image
                case "10":
                    self.image10 = image
                    
                default:
                    break
                }
                
                return}
        // contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
                
               
                else {
                    let image = UIImage(named: "noImage.png")!
                    switch ImageNumber {
                        
                    case "1":
                        self.image1 = image
                    case "2":
                        self.image2 = image
                    case "3":
                        self.image3 = image
                    case "4":
                        self.image4 = image
                    case "5":
                        self.image5 = image
                    case "6":
                        self.image6 = image
                    case "7":
                        self.image7 = image
                    case "8":
                        self.image8 = image
                    case "9":
                        self.image9 = image
                    case "10":
                        self.image10 = image
                        
                    default:
                        break
                    }
                    
                    return }
            DispatchQueue.main.async { () -> Void in
                //self.image = image
               // return image
                
                
                switch ImageNumber {
                    
                case "1":
                    self.image1 = image
                case "2":
                    self.image2 = image
                case "3":
                    self.image3 = image
                case "4":
                    self.image4 = image
                case "5":
                    self.image5 = image
                case "6":
                    self.image6 = image
                case "7":
                    self.image7 = image
                case "8":
                    self.image8 = image
                case "9":
                    self.image9 = image
                case "10":
                    self.image10 = image
                    
                default:
                    break
                }
            }
        }).resume()
    }
    
    func DownloadImage() {
         self.images.removeAll()
         self.Quotes.removeAll()
        
         //Quotes = TurnStrings
        
        let Turn1 = ThisGameTurnInfoArray[0]
        let Turn2 = ThisGameTurnInfoArray[1]
        let Turn3 = ThisGameTurnInfoArray[2]
        let Turn4 = ThisGameTurnInfoArray[3]
        let Turn5 = ThisGameTurnInfoArray[4]
        let Turn6 = ThisGameTurnInfoArray[5]
        let Turn7 = ThisGameTurnInfoArray[6]
        let Turn8 = ThisGameTurnInfoArray[7]
        let Turn9 = ThisGameTurnInfoArray[8]
        let Turn10 = ThisGameTurnInfoArray[9]
        
        switch Turn1.mediaType {
        case "audio":
            
            self.image1 = boomBox!
            //downloadedFrom(link: "\(Turn1.turnURL).mp3", ImageNumber: "1")
            
            if let url = URL(string: "\(Turn1.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio1 = data
                }
            }
            Quotes.append("")
            print("quote 1 added")
            
        case "gif":
            downloadedFrom(link: "\(Turn1.turnURL).gif", ImageNumber: "1")
            if let url = URL(string: "\(Turn1.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image1 = UIImage(data: data)!
                }
            }
             self.Audio1 = EmptyAudio
             Quotes.append("")
            print("quote 1 added")
        default:
            //downloadedFrom(link: "\(Turn1.turnURL).jpg", ImageNumber: "1")
            if let url = URL(string: "\(Turn1.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image1 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[0])
                    print("quote 1 added")
                }
            } else {
                Quotes.append(TurnStrings[0])
                print("quote 1 added")
            }
            self.Audio1 = EmptyAudio
        }
        
        switch Turn2.mediaType {
        case "audio":
       //downloadedFrom(link: "\(Turn2.turnURL).mp3", ImageNumber: "2")
            if let url = URL(string: "\(Turn2.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio2 = data
                }
            }
             Quotes.append("")
            print("quote 2 added")
        self.image2 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn2.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image2 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            print("quote 2 added")
            self.Audio2 = EmptyAudio
        default:
        // downloadedFrom(link: "\(Turn2.turnURL).jpg", ImageNumber: "2")
            
            if let url = URL(string: "\(Turn2.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image2 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[1])
                    print("quote 2 added")
                }
            } else {
                Quotes.append(TurnStrings[1])
                print("quote 2 added")
            }
            self.Audio2 = EmptyAudio
        }
        
        switch Turn3.mediaType {
        case "audio":
            
            if let url = URL(string: "\(Turn3.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio3 = data
                }
            }
             Quotes.append("")
            print("quote 3 added")
            self.image3 = boomBox!
        //downloadedFrom(link: "\(Turn3.turnURL).mp3", ImageNumber: "3")
            
        case "gif":
            if let url = URL(string: "\(Turn3.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image3 = UIImage(data: data)!
                    
                }
            }
             Quotes.append("")
            self.Audio3 = EmptyAudio
        default:
        //downloadedFrom(link: "\(Turn3.turnURL).jpg", ImageNumber: "3")
            if let url = URL(string: "\(Turn3.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image3 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[2])
                }
            } else {
                Quotes.append(TurnStrings[2])
            }
            self.Audio3 = EmptyAudio
        }
        
        switch Turn4.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn4.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio4 = data
                }
            }
             Quotes.append("")
            self.image4 = boomBox!
        // downloadedFrom(link: "\(Turn4.turnURL).mp3", ImageNumber: "4")
            
        case "gif":
            if let url = URL(string: "\(Turn4.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image4 = UIImage(data: data)!
                   
                }
            }
             Quotes.append("")
            self.Audio4 = EmptyAudio
        default:
            if let url = URL(string: "\(Turn4.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image4 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[3])
                }
            } else {
                Quotes.append(TurnStrings[3])
            }
            self.Audio4 = EmptyAudio
//        downloadedFrom(link: "\(Turn4.turnURL).jpg", ImageNumber: "4")
        
        }
        
        switch Turn5.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn5.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio5 = data
                }
            }
           // downloadedFrom(link: "\(Turn5.turnURL).mp3", ImageNumber: "5")
            self.image5 = boomBox!
             Quotes.append("")
        case "gif":
            if let url = URL(string: "\(Turn5.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image5 = UIImage(data: data)!
                }
            }
            self.Audio5 = EmptyAudio
             Quotes.append("")
        default:
            if let url = URL(string: "\(Turn5.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image5 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[4])
                }
            } else {
                Quotes.append(TurnStrings[4])
            }
            self.Audio5 = EmptyAudio
            //downloadedFrom(link: "\(Turn5.turnURL).jpg", ImageNumber: "5")
            
        }
        
        switch Turn6.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn6.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio6 = data
                }
            }
             Quotes.append("")
          //  downloadedFrom(link: "\(Turn6.turnURL).mp3", ImageNumber: "6")
            self.image6 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn6.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image6 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            self.Audio6 = EmptyAudio
        default:
            //downloadedFrom(link: "\(Turn6.turnURL).jpg", ImageNumber: "6")
            if let url = URL(string: "\(Turn6.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image6 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[5])
                }
            } else {
                Quotes.append(TurnStrings[5])
            }
            self.Audio6 = EmptyAudio
        }
        
        switch Turn7.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn7.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio7 = data
                }
            }
             Quotes.append("")
           // downloadedFrom(link: "\(Turn7.turnURL).mp3", ImageNumber: "7")
            self.image7 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn7.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image7 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            self.Audio7 = EmptyAudio
        default:
            //downloadedFrom(link: "\(Turn7.turnURL).jpg", ImageNumber: "7")
            if let url = URL(string: "\(Turn7.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image7 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[6])
                }
            } else {
                Quotes.append(TurnStrings[6])
            }
            self.Audio7 = EmptyAudio
        }
        
        switch Turn8.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn8.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio8 = data
                }
            }
             Quotes.append("")
          //  downloadedFrom(link: "\(Turn8.turnURL).mp3", ImageNumber: "8")
            self.image8 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn8.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image8 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            self.Audio8 = EmptyAudio
        default:
           // downloadedFrom(link: "\(Turn8.turnURL).jpg", ImageNumber: "8")
            if let url = URL(string: "\(Turn8.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image8 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[7])
                }
            } else {
                Quotes.append(TurnStrings[7])
            }
            self.Audio8 = EmptyAudio
        }
        
        switch Turn9.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn9.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio9 = data
                }
            }
             Quotes.append("")
         //  downloadedFrom(link: "\(Turn9.turnURL).mp3", ImageNumber: "9")
           self.image9 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn9.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image9 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            self.Audio9 = EmptyAudio
        default:
            //downloadedFrom(link: "\(Turn9.turnURL).jpg", ImageNumber: "9")
            if let url = URL(string: "\(Turn9.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image9 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[8])
                }
            } else {
                Quotes.append(TurnStrings[8])
            }
            self.Audio9 = EmptyAudio
        }
        
        switch Turn10.mediaType {
        case "audio":
            if let url = URL(string: "\(Turn10.turnURL).mp3") {
                if let data = try? Data(contentsOf: url) {
                    self.Audio10 = data
                }
            }
             Quotes.append("")
         //  downloadedFrom(link: "\(Turn10.turnURL).mp3", ImageNumber: "10")
           self.image10 = boomBox!
        case "gif":
            if let url = URL(string: "\(Turn10.turnURL).gif") {
                if let data = try? Data(contentsOf: url) {
                    self.image10 = UIImage(data: data)!
                }
            }
             Quotes.append("")
            self.Audio10 = EmptyAudio
        default:
           //downloadedFrom(link: "\(Turn10.turnURL).jpg", ImageNumber: "10")
            if let url = URL(string: "\(Turn10.turnURL).jpg") {
                if let data = try? Data(contentsOf: url) {
                    self.image10 = UIImage(data: data)!
                    Quotes.append("")
                } else {
                    Quotes.append(TurnStrings[9])
                }
            } else {
                Quotes.append(TurnStrings[9])
            }
            self.Audio10 = EmptyAudio
        }
        
        print("Images count = \(images.count)")
        print("quotes count = \(Quotes.count)")
        print("quotes Array = \(Quotes)")
        
        DispatchQueue.main.async(execute: {
        self.createPhotoReel2()
        })
    }
    
    
    func GetCompleteGameData () {
        if Reachability.isConnectedToNetwork() {
            
           
            
            //    println("is connected")
            //    progressBarDisplayer("Getting Game Data", true)
            //images = ["",Turn2Image,"",Turn4Image,"",Turn6Image,"",Turn8Image,"",Turn10Image]
            
            
            //  self.TableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            let prefs:UserDefaults = UserDefaults.standard
            
            if GameID == "demo" {
                username = "demoName"
                userID = "demoID"
                
                
            } else {
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
                
            }
            // username = prefs.valueForKey("USERNAME") as! NSString as String
            //  userID = prefs.valueForKey("PLAYERID") as! NSString as String
           // let URLData = CompleteGameData(GameID, username: username)
            
            let URLData = GetGalleryGameData(self.GameID)
            //println(test)
           // var GameInfo = FilterGameDataGallery(URLData)
            
            let CompleteGameInfoArray = FilterGameDataGallery(URLData)
            //var gametype : CompleteGameDataNew
            
            /*
            if (self.resultSearchController.active && resultSearchController.searchBar.text != "") {
                gametype = FilteredGames[indexPath.row]
            } else {
                gametype = GameSearchArray[indexPath.row]
            }
            
            */
            
            var test = CompleteGameInfoArray
            DispatchQueue.main.async(execute: {
                
                
                
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer1, playerID: CompleteGameInfoArray.GamePlayer1ID, likes: CompleteGameInfoArray.like1, fails: CompleteGameInfoArray.fail1, turnURL: CompleteGameInfoArray.Turn1URLx, mediaType: CompleteGameInfoArray.media1, TurnNumber: "1"))
                
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer2, playerID: CompleteGameInfoArray.GamePlayer2ID, likes: CompleteGameInfoArray.like2, fails: CompleteGameInfoArray.fail2, turnURL: CompleteGameInfoArray.Turn2URLx, mediaType: CompleteGameInfoArray.media2, TurnNumber: "2"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer3, playerID: CompleteGameInfoArray.GamePlayer3ID, likes: CompleteGameInfoArray.like3, fails: CompleteGameInfoArray.fail3, turnURL: CompleteGameInfoArray.Turn3URLx, mediaType: CompleteGameInfoArray.media3, TurnNumber: "3"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer4, playerID: CompleteGameInfoArray.GamePlayer4ID, likes: CompleteGameInfoArray.like4, fails: CompleteGameInfoArray.fail4, turnURL: CompleteGameInfoArray.Turn4URLx, mediaType: CompleteGameInfoArray.media4, TurnNumber: "4"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer5, playerID: CompleteGameInfoArray.GamePlayer5ID, likes: CompleteGameInfoArray.like5, fails: CompleteGameInfoArray.fail5, turnURL: CompleteGameInfoArray.Turn5URLx, mediaType: CompleteGameInfoArray.media5, TurnNumber: "5"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer6, playerID: CompleteGameInfoArray.GamePlayer6ID, likes: CompleteGameInfoArray.like6, fails: CompleteGameInfoArray.fail6, turnURL: CompleteGameInfoArray.Turn6URLx, mediaType: CompleteGameInfoArray.media6, TurnNumber: "6"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer7, playerID: CompleteGameInfoArray.GamePlayer7ID, likes: CompleteGameInfoArray.like7, fails: CompleteGameInfoArray.fail7, turnURL: CompleteGameInfoArray.Turn7URLx, mediaType: CompleteGameInfoArray.media7, TurnNumber: "7"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer8, playerID: CompleteGameInfoArray.GamePlayer8ID, likes: CompleteGameInfoArray.like8, fails: CompleteGameInfoArray.fail8, turnURL: CompleteGameInfoArray.Turn8URLx, mediaType: CompleteGameInfoArray.media8, TurnNumber: "8"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer9, playerID: CompleteGameInfoArray.GamePlayer1ID, likes: CompleteGameInfoArray.like9, fails: CompleteGameInfoArray.fail9, turnURL: CompleteGameInfoArray.Turn9URLx, mediaType: CompleteGameInfoArray.media9, TurnNumber: "9"))
                
                self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer10, playerID: CompleteGameInfoArray.GamePlayer1ID, likes: CompleteGameInfoArray.like10, fails: CompleteGameInfoArray.fail10, turnURL: CompleteGameInfoArray.Turn10URLx, mediaType: CompleteGameInfoArray.media10, TurnNumber: "10"))
                /*
                print("photos \(self.Photos.count)")
                print("Photo IDs \(self.PhotoID)")
                print("num fails \(self.NumFails)")
                print("audio String array \(self.AudioStringArray)")
                print("show audio array \(self.HideAudioArray)")
                print("Audio Clips Data \(self.AudioClips.count)")
                print("Audio Clips = \(self.AudioClips)")
                */
                DispatchQueue.main.async(execute: {
                    print("Turn Data = \(self.ThisGameTurnInfoArray)")
                self.collectionView?.reloadData()
                print("done animating")
                self.actInd.stopAnimating()
                
                })
                
            })
            
          //  self.ThisGameTurnInfoArray.append(ThisGameTurnInfoArray
            
        
        }
            
        else
            
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Network Error"
            alertView.message = "Please Confirm your network settings"
            alertView.delegate = self
            
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
    }
    
    
    func FilterGameDataGallery(_ urlData: Data) -> CompleteGameDataNew {
        
        
        TurnStrings.removeAll()
        users.removeAll()
        var CompleteGameInfoTemp = [CompleteGameDataNew]()
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        //  print("Json valueJSON: \(json)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                let gname = result["GameName"].stringValue
                
                GameNameInfo = gname as NSString
                
                let gameID = result["id"].stringValue
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
                
                let turn1x = result["Turn1"].stringValue
                
                let turn2x = result["Turn2"].stringValue
                
                let turn3x = result["Turn3"].stringValue
                let turn4x = result["Turn4"].stringValue
                let turn5x = result["Turn5"].stringValue
                
                let turn6x = result["Turn6"].stringValue
                
                let turn7x = result["Turn7"].stringValue
                
                let turn8x = result["Turn8"].stringValue
                let turn9x = result["Turn9"].stringValue
                let turn10x = result["Turn10"].stringValue
                
                users.append(player1 as NSString)
                users.append(player2 as NSString)
                users.append(player3 as NSString)
                users.append(player4 as NSString)
                users.append(player5 as NSString)
                users.append(player6 as NSString)
                users.append(player7 as NSString)
                users.append(player8 as NSString)
                users.append(player9 as NSString)
                users.append(player10 as NSString)
                
                
                let Turn1x64NSData = Data(base64Encoded: turn1x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn1 = NSString(data: Turn1x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn2x64NSData = Data(base64Encoded: turn2x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn2 = NSString(data: Turn2x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn3x64NSData = Data(base64Encoded: turn3x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn3 = NSString(data: Turn3x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn4x64NSData = Data(base64Encoded: turn4x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn4 = NSString(data: Turn4x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn5x64NSData = Data(base64Encoded: turn5x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn5 = NSString(data: Turn5x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                
                
                
                let Turn6x64NSData = Data(base64Encoded: turn6x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn6 = NSString(data: Turn6x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn7x64NSData = Data(base64Encoded: turn7x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn7 = NSString(data: Turn7x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn8x64NSData = Data(base64Encoded: turn8x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn8 = NSString(data: Turn8x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn9x64NSData = Data(base64Encoded: turn9x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn9 = NSString(data: Turn9x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                let Turn10x64NSData = Data(base64Encoded: turn10x as String, options: NSData.Base64DecodingOptions(rawValue: 0))
                let turn10 = NSString(data: Turn10x64NSData!, encoding: String.Encoding.utf8.rawValue)!
                
                TurnStrings.append(turn1)
                TurnStrings.append(turn2)
                TurnStrings.append(turn3)
                TurnStrings.append(turn4)
                TurnStrings.append(turn5)
                TurnStrings.append(turn6)
                TurnStrings.append(turn7)
                TurnStrings.append(turn8)
                TurnStrings.append(turn9)
                TurnStrings.append(turn10)
                
                
                let gamestyle = result["gamestyle"].stringValue
                
                TheGameStyle = gamestyle
                
                
                let like1 = result["Like1"].stringValue
                let like1new = Int(like1)
                let like2 = result["Like2"].stringValue
                let like2new = Int(like2)
                let like3 = result["Like3"].stringValue
                let like3new = Int(like3)
                let like4 = result["Like4"].stringValue
                let like4new = Int(like4)
                let like5 = result["Like5"].stringValue
                let like5new = Int(like5)
                let like6 = result["Like6"].stringValue
                let like6new = Int(like6)
                let like7 = result["Like7"].stringValue
                let like7new = Int(like7)
                let like8 = result["Like8"].stringValue
                let like8new = Int(like8)
                let like9 = result["Like9"].stringValue
                let like9new = Int(like9)
                let like10 = result["Like10"].stringValue
                let like10new = Int(like10)
                let likegame = result["LikeGame"].stringValue
                let likegamenew = Int(likegame)
                
                self.totallikes = likegamenew!
               
                
                self.totlalikesLBL.text = likegamenew?.description
                
                
                let media1 = result["mediatype1"].stringValue
                
                let media2 = result["mediatype2"].stringValue
                
                let media3 = result["mediatype3"].stringValue
                let media4 = result["mediatype4"].stringValue
                let media5 = result["mediatype5"].stringValue
                
                let media6 = result["mediatype6"].stringValue
                
                let media7 = result["mediatype7"].stringValue
                
                let media8 = result["mediatype8"].stringValue
                let media9 = result["mediatype9"].stringValue
                let media10 = result["mediatype10"].stringValue
                
                
                let numfailsTemp1 = result["Fail1"].stringValue
                let numfailsTemp2 = result["Fail2"].stringValue
                let numfailsTemp3 = result["Fail3"].stringValue
                let numfailsTemp4 = result["Fail4"].stringValue
                let numfailsTemp5 = result["Fail5"].stringValue
                
                let numfailsTemp6 = result["Fail6"].stringValue
                let numfailsTemp7 = result["Fail7"].stringValue
                let numfailsTemp8 = result["Fail8"].stringValue
                let numfailsTemp9 = result["Fail9"].stringValue
                let numfailsTemp10 = result["Fail10"].stringValue
                let numfailsTemp11 = result["FailGame"].stringValue
                
                let LikeBool1temp = result["LikePush1"].stringValue
                var LikeBool1 = Bool()
                if LikeBool1temp == "0" {
                    LikeBool1 = false
                } else { LikeBool1 = true }
                
                let LikeBool2temp = result["LikePush2"].stringValue
                var LikeBool2 = Bool()
                if LikeBool2temp == "0" {
                    LikeBool2 = false
                } else { LikeBool2 = true }
                
                let LikeBool3temp = result["LikePush3"].stringValue
                var LikeBool3 = Bool()
                if LikeBool3temp == "0" {
                    LikeBool3 = false
                } else { LikeBool3 = true }
                
                let LikeBool4temp = result["LikePush4"].stringValue
                var LikeBool4 = Bool()
                if LikeBool4temp == "0" {
                    LikeBool4 = false
                } else { LikeBool4 = true }
                
                let LikeBool5temp = result["LikePush5"].stringValue
                var LikeBool5 = Bool()
                if LikeBool5temp == "0" {
                    LikeBool5 = false
                } else { LikeBool5 = true }
                
                let LikeBool6temp = result["LikePush6"].stringValue
                var LikeBool6 = Bool()
                if LikeBool6temp == "0" {
                    LikeBool6 = false
                } else { LikeBool6 = true }
                
                let LikeBool7temp = result["LikePush7"].stringValue
                var LikeBool7 = Bool()
                if LikeBool7temp == "0" {
                    LikeBool7 = false
                } else { LikeBool7 = true }
                
                let LikeBool8temp = result["LikePush8"].stringValue
                var LikeBool8 = Bool()
                if LikeBool8temp == "0" {
                    LikeBool8 = false
                } else { LikeBool8 = true }
                
                let LikeBool9temp = result["LikePush9"].stringValue
                var LikeBool9 = Bool()
                if LikeBool9temp == "0" {
                    LikeBool9 = false
                } else { LikeBool9 = true }
                
                let LikeBool10temp = result["LikePush10"].stringValue
                var LikeBool10 = Bool()
                if LikeBool10temp == "0" {
                    LikeBool10 = false
                } else { LikeBool10 = true }
                
                let LikeBool11temp = result["LikePushGame"].stringValue
                var LikeBoolGame = Bool()
                if LikeBool11temp == "0" {
                    LikeBoolGame = false
                } else { LikeBoolGame = true }
                
                
                let numfails1 = Int(numfailsTemp1)
                let numfails2 = Int(numfailsTemp2)
                let numfails3 = Int(numfailsTemp3)
                let numfails4 = Int(numfailsTemp4)
                let numfails5 = Int(numfailsTemp5)
                let numfails6 = Int(numfailsTemp6)
                let numfails7 = Int(numfailsTemp7)
                let numfails8 = Int(numfailsTemp8)
                let numfails9 = Int(numfailsTemp9)
                let numfails10 = Int(numfailsTemp10)
                let numfails11 = Int(numfailsTemp11)
                
                let totalFails =
                    //(numfails1 + numfails2 + numfails3 + numfails4 + numfails5 + numfails6 + numfails7 + numfails8 + numfails9 + numfails10)
                
                self.totlafailsLBL.text = numfails11!.description
                self.totalfails = numfails11!
                self.numCommentsLBL.text = ""
                
                let useimageURL1temp = result["useimageURL1"].stringValue
                let useimageURL2temp = result["useimageURL2"].stringValue
                let useimageURL3temp = result["useimageURL3"].stringValue
                let useimageURL4temp = result["useimageURL4"].stringValue
                let useimageURL5temp = result["useimageURL5"].stringValue
                let useimageURL6temp = result["useimageURL6"].stringValue
                let useimageURL7temp = result["useimageURL7"].stringValue
                let useimageURL8temp = result["useimageURL8"].stringValue
                let useimageURL9temp = result["useimageURL9"].stringValue
                let useimageURL10temp = result["useimageURL10"].stringValue
                
               
                
                let imageURL1temp = result["imageURL1"].stringValue
                let imageURL2temp = result["imageURL2"].stringValue
                let imageURL3temp = result["imageURL3"].stringValue
                let imageURL4temp = result["imageURL4"].stringValue
                let imageURL5temp = result["imageURL5"].stringValue
                let imageURL6temp = result["imageURL6"].stringValue
                let imageURL7temp = result["imageURL7"].stringValue
                let imageURL8temp = result["imageURL8"].stringValue
                let imageURL9temp = result["imageURL9"].stringValue
                let imageURL10temp = result["imageURL10"].stringValue
                
                
                
                
                CompleteGameInfoTemp.append(CompleteGameDataNew(GameName: gname, GameID: gameID, GamePlayer1: player1, GamePlayer2: player2, GamePlayer3: player3, GamePlayer4: player4, GamePlayer5: player5, GamePlayer6: player6, GamePlayer7: player7, GamePlayer8: player8, GamePlayer9: player9, GamePlayer10: player10, GameTimeLimit: "", GameGameStyle: gamestyle, GameGameVisible: "", GameTotalLikes: "", GameCommentInfo: "", GameGameLikeArray: "", GameGameFailArray: "", GamePlayer1ID: player1ID, GamePlayer2ID: player2ID, GamePlayer3ID: player3ID, GamePlayer4ID: player4ID, GamePlayer5ID: player5ID, GamePlayer6ID: player6ID, GamePlayer7ID: player7ID, GamePlayer8ID: player8ID, GamePlayer9ID: player9ID, GamePlayer10ID: player10ID, GameContent: "", GameSearchString: "", GameSetting: "", Turn1URLx: imageURL1temp, Turn2URLx: imageURL2temp, Turn3URLx: imageURL3temp, Turn4URLx: imageURL4temp, Turn5URLx: imageURL5temp, Turn6URLx: imageURL6temp, Turn7URLx: imageURL7temp, Turn8URLx: imageURL8temp, Turn9URLx: imageURL9temp, Turn10URLx: imageURL10temp, like1: like1, like2: like2, like3: like3, like4: like4, like5: like5, like6: like6, like7: like7, like8: like8, like9: like9, like10: like10, fail1: numfailsTemp1, fail2: numfailsTemp2, fail3: numfailsTemp3, fail4: numfailsTemp4, fail5: numfailsTemp5, fail6: numfailsTemp6, fail7: numfailsTemp7, fail8: numfailsTemp8, fail9: numfailsTemp9, fail10: numfailsTemp10, media1: media1, media2: media2, media3: media3, media4: media4, media5: media5, media6: media6, media7: media7, media8: media8, media9: media9, media10: media10))
                
            }
            
        }
        
        return CompleteGameInfoTemp[0]
//        return Game_Data_Array
        
    }
    
   

//}
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        super.viewDidLoad()
        print("popover dismissed")
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func ViewFail(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Fail") as! FailViewController
        
        savingsInformationViewController.faildelegate = self
        
        /*
        savingsInformationViewController.gameid = self.GAME_ID
        //   savingsInformationViewController.turnnumber = self.theTurnNumber
        
        savingsInformationViewController.replyuser  = self.theUser
        
        savingsInformationViewController.turnnumber  = self.theTurn
        
        */
        
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
    
    
    @IBAction func ViewSocial(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "SocialMedia") as! SocialViewController
        
        savingsInformationViewController.socialdelegate = self
        //  savingsInformationViewController,
        
        //   .view.background = UIColor.clearColor()
        
        /*
        savingsInformationViewController.TheImage = self.theimage
        savingsInformationViewController.TheQuote = self.thequote
        savingsInformationViewController.theMediaType = self.theMediaType
        
        savingsInformationViewController.PreviousMediaType = self.PreviousMediaType
        savingsInformationViewController.gamestyle = self.GameStyleInfo
        savingsInformationViewController.theTurnNumber = self.theTurnNumber
        savingsInformationViewController.hideBorder = self.hideBorder
        savingsInformationViewController.PreviousImage = self.PreviousImage
        savingsInformationViewController.PreviousQuote = self.PreviousQuote
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player2 = self.Player2Info
        savingsInformationViewController.player3 = self.Player3Info
        savingsInformationViewController.player4 = self.Player4Info
        savingsInformationViewController.player5 = self.Player5Info
        savingsInformationViewController.player6 = self.Player6Info
        savingsInformationViewController.player7 = self.Player7Info
        savingsInformationViewController.player8 = self.Player8Info
        savingsInformationViewController.player9 = self.Player9Info
        savingsInformationViewController.player10 = self.Player10Info
        savingsInformationViewController.FullGameImage = self.FullGameImage
        
        */
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            popoverController2.sourceView = sender as! UIView
            // popoverController2.vi
            //  popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = CGRect(x: middleX,y: 150,width: 0,height: 0)
                
                //sender.bounds
            //CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .down
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func ViewLikes(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Like") as! LikesViewController
        
        
        savingsInformationViewController.likedelegate = self
        /*

        savingsInformationViewController.gameid = self.GAME_ID
        //  savingsInformationViewController.turnnumber = self.theTurnNumber
        
        savingsInformationViewController.replyuser  = self.theUser
        
        savingsInformationViewController.turnnumber  = self.theTurn
        
        */
        
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
    
    func NewLikeClickedLogin(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    
    func NewFailClickedLogin(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    
    func NewLikeClicked(_ sender: UIButton!) {
        
        
        let ISLOGGEDINTWO = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        if ISLOGGEDINTWO {
            
        
        print("New Liked Clicked")
        
        let RowSelected = sender.tag
        let MyTurnData = ThisGameTurnInfoArray[RowSelected]
        replyUser = MyTurnData.playerName as NSString
        replyUserID = MyTurnData.playerID as NSString
        
        
        if username == replyUser {

            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Hey that's yours..", subTitle: "You can't 'Like' you own turn.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            AddLikeBTN()
        }
    } else  {
    
    self.performSegue(withIdentifier: "login", sender: self)
    
    }
    
    }
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Done", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            self.dismiss(animated: true, completion:nil)
        case MessageComposeResult.failed.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue:
            self.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
        
    }
    
    
     func ShareImageClicked(_ sender: UIButton!) {
        
        let RowSelected = sender.tag
        var LastRow = Int()
        if RowSelected == 0 {
           LastRow = RowSelected
        } else {
            LastRow = RowSelected - 1
        }
        
        let MyTurnData = ThisGameTurnInfoArray[RowSelected]
        
        let LastTurnData = ThisGameTurnInfoArray[LastRow]
        replyUser = MyTurnData.playerName as NSString
        replyUserID = MyTurnData.playerID as NSString
        TurnNumber = MyTurnData.TurnNumber as NSString
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "SocialMedia") as! SocialViewController
        
        savingsInformationViewController.socialdelegate = self
        
        
        //  savingsInformationViewController,
        
        //   .view.background = UIColor.clearColor()
        
        switch RowSelected {
            
        case 0:
            savingsInformationViewController.TheImage = self.image1
            savingsInformationViewController.TheQuote = self.TurnStrings[0]
            savingsInformationViewController.PreviousImage = self.image1
            savingsInformationViewController.PreviousQuote = self.TurnStrings[0]
            savingsInformationViewController.hideBorder = true
            savingsInformationViewController.theTurnNumber = "Turn1"
            
        case 1:
            savingsInformationViewController.TheImage = self.image2
            savingsInformationViewController.TheQuote = self.TurnStrings[1]
            savingsInformationViewController.PreviousImage = self.image1
            savingsInformationViewController.PreviousQuote = self.TurnStrings[0]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn2"
        case 2:
            savingsInformationViewController.TheImage = self.image3
            savingsInformationViewController.TheQuote = self.TurnStrings[2]
            savingsInformationViewController.PreviousImage = self.image2
            savingsInformationViewController.PreviousQuote = self.TurnStrings[1]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn3"
        case 3:
            savingsInformationViewController.TheImage = self.image4
            savingsInformationViewController.TheQuote = self.TurnStrings[3]
            savingsInformationViewController.PreviousImage = self.image3
            savingsInformationViewController.PreviousQuote = self.TurnStrings[2]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn4"
        case 4:
            savingsInformationViewController.TheImage = self.image5
            savingsInformationViewController.TheQuote = self.TurnStrings[4]
            savingsInformationViewController.PreviousImage = self.image4
            savingsInformationViewController.PreviousQuote = self.TurnStrings[3]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn5"
        case 5:
            savingsInformationViewController.TheImage = self.image6
            savingsInformationViewController.TheQuote = self.TurnStrings[5]
            savingsInformationViewController.PreviousImage = self.image5
            savingsInformationViewController.PreviousQuote = self.TurnStrings[4]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn6"
        case 6:
            savingsInformationViewController.TheImage = self.image7
            savingsInformationViewController.TheQuote = self.TurnStrings[6]
            savingsInformationViewController.PreviousImage = self.image6
            savingsInformationViewController.PreviousQuote = self.TurnStrings[5]
            savingsInformationViewController.theTurnNumber = "Turn7"
        case 7:
            savingsInformationViewController.TheImage = self.image8
            savingsInformationViewController.TheQuote = self.TurnStrings[7]
            savingsInformationViewController.PreviousImage = self.image7
            savingsInformationViewController.PreviousQuote = self.TurnStrings[6]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn8"
        case 8:
            savingsInformationViewController.TheImage = self.image9
            savingsInformationViewController.TheQuote = self.TurnStrings[8]
            savingsInformationViewController.PreviousImage = self.image8
            savingsInformationViewController.PreviousQuote = self.TurnStrings[7]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn9"
        case 9:
            savingsInformationViewController.TheImage = self.image10
            savingsInformationViewController.TheQuote = self.TurnStrings[9]
            savingsInformationViewController.PreviousImage = self.image9
            savingsInformationViewController.PreviousQuote = self.TurnStrings[8]
            savingsInformationViewController.hideBorder = false
            savingsInformationViewController.theTurnNumber = "Turn10"
        default:
            break
        }
        
        
        savingsInformationViewController.gamestyle = self.TheGameStyle as NSString
        savingsInformationViewController.theMediaType = MyTurnData.mediaType as NSString
        savingsInformationViewController.PreviousMediaType = LastTurnData.mediaType as NSString
       // savingsInformationViewController.theTurnNumber = self.TurnNumber
        savingsInformationViewController.FullGameImage = self.FullGameImage
        
        savingsInformationViewController.player1 = users[0]
        savingsInformationViewController.player2 = users[1]
        savingsInformationViewController.player3 = users[2]
        savingsInformationViewController.player4 = users[3]
        savingsInformationViewController.player5 = users[4]
        savingsInformationViewController.player6 = users[5]
        savingsInformationViewController.player7 = users[6]
        savingsInformationViewController.player8 = users[7]
        savingsInformationViewController.player9 = users[8]
        savingsInformationViewController.player10 = users[9]
        
        /*
        savingsInformationViewController.TheImage = self.theimage
        savingsInformationViewController.TheQuote = self.thequote
        savingsInformationViewController.theMediaType = self.theMediaType
        
        savingsInformationViewController.PreviousMediaType = self.PreviousMediaType
        savingsInformationViewController.gamestyle = self.GameStyleInfo
        savingsInformationViewController.theTurnNumber = self.theTurnNumber
        savingsInformationViewController.hideBorder = self.hideBorder
        savingsInformationViewController.PreviousImage = self.PreviousImage
        savingsInformationViewController.PreviousQuote = self.PreviousQuote
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player2 = self.Player2Info
        savingsInformationViewController.player3 = self.Player3Info
        savingsInformationViewController.player4 = self.Player4Info
        savingsInformationViewController.player5 = self.Player5Info
        savingsInformationViewController.player6 = self.Player6Info
        savingsInformationViewController.player7 = self.Player7Info
        savingsInformationViewController.player8 = self.Player8Info
        savingsInformationViewController.player9 = self.Player9Info
        savingsInformationViewController.player10 = self.Player10Info
        savingsInformationViewController.FullGameImage = self.FullGameImage
        
        */
        
        savingsInformationViewController.modalPresentationStyle = .popover
        
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            //popoverController2.sourceView = sender as! UIView
            // popoverController2.vi
              popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            
            //popoverController2.sourceRect = sender.bounds
           // popoverController2.sourceRect = CGRectMake(middleX,150,0,0)
            
            popoverController2.sourceRect = CGRect(x: middleX,y: 350,width: 200,height: 300)
            
            //CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .down
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        
        present(savingsInformationViewController, animated: true, completion: nil)
        


    }
    
     func ViewCommentsClicked(_ sender: UIButton!) {
        let RowSelected = sender.tag
        let MyTurnData = ThisGameTurnInfoArray[RowSelected]
        replyUser = MyTurnData.playerName as NSString
        replyUserID = MyTurnData.playerID as NSString
        TurnNumber = MyTurnData.TurnNumber as NSString
        self.performSegue(withIdentifier: "ShowComments", sender: self)
    }
    
    func NewFailClicked(_ sender: UIButton!) {
        print("New Fail Clicked")
        
        
        let ISLOGGEDINTWO = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        
        if ISLOGGEDINTWO {
            
        let RowSelected = sender.tag
        let MyTurnData = ThisGameTurnInfoArray[RowSelected]
        replyUser = MyTurnData.playerName as NSString
        replyUserID = MyTurnData.playerID as NSString
        TurnNumber = MyTurnData.TurnNumber as NSString
        
        var CurrentFails = Int(MyTurnData.fails)
        
        var CurrentLikes = Int(MyTurnData.likes)
        
        if username == replyUser {
            
             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh..that's yours", subTitle: "You're trying to 'Fail' your own turn...nope.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            AddFailBTN()
        }
        
    } else  {
    
    self.performSegue(withIdentifier: "login", sender: self)
    
    }
    
    }

    
    
    func AddFailBTN() {
        
        totalfails = totalfails + 1
        //totlalfailLBL.text = totalfails.description
        totlafailsLBL.text = totalfails.description

            //  if !MuteAudio {
            FailPlayer?.play()
            //   }
            if !FailTurn {
                FailTurn = true
                /*
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.NewFailBTN.alpha = 0.0
                    }, completion: {
                        (finished: Bool) -> Void in
                        //  })
                        self.NewFailBTN.imageView?.image = UIImage(named: "FailIconWhiteRed.png")
                        
                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            self.NewFailBTN.alpha = 1.0
                            }, completion: nil)
                })
                */
                
                SaveLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "fail", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaTypeTemp)" as NSString)
                
                /*
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
                
                */
                //  DoUploadImage = true
                
                
                //   if DoUploadImage {
                
                //UPLOADS CURRENT IMAGE
                // var TempImageCurrent = CreateTempImage(QuoteText)
                print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
              //  print("The Media type, before image upload is = \(MediaTypeTemp)")
             //   print("The Media type2, before image upload is = \(MediaTypeTemp2)")
                //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                //   UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                
                
                /*
                if MediaTypeTemp == "image" {
                    
                    let TempImageCurrent = CreateTempImage(QuoteTextPrevious as String)
                    
                    UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        if self.MediaTypePrevious == "audio" {
                            UploadGameFileNSData(self.AudioClipPrevious, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "audio")
                        } else {
                            
                            
                            UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "image")
                            
                        }
                    })
                    
                    
                }
                
                if MediaTypeTemp == "quote" {
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        if self.MediaTypePrevious == "audio" {
                            dispatch_async(dispatch_get_main_queue(),{
                                UploadGameFileNSData(self.Audio_Data, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "audio")
                            })
                            
                        } else {
                            
                            
                            let TempImageQuoteCurrent = self.CreateTempImage(self.QuoteText)
                            //print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
                            
                            //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                            dispatch_async(dispatch_get_main_queue(),{
                                UploadGameFile(TempImageQuoteCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                            })
                        }
                        
                    })
                }
                
                
                */
                
                
                
              //  NSNotificationCenter.defaultCenter().postNotificationName("AddFailGallery", object: nil, userInfo: ["fails":"1","index":"\(pageIndex)"])
                
                
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
                            
                        })
                        
                        theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Pixie Points!", subTitle: "You earn Points to level up your Pixie by Failing Turns.  You just earned one!", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
                        
                        
                        
                    })
                  
                    
                })
                
                
                
                
            } else {
                FailTurn = false
                
                /*
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.NewFailBTN.alpha = 0.0
                    }, completion: {
                        (finished: Bool) -> Void in
                        //  })
                        self.NewFailBTN.imageView?.image = UIImage(named: "FailIconGrayBlur.png")
                        
                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            self.NewFailBTN.alpha = 1.0
                            }, completion: nil)
                })
                */
                //DeleteLikeFailData(FailID)
                //DeleteLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.titleText)
            }
            
      //  }
    }
    
   func AddLikeBTN() {
    
    
    totallikes = totallikes + 1
    totlalikesLBL.text = totallikes.description
    
            
            //     if !MuteAudio {
            LikePlayer?.play()
            //     }
            if !LikedTurn {
                LikedTurn = true
                /*
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.NewLikeBTN.alpha = 0.0
                    }, completion: {
                        (finished: Bool) -> Void in
                        //  })
                        self.NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayGreen.png")
                        
                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            self.NewLikeBTN.alpha = 1.0
                            }, completion: nil)
                })
                */
                
                SaveLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaTypeTemp)" as NSString)
                
                
                /*
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
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        if self.MediaTypePrevious == "audio" {
                            UploadGameFileNSData(self.AudioClipPrevious, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "audio")
                        } else {
                            
                            
                            UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumberPrevious)", Type: "image")
                            
                        }
                    })
                    
                }
                
                if MediaTypeTemp == "quote" {
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        if self.MediaTypePrevious == "audio" {
                            
                            if self.AudioClipPrevious != "" {
                                
                                dispatch_async(dispatch_get_main_queue(),{
                                    UploadGameFileNSData(self.Audio_Data, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "audio")
                                })
                            }
                            
                        } else {
                            
                            
                            let TempImageQuoteCurrent = self.CreateTempImage(self.QuoteText)
                            //print("SHOULD UPLOAD IMAGE NOW as UIIMAGE")
                            
                            //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                            dispatch_async(dispatch_get_main_queue(),{
                                UploadGameFile(TempImageQuoteCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)", Type: "image")
                            })
                        }
                    })
                }
                */
                
                
            //    NSNotificationCenter.defaultCenter().postNotificationName("AddLikeGallery", object: nil, userInfo: ["likes":"1","index":"\(pageIndex)"])
                
                
                
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
                
                /*
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.NewLikeBTN.alpha = 0.0
                    }, completion: {
                        (finished: Bool) -> Void in
                        //  })
                        self.NewLikeBTN.imageView?.image = UIImage(named: "LikeIconGrayBlur.png")
                        
                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            self.NewLikeBTN.alpha = 1.0
                            }, completion: nil)
                })
                
                */
                //DeleteLikeFailData(LikeID)
                //DeleteLikeFailData(self.GameID, username: self.username, turn: self.TurnNumber, type: "like", replyuser: self.titleText)
            }
            
     //   }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ThisGameTurnInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        //cell.Turn1ImageBack.hidden = true
       // cell.Turn1Image?.hidden = true
        cell.Turn1Image?.contentMode = UIViewContentMode.scaleAspectFit
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        cell.LikeButton?.isEnabled = true
        cell.FailButton?.isEnabled = true
        let DeviceW = self.view.frame.width
        let middleScreenX = DeviceW / 2
        let Turn1ImageWidth = middleScreenX + (middleScreenX / 2)
        cell.Turn1ImageW?.constant = Turn1ImageWidth
        cell.panelW?.constant = (middleScreenX / 2)
        cell.cellViewBG?.layer.cornerRadius = 2
        cell.cellViewBG?.layer.borderWidth = 1
        cell.cellViewBG?.layer.borderColor = UIColor.lightGray.cgColor
        cell.cellViewBG?.layer.masksToBounds = true
        cell.cellViewBG?.clipsToBounds = true
        print("Panel W = \((middleScreenX / 2))")
        //var gametype = ThisGameTurnInfoArray[indexPath.row]
        
        // gametype = ThisGameTurnInfoArray[indexPath.row]
        
        //  let MyTurnData = ThisGameTurnInfo[indexPath.row]
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.numberIMG?.image = UIImage(named: "num1.png")
        case 1:
            cell.numberIMG?.image = UIImage(named: "num2.png")
        case 2:
            cell.numberIMG?.image = UIImage(named: "num3.png")
        case 3:
            cell.numberIMG?.image = UIImage(named: "num4.png")
        case 4:
            cell.numberIMG?.image = UIImage(named: "num5.png")
        case 5:
            cell.numberIMG?.image = UIImage(named: "num6.png")
        case 6:
            cell.numberIMG?.image = UIImage(named: "num7.png")
        case 7:
            cell.numberIMG?.image = UIImage(named: "num8.png")
        case 8:
            cell.numberIMG?.image = UIImage(named: "num9.png")
        case 9:
            cell.numberIMG?.image = UIImage(named: "num10.png")
        default:
            break
        }
        
        let MyTurnData = ThisGameTurnInfoArray[(indexPath as NSIndexPath).row]
        // let MyTurnData = ThisGameTurnInfo[indexPath]
        
        cell.Turn1Image?.layer.cornerRadius = 5
        cell.Turn1Image?.layer.masksToBounds = true
        cell.Turn1Image?.layer.borderWidth = 1
        cell.Turn1Image?.layer.borderColor = UIColor.white.cgColor
        //UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0).CGColor
        cell.playBTN?.addTarget(self, action: #selector(GalleryItemViewController.PlayAudioClicked(_:)), for: .touchUpInside)
        cell.playBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.ShareButton?.addTarget(self, action: #selector(GalleryItemViewController.ShareImageClicked(_:)), for: .touchUpInside)
        cell.ShareButton?.tag = (indexPath as NSIndexPath).row
        cell.FailButton?.addTarget(self, action: #selector(GalleryItemViewController.NewFailClicked(_:)), for: .touchUpInside)
        cell.FailButton?.tag = (indexPath as NSIndexPath).row
        cell.LikeButton?.addTarget(self, action: #selector(GalleryItemViewController.NewLikeClicked(_:)), for: .touchUpInside)
        cell.LikeButton?.tag = (indexPath as NSIndexPath).row
        cell.commentsBTN?.addTarget(self, action: #selector(GalleryItemViewController.ViewCommentsClicked(_:)), for: .touchUpInside)
        cell.commentsBTN?.tag = (indexPath as NSIndexPath).row
        
       // let ISLOGGEDINTWO = NSUserDefaults.standardUserDefaults().boolForKey("ISLOGGEDIN")
        
      //  print("Is logged in two = \(ISLOGGEDINTWO)")
        
        //if ISLOGGEDINTWO {
            
        
           // cell.LikeButton.hidden = false
            //cell.FailButton.hidden = false
            
            cell.FailButton?.addTarget(self, action: #selector(GalleryItemViewController.NewFailClicked(_:)), for: .touchUpInside)
            cell.FailButton?.tag = (indexPath as NSIndexPath).row
            cell.LikeButton?.addTarget(self, action: #selector(GalleryItemViewController.NewLikeClicked(_:)), for: .touchUpInside)
            cell.LikeButton?.tag = (indexPath as NSIndexPath).row

            
            /*
            
        } else {
           // cell.LikeButton.hidden = true
           // cell.FailButton.hidden = true
            
            cell.FailButton?.addTarget(self, action: "NewFailClickedLogin:", forControlEvents: .TouchUpInside)
            cell.FailButton?.tag = indexPath.row
            cell.LikeButton?.addTarget(self, action: "NewLikeClickedLogin:", forControlEvents: .TouchUpInside)
            cell.LikeButton?.tag = indexPath.row

        }
        
        */
        
        cell.playBTN?.isHidden = false
        if MyTurnData.fails == "1" {
            cell.failLBL?.text = "\(MyTurnData.fails) fail"
        } else {
          cell.failLBL?.text = "\(MyTurnData.fails) fails"
            
        }
        
        if MyTurnData.likes == "1" {
        cell.heartLBL?.text = "\(MyTurnData.likes) like"
            
        } else {
            cell.heartLBL?.text = "\(MyTurnData.likes) likes"
        }
        
        /*
        cell.meBTN?.hidden = true
        cell.friendsBTN?.hidden = true
        cell.publicBTN?.hidden = true
        cell.bestfriendsBTN?.hidden = true
        */
        // cell.myLabel.text = self.items[indexPath.item]
        
        var mediaSuf = NSString()
        print("cell media type = \(MyTurnData.mediaType)")
        switch MyTurnData.mediaType {
        case "quote":
            mediaSuf = ".jpg"
        case "image":
            mediaSuf = ".jpg"
        case "gif":
            mediaSuf = ".gif"
        case "audio":
            mediaSuf = ".mp3"
            
            
        default:
            break
            
            
        }
        
        print("Cell URL index \((indexPath as NSIndexPath).row) = \(MyTurnData.turnURL)\(mediaSuf)")
        
        if MyTurnData.mediaType == "audio" {
            
            cell.Turn1Image?.image = boomBox
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            //  cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = false
            
            
        } else {
            
            
            // if MyTurnData.mediatype == "image" {
            
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            
            if !self.fileExists(URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")) {
                print("file DOES NOT exists - \(MyTurnData.turnURL)\(mediaSuf)")
                cell.Turn1Image?.image = UIImage(named: "noImage.png")
                
            } else {
            
            
                
                if MyTurnData.mediaType == "gif" {
                    let request: URLRequest = URLRequest(url: URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")!)
                    let mainQueue = OperationQueue.main
                    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                        if error == nil {
                            // Convert the downloaded data in to a UIImage object
                            let image = UIImage(data: data!)
                            // Store the image in to our cache
                            //  self.imageCache[urlString] = image
                            // Update the cell
                            
                            if !self.fileExists(URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")) {
                                print("file DOES NOT exists - \(MyTurnData.turnURL)\(mediaSuf)")
                                cell.Turn1Image?.image = UIImage(named: "noImage.png")
                                
                            } else {
                                print("file exists - \(MyTurnData.turnURL)\(mediaSuf)")
                                DispatchQueue.main.async(execute: {
                                    if let cellToUpdate = self.TableView.cellForRow(at: indexPath) {
                                        
                                        // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                                        
                                        if MyTurnData.mediaType == "gif" {
                                            cell.Turn1Image?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                                        } else {
                                            
                                            cell.Turn1Image?.image = image
                                            cell.Turn1Image?.contentMode = UIViewContentMode.scaleAspectFit
                                        }
                                        //let GIFData = NSData
                                        
                                        // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                                        //cellToUpdate.TurnImage?.image = image
                                    }
                                })
                                // }
                            }
                            
                        }
                        else {
                            //cell.TurnImage?.image = MyTurnData.theImage as UIImage
                            cell.Turn1Image?.image = UIImage(named: "noImage.png")
                            print("Error: \(error!.localizedDescription)")
                        }
                    })

                } else {
                    
                    let URL = Foundation.URL(string: "\(MyTurnData.turnURL)\(mediaSuf)")!
                    cell.Turn1Image?.hnk_setImage(from: URL)
                    cell.Turn1Image?.contentMode = UIViewContentMode.scaleAspectFit
                    
                }
                
            }
        
            
            /*
            let request: NSURLRequest = NSURLRequest(URL: NSURL(string: "\(MyTurnData.turnURL)\(mediaSuf)")!)
            let mainQueue = NSOperationQueue.mainQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    
                    if !self.fileExists(NSURL(string: "\(MyTurnData.turnURL)\(mediaSuf)")) {
                        print("file DOES NOT exists - \(MyTurnData.turnURL)\(mediaSuf)")
                        cell.Turn1Image?.image = UIImage(named: "noImage.png")
                        
                    } else {
                        print("file exists - \(MyTurnData.turnURL)\(mediaSuf)")
                        dispatch_async(dispatch_get_main_queue(), {
                            if let cellToUpdate = self.TableView.cellForRowAtIndexPath(indexPath) {
                                
                                // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                                
                                if MyTurnData.mediaType == "gif" {
                                    cell.Turn1Image?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                                } else {
                                    
                                    cell.Turn1Image?.image = image
                                    cell.Turn1Image?.contentMode = UIViewContentMode.ScaleAspectFit
                                }
                                //let GIFData = NSData
                                
                                // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                                //cellToUpdate.TurnImage?.image = image
                            }
                        })
                        // }
                    }
                    
                }
                else {
                    //cell.TurnImage?.image = MyTurnData.theImage as UIImage
                    cell.Turn1Image?.image = UIImage(named: "noImage.png")
                    print("Error: \(error!.localizedDescription)")
                }
            })
            
            
            */
            
            //   }
            /*
            if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: MyTurnData.URL)) {
            // print("image Data = \(data)")
            //make sure your image in this url does exist, otherwise unwrap in a if let check
            cell.TurnImage?.image = UIImage(data: data)!
            } else {
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            }
            */
            
            // cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = true
            
            
        }
        return cell
    }
    
    
    @IBAction func shareAll(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "SocialMedia") as! SocialViewController
        
        savingsInformationViewController.socialdelegate = self
        //  savingsInformationViewController,
        
        //   .view.background = UIColor.clearColor()
        /*
        savingsInformationViewController.TheImage = self.theimage
        savingsInformationViewController.TheQuote = self.thequote
        savingsInformationViewController.theMediaType = self.theMediaType
        
        savingsInformationViewController.PreviousMediaType = self.PreviousMediaType
        savingsInformationViewController.gamestyle = self.GameStyleInfo
        savingsInformationViewController.theTurnNumber = self.theTurnNumber
        savingsInformationViewController.hideBorder = self.hideBorder
        savingsInformationViewController.PreviousImage = self.PreviousImage
        savingsInformationViewController.PreviousQuote = self.PreviousQuote
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player1 = self.Player1Info
        savingsInformationViewController.player2 = self.Player2Info
        savingsInformationViewController.player3 = self.Player3Info
        savingsInformationViewController.player4 = self.Player4Info
        savingsInformationViewController.player5 = self.Player5Info
        savingsInformationViewController.player6 = self.Player6Info
        savingsInformationViewController.player7 = self.Player7Info
        savingsInformationViewController.player8 = self.Player8Info
        savingsInformationViewController.player9 = self.Player9Info
        savingsInformationViewController.player10 = self.Player10Info
        savingsInformationViewController.FullGameImage = self.FullGameImage
        
        */
        savingsInformationViewController.gameid = self.GameID
        
        savingsInformationViewController.theTurnNumber = "Turn11"
        savingsInformationViewController.FullGameImage = self.FullGameImage
        
         savingsInformationViewController.hideBorder = true
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            popoverController2.sourceView = sender as! UIView
            // popoverController2.vi
            //  popoverController2.sourceView = self.view
            // popoverController2.sourceView = getgroupsBTN.self as! UIView
            //popoverController2.sourceRect = sender.bounds
            let DeviceW = self.view.frame.width
            let middleScreenW = DeviceW / 2
            let middleX = middleScreenW - 100
            
            
            popoverController2.sourceRect = sender.bounds
            //CGRectMake(middleX,150,0,0)
            
            popoverController2.permittedArrowDirections = .down
            popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
    }
    
    func ShareVideo(_ outputURL: URL) {
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Share Game Video", message: "", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let FBAction: UIAlertAction = UIAlertAction(title: "Facebook", style: .Default) { action -> Void in
        //Post to Facebook
        //  var controller: AnyObject? = self.pageViewController.viewControllers.last
        
        //  var picNum = Int()
        //  var indexnew = controller?.pageIndex
        //let FBImage = self.theimage
        //  var FBImage = self.pageViewController.viewControllers!.ui
        
        let postresult = shareVideoToFaceBook(outputURL)
        
        //let postresult = shareImageToFaceBook(FBImage)
        
        if postresult {
        print("Video posted to facebook")
        } else {
        print("error Video not posted")
        }
        
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
        
        let FBSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        
        FBSheet.setInitialText("I'm Playing Pics & QUotes")
        
        FBSheet.addURL(outputURL)
        //var fbImage2 = theimage
        
        // FBSheet.addImage(FBImage)
        
        self.presentViewController(FBSheet, animated: true, completion: nil)
        
        } else {
        
        let alert = UIAlertController(title: "Accounts", message: "Please login to Facebook", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
        
        }
        actionSheetController.addAction(FBAction)
        
        let TweetAction: UIAlertAction = UIAlertAction(title: "Twitter", style: .Default) { action -> Void in
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        
        let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        twitterSheet.addURL(outputURL)
        twitterSheet.setInitialText("I'm Playing Pics & Quotes")
        
        //  let TwitterImage = self.theimage
        
        //  twitterSheet.addImage(TwitterImage)
        
        self.presentViewController(twitterSheet, animated: true, completion: nil)
        
        } else {
        
        let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
        
        
        }
        
        actionSheetController.addAction(TweetAction)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Save to Video Library", style: .Default) { action -> Void in
        
        
        
        let library = ALAssetsLibrary()
        if library.videoAtPathIsCompatibleWithSavedPhotosAlbum(outputURL) {
        library.writeVideoAtPathToSavedPhotosAlbum(outputURL,
        completionBlock: { (assetURL:NSURL!, error:NSError!) -> Void in
        var title = ""
        var message = ""
        if error != nil {
        title = "Error"
        message = "Failed to save video"
        } else {
        title = "Success"
        message = "The has been Video saved to your photo library."
        }
        //  let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        //  alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        //  self.presentViewController(alert, animated: true, completion: nil)
        
        
        dispatch_async(dispatch_get_main_queue(), {
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: title, subTitle: message, duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
        })
        
        
        })
        }
        
        }
        
        actionSheetController.addAction(nextAction)
        
        let SMSAction: UIAlertAction = UIAlertAction(title: "Send As Message", style: .Default) { action -> Void in
        
        //save to images
        //  let library = ALAssetsLibrary()
        // let imageToSave = filter.outputImage
        // let orientation = self.theimage.imageOrientation
        
        
        let imageData = NSData(contentsOfURL: self.VideoFile)
        
        //  let compressedJPGImage = VideoFile
        
        let messageVC = MFMessageComposeViewController()
        
        
        messageVC.body = "";
        // messageVC.recipients = [""]
        messageVC.messageComposeDelegate = self;
        messageVC.addAttachmentData(imageData!, typeIdentifier: "mov", filename: "PicsAndQuotes.mov")
        
        self.presentViewController(messageVC, animated: false, completion: nil)
        
        }
        
        actionSheetController.addAction(SMSAction)
        
        
        
        
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        
        //save to images
        
        }
        
        actionSheetController.addAction(CancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        */
        
        
        
        DispatchQueue.main.async(execute: {
            
            let theAlert = SCLAlertView()
            theAlert.addButton("FaceBook", action: {
                
                let postresult = shareVideoToFaceBook(outputURL, myView: self)
                
                //let postresult = shareImageToFaceBook(FBImage)
                
                if postresult {
                    print("Video posted to facebook")
                } else {
                    print("error Video not posted")
                }
                
                
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                    
                    let FBSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    
                    
                    FBSheet.setInitialText("I'm Playing Pics & QUotes")
                    
                    FBSheet.add(outputURL)
                    //var fbImage2 = theimage
                    
                    // FBSheet.addImage(FBImage)
                    
                    self.present(FBSheet, animated: true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Accounts", message: "Please login to Facebook", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
            })
            
            theAlert.addButton("Twitter", action: {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    
                    let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    
                    twitterSheet.add(outputURL)
                    twitterSheet.setInitialText("I'm Playing Pics & Quotes")
                    
                    //  let TwitterImage = self.theimage
                    
                    //  twitterSheet.addImage(TwitterImage)
                    
                    self.present(twitterSheet, animated: true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            
            theAlert.addButton("Text Message", action: {
                
                let imageData = try? Data(contentsOf: self.VideoFile)
                
                //  let compressedJPGImage = VideoFile
                
                let messageVC = MFMessageComposeViewController()
                
                
                messageVC.body = "";
                // messageVC.recipients = [""]
                messageVC.messageComposeDelegate = self;
                messageVC.addAttachmentData(imageData!, typeIdentifier: "mov", filename: "PicsAndQuotes.mov")
                
                self.present(messageVC, animated: false, completion: nil)
                
            })
            
            theAlert.addButton("Save to Library", action: {
                
                let library = ALAssetsLibrary()
                
                //SWIFT 3 ERROR FIXED
                
                if library.videoAtPathIs(compatibleWithSavedPhotosAlbum: outputURL) {
                     library.writeVideoAtPath(toSavedPhotosAlbum: outputURL, completionBlock: { (asetURL, error) in
                            var title = ""
                            var message = ""
                            if error != nil {
                                title = "Error"
                                message = "Failed to save video"
                            } else {
                                title = "Success"
                                message = "The has been Video saved to your photo library."
                            }
                            //  let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                            //  alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                            //  self.presentViewController(alert, animated: true, completion: nil)
                            
                            
                            DispatchQueue.main.async(execute: {
                                
                                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: title, subTitle: message, duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                            })
                            
                            
                    })
                }
                 
                 
                 
                 
 
                
            })
            
            
            
            theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0), title: "Share Game Video", subTitle: "", duration: nil, completeText: "Cancel", style: .custom, colorStyle: 1, colorTextButton: 1)
        })
        
        
        
        
        
    }
    
    
}

extension GalleryItemViewController {
    //}: FBFriendsViewControllerDelegate {
    func SocialViewControllerFinished(_ socialviewController: SocialViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        self.CanCreateVideo = socialviewController.CanCreateVideo
        
        if self.CanCreateVideo  {
            
            
            //_ = NSString()
            
            
            let tempVideoFile: NSString = self.VideoFile.description as NSString
            
            if tempVideoFile.isEqual(to: "")  {
                self.view.addSubview(self.progressHUDVideo)
                
                self.CreateGameVideo()
                //Image1!, Image2: Image2!)
                print("Creating Video")
            } else {
                self.ShareVideo(self.VideoFile)
            }
            
        }
        
        //  LikedPushedArray.removeAtIndex(ReplaceAtRowNum);
        
        //  LikedPushedArray.insert(item2, atIndex: ReplaceAtRowNum)
    }
    
    
    func exportDidFinish(_ session: AVAssetExportSession) {
        switch (session.status) {
        case AVAssetExportSessionStatus.completed :
            let outputURL = session.outputURL
            
            
            
            self.progressHUDVideo.removeFromSuperview()
            
            VideoFile = outputURL!
            ShareVideo(outputURL!)
            
            //}
        case AVAssetExportSessionStatus.exporting:
            print("Exporting")
        case AVAssetExportSessionStatus.failed:
            self.progressHUDVideo.removeFromSuperview()
            
            
            let AC = JSController("Error", MyMessage: "There was an error Converting the Video, please try again.",Color: "Red")
            // self.presentViewController(AC, animated: true, completion: nil)
            
            
            DispatchQueue.main.async(execute: {
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "There was an error Converting the Video, please try again.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            })
            
            
            print("Failed error = \(session.error)")
        case AVAssetExportSessionStatus.unknown:
            print("Unknown")
        case AVAssetExportSessionStatus.waiting:
            print("Waiting")
        default:
            print("Default")
        }
        
    }
    
    func CreateGameVideo() {
        
        
        images.append(image1)
        images.append(image2)
        images.append(image3)
        images.append(image4)
        images.append(image5)
        images.append(image6)
        images.append(image7)
        images.append(image8)
        images.append(image9)
        images.append(image10)
        AudioClips.append(Audio1)
        AudioClips.append(Audio2)
        AudioClips.append(Audio3)
        AudioClips.append(Audio4)
        AudioClips.append(Audio5)
        AudioClips.append(Audio6)
        AudioClips.append(Audio7)
        AudioClips.append(Audio8)
        AudioClips.append(Audio9)
        AudioClips.append(Audio10)
        
        // self.ThisGameTurnInfoArray.append(ThisGameTurnInfo(playerName: CompleteGameInfoArray.GamePlayer3, playerID: CompleteGameInfoArray.GamePlayer3ID, likes: CompleteGameInfoArray.like3, fails: CompleteGameInfoArray.fail3, turnURL: CompleteGameInfoArray.Turn3URLx, mediaType: CompleteGameInfoArray.media3, TurnNumber: "3"))
        
        
        print("Audio Clips Count = \(AudioClips.count)")
        print("Images count = \(images.count)")
        print("Quotes Count = \(Quotes.count)")
        
        
        
        
        let IntroTime = CMTimeMake(4, 1)
        let TitleTime = CMTimeMake(2, 1)
        var TimeLength1 = CMTime()
        var TimeLength2 = CMTime()
        var TimeLength3 = CMTime()
        var TimeLength4 = CMTime()
        var TimeLength5 = CMTime()
        var TimeLength6 = CMTime()
        var TimeLength7 = CMTime()
        var TimeLength8 = CMTime()
        var TimeLength9 = CMTime()
        var TimeLength10 = CMTime()
        var Audio1Time = CMTime()
        var Audio2Time = CMTime()
        var Audio3Time = CMTime()
        var Audio4Time = CMTime()
        var Audio5Time = CMTime()
        var Audio6Time = CMTime()
        var Audio7Time = CMTime()
        var Audio8Time = CMTime()
        var Audio9Time = CMTime()
        var Audio10Time = CMTime()
        var AudioEndTime = CMTime()
        
        let boomBox = UIImage(named: "BoomBox1.png")
        
        
        var TotalTime = IntroTime + TitleTime
        let SlideTime = CMTimeMake(3, 1)
        let Audio0Time = CMTimeMake(5, 1)
        let TimeLength0 = CMTimeMake(2, 1)
        Audio1Time = CMTimeMake(6, 1);
        
        var STInt = Int64()
        STInt = 3
        
        /*
        Audio2Time = CMTimeMake(16, 1);
        Audio3Time = CMTimeMake(26, 1);
        Audio4Time = CMTimeMake(36, 1);
        Audio5Time = CMTimeMake(46, 1);
        Audio6Time = CMTimeMake(56, 1);
        Audio7Time = CMTimeMake(66, 1);
        Audio8Time = CMTimeMake(76, 1);
        Audio9Time = CMTimeMake(86, 1);
        Audio10Time = CMTimeMake(96, 1);
        */
        
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        
        
        // let path = NSBundle.mainBundle().pathForResource("PQTempMusic3", ofType:"m4v")
        
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let path = dirpath.stringByAppendingPathComponent("PQTempMusic4.m4v") as String
        print("LOADING URL FROM PATH \(path)")
        
        //let audioPath = NSBundle.mainBundle().pathForResource("ComedicFun", ofType:"mp3")
        let audioPath = dirpath.stringByAppendingPathComponent("ComedicFun.mp3") as String
        let url = URL(fileURLWithPath: path)
        //   let audiourl = NSURL.fileURLWithPath(audioPath!)
        
        let audiourl = URL(fileURLWithPath: path)
        
        let VideoAsset = AVURLAsset(url: url, options: nil) as AVAsset
        print("Video Asset Duration = \(VideoAsset.duration)")
        
        let AudioAsset = AVURLAsset(url: audiourl, options: nil) as AVAsset
        print("Video Asset Duration = \(VideoAsset.duration)")
        
        
        // let gifurl = NSURL(string: "\(imageURLArray[5]).gif")
        //  print("GIF URL FOR COMP = \(gifurl)")
        // let GIFAsset = AVURLAsset(URL: gifurl!, options: nil) as AVAsset
        
        let vtrack = VideoAsset.tracks(withMediaType: AVMediaTypeVideo)
        let atrack = AudioAsset.tracks(withMediaType: AVMediaTypeAudio)
        
        //  let giftrack = GIFAsset.tracksWithMediaType(AVMediaTypeVideo)
        //  let atrack1 = AVAsset(URL: AudioClips[0], options: nil) as AVAsset
        
        let videoTrack:AVAssetTrack = vtrack[0]
        let audioTrack:AVAssetTrack = atrack[0]
        
        // let GIFTrack: AVAssetTrack = giftrack[0]
        
        let vid_duration = videoTrack.timeRange.duration
        
        let vid_timerange = CMTimeRangeMake(kCMTimeZero, VideoAsset.duration)
        let aud_timerange = CMTimeRangeMake(kCMTimeZero, AudioAsset.duration)
        
        print("Video TimeRange = \(vid_timerange)")
        
        let size = videoTrack.naturalSize
        
        var audioAsset: AVAsset?
        
        let allAudioParams = AVMutableAudioMixInputParameters()
        
        for track in atrack {
            // var audioInputParams : AVMutableAudioMixInputParameters = AVMutableAudioMixInputParameters()
            //audioInputParams.setVolume(5, atTime:kCMTimeZero)
            allAudioParams.setVolume(5, at: kCMTimeZero)
            
            //allAudioParams.addObject(audioInputParams)
        }
        
        let audioZeroMix : AVMutableAudioMix = AVMutableAudioMix()
        audioZeroMix.inputParameters = [allAudioParams]
        
        let mixComposition = AVMutableComposition()
        
        
        // GETS PRIMARY VIDEO TEMP FILE
        
        let compVideoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        do {
            try compVideoTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, VideoAsset.duration), of: VideoAsset.tracks(withMediaType: AVMediaTypeVideo)[0], at: kCMTimeZero)
        } catch {
            print("Video Error = \(error)")
        }
        
        // print("set up comVideoTrack")
        let compAudioTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
        
        do {
            try compAudioTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset.duration), of: VideoAsset.tracks(withMediaType: AVMediaTypeAudio)[0], at: kCMTimeZero)
        } catch {
            print("Audio Error = \(error)")
        }
        
        /*
        let compTrackGIF = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        do {
        try compTrackGIF.insertTimeRange(CMTimeRangeMake(kCMTimeZero, GIFAsset.duration), ofTrack: GIFAsset.tracksWithMediaType(AVMediaTypeVideo)[0], atTime: kCMTimeZero)
        } catch {
        print("Audio Error = \(error)")
        }
        
        */
        
        
        let TurnStructure1 = ThisGameTurnInfoArray[0]
        let TurnStructure2 = ThisGameTurnInfoArray[1]
        let TurnStructure3 = ThisGameTurnInfoArray[2]
        let TurnStructure4 = ThisGameTurnInfoArray[3]
        let TurnStructure5 = ThisGameTurnInfoArray[4]
        let TurnStructure6 = ThisGameTurnInfoArray[5]
        let TurnStructure7 = ThisGameTurnInfoArray[6]
        let TurnStructure8 = ThisGameTurnInfoArray[7]
        let TurnStructure9 = ThisGameTurnInfoArray[8]
        let TurnStructure10 = ThisGameTurnInfoArray[9]
        
        
        //SET UP TRACK 1
        
        if TurnStructure1.mediaType == "audio" {
       // if MediaTypeArray[0] == "audio" {
            images2.append(boomBox!)
            print("setting up audio1")
            let A_Path1 = (documentDirectory as NSString).appending("/Audio1.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path1 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path1 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[0].write(to: URL(fileURLWithPath: A_Path1), options: [.atomic])
            let AudioAsset1_URL = URL(fileURLWithPath: A_Path1)
            
            let AudioAsset1 = AVURLAsset(url: AudioAsset1_URL, options: nil) as AVAsset
            //let aTrack1 = AudioAsset1.tracksWithMediaType(AVMediaTypeAudio)
            
            
            let compAudioTrack1 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack1.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset1.duration), of: AudioAsset1.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio1Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength1 = AudioAsset1.duration + TotalTime
            Audio2Time = TimeLength1
            TotalTime = TimeLength1
            TimeLength1 = AudioAsset1.duration
        } else {
            TimeLength1 = CMTimeMake(STInt, 1) + TotalTime
            Audio2Time = TimeLength1
            TotalTime = TimeLength1
            TimeLength1 = SlideTime
            
             if TurnStructure1.mediaType == "audio" {
           // if MediaTypeArray[0] == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure1.turnURL).gif")
                //let gifURL = NSURL(string: "\(imageURLArray[0]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
               // let newImage =
                
                images2.append(images[0])
                
            }
            
            
        }
        // let audioTrack1:AVAssetTrack = aTrack1[0]
        //END SET UP AUDIO TRACK 1
        
        
        //if MediaTypeArray[1] == "audio" {
    if TurnStructure2.mediaType == "audio" {
            images2.append(boomBox!)
            //SET UP AUDIO TRACK 2
            print("setting up audio2")
            let A_Path2 = (documentDirectory as NSString).appending("/Audio2.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path2 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path2 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            
            try? AudioClips[1].write(to: URL(fileURLWithPath: A_Path2), options: [.atomic])
            let AudioAsset2_URL = URL(fileURLWithPath: A_Path2)
            let AudioAsset2 = AVURLAsset(url: AudioAsset2_URL, options: nil) as AVAsset
            let aTrack2 = AudioAsset2.tracks(withMediaType: AVMediaTypeAudio)
            //  let audioTrack2:AVAssetTrack = aTrack2[0]
            //END SET UP AUDIO TRACK 2
            
            let compAudioTrack2 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack2.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset2.duration), of: AudioAsset2.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio2Time)
            } catch {
                print("Video Error = \(error)")
            }
            TimeLength2 = AudioAsset2.duration + TotalTime
            Audio3Time = TimeLength2
            TotalTime = TimeLength2
            TimeLength2 = AudioAsset2.duration
        } else {
            TimeLength2 = CMTimeMake(STInt, 1) + TotalTime
            Audio3Time = TimeLength2
            TotalTime = TimeLength2
            TimeLength2 = SlideTime
            
            
            if TurnStructure2.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure2.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
                images2.append(images[1])
            }
        }
        
        
        if TurnStructure3.mediaType == "audio" {
            //SET UP AUDIO TRACK 3
            images2.append(boomBox!)
            let A_Path3 = (documentDirectory as NSString).appending("/Audio3.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path3 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path3 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[2].write(to: URL(fileURLWithPath: A_Path3), options: [.atomic])
            let AudioAsset3_URL = URL(fileURLWithPath: A_Path3)
            let AudioAsset3 = AVURLAsset(url: AudioAsset3_URL, options: nil) as AVAsset
            let aTrack3 = AudioAsset3.tracks(withMediaType: AVMediaTypeAudio)
            // let audioTrack3:AVAssetTrack = aTrack3[0]
            //END SET UP AUDIO TRACK 1
            let compAudioTrack3 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack3.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset3.duration), of: AudioAsset3.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio3Time)
            } catch {
                print("Video Error = \(error)")
            }
            TimeLength3 = AudioAsset3.duration + TotalTime
            Audio4Time = TimeLength3
            TotalTime = TimeLength3
            TimeLength3 = AudioAsset3.duration
        } else {
            TimeLength3 = CMTimeMake(STInt, 1) + TotalTime
            Audio4Time = TimeLength3
            TotalTime = TimeLength3
            TimeLength3 = SlideTime
            
            if TurnStructure3.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure3.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
                images2.append(images[2])
            }
        }
        //SET UP AUDIO TRACK 4
        
        if TurnStructure4.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path4 = (documentDirectory as NSString).appending("/Audio4.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path4 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path4 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            
            try? AudioClips[3].write(to: URL(fileURLWithPath: A_Path4), options: [.atomic])
            let AudioAsset4_URL = URL(fileURLWithPath: A_Path4)
            let AudioAsset4 = AVURLAsset(url: AudioAsset4_URL, options: nil) as AVAsset
            // let aTrack4 = AudioAsset4.tracksWithMediaType(AVMediaTypeAudio)
            //  audioTrack4:AVAssetTrack = aTrack4[0]
            
            let compAudioTrack4 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack4.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset4.duration), of: AudioAsset4.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio4Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength4 = AudioAsset4.duration + TotalTime
            Audio5Time = TimeLength4
            TotalTime = TimeLength4
            TimeLength4 = AudioAsset4.duration
        } else {
            TimeLength4 = CMTimeMake(STInt, 1) + TotalTime
            Audio5Time = TimeLength4
            TotalTime = TimeLength4
            TimeLength4 = SlideTime
            
            if TurnStructure4.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure4.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                images2.append(images[3])
            }
        }
        
        //SET UP AUDIO TRACK 5
        
        if TurnStructure5.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path5 = (documentDirectory as NSString).appending("/Audio5.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path5 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path5 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[4].write(to: URL(fileURLWithPath: A_Path5), options: [.atomic])
            let AudioAsset5_URL = URL(fileURLWithPath: A_Path5)
            let AudioAsset5 = AVURLAsset(url: AudioAsset5_URL, options: nil) as AVAsset
            let aTrack5 = AudioAsset5.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack5 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack5.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset5.duration), of: AudioAsset5.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio5Time)
            } catch {
                print("Video Error = \(error)")
            }
            TimeLength5 = AudioAsset5.duration + TotalTime
            Audio6Time = TimeLength5
            TotalTime = TimeLength5
            TimeLength5 = AudioAsset5.duration
        } else {
            TimeLength5 = CMTimeMake(STInt, 1) + TotalTime
            Audio6Time = TimeLength5
            TotalTime = TimeLength5
            TimeLength5 = SlideTime
            
            if TurnStructure5.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure5.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                images2.append(images[4])
            }
        }
        
        
        if TurnStructure6.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path6 = (documentDirectory as NSString).appending("/Audio6.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path6 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path6 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[5].write(to: URL(fileURLWithPath: A_Path6), options: [.atomic])
            let AudioAsset6_URL = URL(fileURLWithPath: A_Path6)
            let AudioAsset6 = AVURLAsset(url: AudioAsset6_URL, options: nil) as AVAsset
            let aTrack6 = AudioAsset6.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack6 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack6.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset6.duration), of: AudioAsset6.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio6Time)
                print("inserting turn 6 Audio")
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength6 = AudioAsset6.duration + TotalTime
            Audio7Time = TimeLength6
            TotalTime = TimeLength6
            TimeLength6 = AudioAsset6.duration
        } else {
            if TurnStructure6.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure6.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
                images2.append(images[5])
            }
            TimeLength6 = CMTimeMake(STInt, 1) + TotalTime
            Audio7Time = TimeLength6
            TotalTime = TimeLength6
            TimeLength6 = SlideTime
        }
        
        
        if TurnStructure7.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path7 = (documentDirectory as NSString).appending("/Audio7.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path7 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path7 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[6].write(to: URL(fileURLWithPath: A_Path7), options: [.atomic])
            let AudioAsset7_URL = URL(fileURLWithPath: A_Path7)
            let AudioAsset7 = AVURLAsset(url: AudioAsset7_URL, options: nil) as AVAsset
            let aTrack7 = AudioAsset7.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack7 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack7.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset7.duration), of: AudioAsset7.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio7Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength7 = AudioAsset7.duration + TotalTime
            Audio8Time = TimeLength7
            TotalTime = TimeLength7
            TimeLength7 = AudioAsset7.duration
            
        } else {
            TimeLength7 = CMTimeMake(STInt, 1) + TotalTime
            Audio8Time = TimeLength7
            TotalTime = TimeLength7
            TimeLength7 = SlideTime
            if TurnStructure7.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure7.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                images2.append(images[6])
            }
        }
        
        if TurnStructure8.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path8 = (documentDirectory as NSString).appending("/Audio8.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path8 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path8 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[7].write(to: URL(fileURLWithPath: A_Path8), options: [.atomic])
            let AudioAsset8_URL = URL(fileURLWithPath: A_Path8)
            let AudioAsset8 = AVURLAsset(url: AudioAsset8_URL, options: nil) as AVAsset
            let aTrack8 = AudioAsset8.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack8 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack8.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset8.duration), of: AudioAsset8.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio8Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength8 = AudioAsset8.duration + TotalTime
            Audio9Time = TimeLength8
            TotalTime = TimeLength8
            TimeLength8 = AudioAsset8.duration
        } else {
            TimeLength8 = CMTimeMake(STInt, 1) + TotalTime
            Audio9Time = TimeLength8
            TotalTime = TimeLength8
            TimeLength8 = SlideTime
            
            if TurnStructure8.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure8.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
                images2.append(images[7])
            }
        }
        
        if TurnStructure9.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path9 = (documentDirectory as NSString).appending("/Audio9.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path9 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path9 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[8].write(to: URL(fileURLWithPath: A_Path9), options: [.atomic])
            let AudioAsset9_URL = URL(fileURLWithPath: A_Path9)
            let AudioAsset9 = AVURLAsset(url: AudioAsset9_URL, options: nil) as AVAsset
            let aTrack9 = AudioAsset9.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack9 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack9.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset9.duration), of: AudioAsset9.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio9Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength9 = AudioAsset9.duration + TotalTime
            Audio10Time = TimeLength9
            TotalTime = TimeLength9
            TimeLength9 = AudioAsset9.duration
        } else {
            TimeLength9 = CMTimeMake(STInt, 1) + TotalTime
            Audio10Time = TimeLength9
            TotalTime = TimeLength9
            TimeLength9 = SlideTime
            if TurnStructure9.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure9.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                
                images2.append(images[8])
            }
        }
        
        
        if TurnStructure10.mediaType == "audio" {
            images2.append(boomBox!)
            let A_Path10 = (documentDirectory as NSString).appending("/Audio10.m4v")
            
            if FileManager.default.fileExists(atPath: A_Path10 as String) {
                print("Deleting existing file\n")
                
                do {
                    
                    try FileManager.default.removeItem(atPath: A_Path10 as String)
                } catch {
                    print("Error = \(error)")
                }
            }
            
            
            try? AudioClips[9].write(to: URL(fileURLWithPath: A_Path10), options: [.atomic])
            let AudioAsset10_URL = URL(fileURLWithPath: A_Path10)
            let AudioAsset10 = AVURLAsset(url: AudioAsset10_URL, options: nil) as AVAsset
            let aTrack10 = AudioAsset10.tracks(withMediaType: AVMediaTypeAudio)
            //  audioTrack5:AVAssetTrack = aTrack5[0]
            //END SET UP AUDIO TRACK 5
            let compAudioTrack10 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: 0)
            
            do {
                try compAudioTrack10.insertTimeRange(CMTimeRangeMake(kCMTimeZero, AudioAsset10.duration), of: AudioAsset10.tracks(withMediaType: AVMediaTypeAudio)[0], at: Audio10Time)
            } catch {
                print("Video Error = \(error)")
            }
            
            TimeLength10 = AudioAsset10.duration + TotalTime
            AudioEndTime = TimeLength10
            TotalTime = TimeLength10
            TimeLength10 = AudioAsset10.duration
            
        } else {
            TimeLength10 = CMTimeMake(STInt, 1) + TotalTime
            AudioEndTime = TimeLength10
            TotalTime = TimeLength10
            TimeLength10 = SlideTime
            if TurnStructure10.mediaType == "gif" {
                
                let gifURL = URL(string: "\(TurnStructure10.turnURL).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
                images2.append(images[9])
            }
        }
        //INSERT ADUIO TRACK 1
        
        
        //INSERT ADUIO TRACK 1
        print("All Audio Tracks have been set up")
        
        print("Insert all audio tracks")
        compVideoTrack.preferredTransform = videoTrack.preferredTransform
        
        //STARTS CREATING TURN 1 INSERT
        let videoLayer = CALayer()
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.contents = compVideoTrack
        
        
        let gameFont = UIFont(name: "ChalkboardSE-Regular", size: 18.0)
        
        let gameFontTitle = UIFont(name: "ChalkboardSE-Regular", size: 30.0)
        let gameFontBy = UIFont(name: "ChalkboardSE-Regular", size: 10.0)
        
        let titleAnimation = CABasicAnimation(keyPath: "Title")
        titleAnimation.duration = 2
        titleAnimation.isRemovedOnCompletion = true
        titleAnimation.beginTime = CMTimeGetSeconds(TitleTime)
        titleAnimation.fadeInDuration = 1
        
        let turnAnimation0 = CABasicAnimation(keyPath: "Turn0")
        turnAnimation0.duration = CMTimeGetSeconds(TimeLength0)
        turnAnimation0.isRemovedOnCompletion = true
        turnAnimation0.beginTime = CMTimeGetSeconds(Audio0Time)
        
        
        let turnAnimation1 = CABasicAnimation(keyPath: "Turn1")
        turnAnimation1.duration = CMTimeGetSeconds(TimeLength1)
        turnAnimation1.isRemovedOnCompletion = true
        turnAnimation1.beginTime = CMTimeGetSeconds(Audio1Time)
        
        let turnAnimation2 = CABasicAnimation(keyPath: "Turn2")
        turnAnimation2.duration = CMTimeGetSeconds(TimeLength2)
        turnAnimation2.isRemovedOnCompletion = true
        turnAnimation2.beginTime = CMTimeGetSeconds(Audio2Time)
        turnAnimation2.fadeInDuration = 1
        
        
        let turnAnimation3 = CABasicAnimation(keyPath: "Turn2")
        turnAnimation3.duration = CMTimeGetSeconds(TimeLength3)
        turnAnimation3.isRemovedOnCompletion = true
        turnAnimation3.beginTime = CMTimeGetSeconds(Audio3Time)
        
        
        let turnAnimation4 = CABasicAnimation(keyPath: "Turn4")
        turnAnimation4.duration = CMTimeGetSeconds(TimeLength4)
        turnAnimation4.isRemovedOnCompletion = true
        turnAnimation4.beginTime = CMTimeGetSeconds(Audio4Time)
        
        
        let turnAnimation5 = CABasicAnimation(keyPath: "Turn5")
        turnAnimation5.duration = CMTimeGetSeconds(TimeLength5)
        turnAnimation5.isRemovedOnCompletion = true
        turnAnimation5.beginTime = CMTimeGetSeconds(Audio5Time)
        
        let turnAnimation6 = CABasicAnimation(keyPath: "Turn6")
        turnAnimation6.duration = CMTimeGetSeconds(TimeLength6)
        turnAnimation6.isRemovedOnCompletion = true
        turnAnimation6.beginTime = CMTimeGetSeconds(Audio6Time)
        
        let turnAnimation7 = CABasicAnimation(keyPath: "Turn7")
        turnAnimation7.duration = CMTimeGetSeconds(TimeLength7)
        turnAnimation7.isRemovedOnCompletion = true
        turnAnimation7.beginTime = CMTimeGetSeconds(Audio7Time)
        turnAnimation7.fadeInDuration = 1
        
        
        let turnAnimation8 = CABasicAnimation(keyPath: "Turn8")
        turnAnimation8.duration = CMTimeGetSeconds(TimeLength8)
        turnAnimation8.isRemovedOnCompletion = true
        turnAnimation8.beginTime = CMTimeGetSeconds(Audio8Time)
        
        
        let turnAnimation9 = CABasicAnimation(keyPath: "Turn9")
        turnAnimation9.duration = CMTimeGetSeconds(TimeLength9)
        turnAnimation9.isRemovedOnCompletion = true
        turnAnimation9.beginTime = CMTimeGetSeconds(Audio4Time)
        
        
        let turnAnimation10 = CABasicAnimation(keyPath: "Turn10")
        turnAnimation10.duration = CMTimeGetSeconds(TimeLength10)
        turnAnimation10.isRemovedOnCompletion = true
        turnAnimation10.beginTime = CMTimeGetSeconds(Audio10Time)
        
        let turnAnimation11 = CABasicAnimation(keyPath: "End")
        //  turnAnimation11.duration = CMTimeGetSeconds(TimeLength10)
        turnAnimation11.isRemovedOnCompletion = false
        turnAnimation11.beginTime = CMTimeGetSeconds(Audio10Time) + CMTimeGetSeconds(TimeLength10)
        
        
        let Chalk = UIImage(named: "chalkboard bg.png")
        
        
        let titleLayer = CATextLayer()
        titleLayer.string = "GAME: \(GameNameInfo)"
        //"Text Test"
        //titleLayer.frame = CGRectMake(0, 30, size.width, size.height / 6)
        titleLayer.frame = CGRect(x: (size.width * 0.2) / 2, y: (size.height / 2) + 10, width: size.width * 0.8, height: size.height / 7)
        titleLayer.alignmentMode = kCAAlignmentCenter
        titleLayer.beginTime = CFTimeInterval(2.9)
        titleLayer.duration = CFTimeInterval(1.8)
        //textLayer1.r
        titleLayer.font = gameFontTitle
        titleLayer.foregroundColor = UIColor.black.cgColor
        //titleLayer.string.Color = UIColor.blackColor()
        titleLayer.animation(forKey: "Title")
        titleLayer.backgroundColor = UIColor.white.cgColor
        titleLayer.cornerRadius = 10
        titleLayer.borderWidth = 2
        titleLayer.borderColor = UIColor.white.cgColor
        
        
        //GameNameInfo
        let textLayer1 = CATextLayer()
        textLayer1.string = Quotes[0] as String
        //textLayer1.string = ""
        //"Text Test"
        textLayer1.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer1.alignmentMode = kCAAlignmentCenter
        textLayer1.beginTime = CFTimeInterval(5.5)
        //CMTimeGetSeconds(Audio1Time) + 1
        textLayer1.duration = CMTimeGetSeconds(TimeLength1)
        //textLayer1.r
        textLayer1.font = gameFont
        textLayer1.animation(forKey: "Turn1")
        textLayer1.isWrapped = true
        
        
        let blankLayer0:CALayer = CALayer()
        blankLayer0.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // blankLayer1.backgroundColor = UIColor.blackColor().CGColor
        blankLayer0.animation(forKey: "Turn0")
        blankLayer0.beginTime = CMTimeGetSeconds(Audio0Time)
        blankLayer0.beginTime = Double(CMTimeGetSeconds(Audio0Time))
        blankLayer0.duration = CMTimeGetSeconds(TimeLength0)
        blankLayer0.contents = Chalk!.cgImage
        
        
        let bytextLayer1 = CATextLayer()
        bytextLayer1.string = users[0] as String
        //"Text Test"
        bytextLayer1.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer1.alignmentMode = kCAAlignmentCenter
        bytextLayer1.beginTime = CFTimeInterval(5.5)
        //CMTimeGetSeconds(Audio1Time) + 1
        bytextLayer1.duration =  CMTimeGetSeconds(TimeLength1)
        //textLayer1.r
        bytextLayer1.font = gameFontBy
        bytextLayer1.animation(forKey: "Turn1")
        bytextLayer1.backgroundColor = UIColor.black.cgColor
        bytextLayer1.cornerRadius = 10
        bytextLayer1.borderWidth = 2
        bytextLayer1.borderColor = UIColor.white.cgColor
        
        
        let T1:CALayer = CALayer()
        T1.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T1.contents = UIImage(named: "num1.png")?.cgImage
        T1.beginTime =  CFTimeInterval(5.5)
        T1.duration =  CMTimeGetSeconds(TimeLength1)
        T1.animation(forKey: "Turn1")
        //textLayer1.
        
        let ImageLayer1:CALayer = CALayer()
        ImageLayer1.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayer1.contents = images2[0].cgImage
        ImageLayer1.beginTime =  CFTimeInterval(5.5)
        ImageLayer1.duration =  CMTimeGetSeconds(TimeLength1)
        ImageLayer1.animation(forKey: "Turn1")
        
        let blankLayer1:CALayer = CALayer()
        blankLayer1.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // blankLayer1.backgroundColor = UIColor.blackColor().CGColor
        blankLayer1.animation(forKey: "Turn1")
        blankLayer1.beginTime = CMTimeGetSeconds(Audio1Time)
        blankLayer1.beginTime = Double(CMTimeGetSeconds(Audio1Time))
        blankLayer1.duration = CMTimeGetSeconds(TimeLength1)
        blankLayer1.contents = Chalk!.cgImage
        //ImageLayer1.position =
        
        /*
        let AudioLayer1 = CALayer()
        AudioLayer1.contents = AudioClips[0]
        AudioLayer1.beginTime = CFTimeInterval(6.0)
        AudioLayer1.duration = CFTimeInterval(10.0)
        */
        
        
        //CREATING TURN 2
        let textLayer2 = CATextLayer()
        textLayer2.string = Quotes[1] as String
        textLayer2.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer2.alignmentMode = kCAAlignmentCenter
        textLayer2.beginTime =  CMTimeGetSeconds(Audio2Time)
        textLayer2.duration =  CMTimeGetSeconds(TimeLength2)
        textLayer2.font = gameFont
        textLayer2.animation(forKey: "Turn2")
        textLayer2.isWrapped = true
        
        
        let bytextLayer2 = CATextLayer()
        bytextLayer2.string = users[1] as String
        //"Text Test"
        bytextLayer2.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer2.alignmentMode = kCAAlignmentCenter
        bytextLayer2.beginTime = CMTimeGetSeconds(Audio2Time)
        bytextLayer2.duration = CMTimeGetSeconds(TimeLength2)
        //textLayer1.r
        bytextLayer2.font = gameFontBy
        bytextLayer2.animation(forKey: "Turn2")
        bytextLayer2.backgroundColor = UIColor.black.cgColor
        bytextLayer2.cornerRadius = 10
        bytextLayer2.borderWidth = 2
        bytextLayer2.borderColor = UIColor.white.cgColor
        
        let T2:CALayer = CALayer()
        T2.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T2.contents = UIImage(named: "num2.png")?.cgImage
        T2.beginTime =  CMTimeGetSeconds(Audio2Time)
        T2.duration =  CMTimeGetSeconds(TimeLength2)
        T2.animation(forKey: "Turn2")
        
        let ImageLayer2:CALayer = CALayer()
        ImageLayer2.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayer2.contents = images2[1].cgImage
        
        ImageLayer2.beginTime = CMTimeGetSeconds(Audio2Time)
        ImageLayer2.duration = CMTimeGetSeconds(TimeLength2)
        ImageLayer2.animation(forKey: "Turn2")
        let blankLayer2:CALayer = CALayer()
        blankLayer2.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // blankLayer2.backgroundColor = UIColor.blackColor().CGColor
        blankLayer2.animation(forKey: "Turn2")
        // blankLayer2.beginTime = (blankLayer1.beginTime - 0.5) + Double(CMTimeGetSeconds(Audio2Time))
        blankLayer2.beginTime = Double(CMTimeGetSeconds(Audio2Time))
        
        blankLayer2.contents = Chalk!.cgImage
        
        print("BlankLayer2 begin time = \(blankLayer1.beginTime - 0.5) + \(Double(CMTimeGetSeconds(Audio2Time)))")
        
        
        //CMTimeGetSeconds(Audio2Time) - 1
        blankLayer2.duration = CMTimeGetSeconds(TimeLength2) + 1
        
        
        //CREATING TURN 3
        let blankLayer3:CALayer = CALayer()
        blankLayer3.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        blankLayer3.backgroundColor = UIColor.black.cgColor
        blankLayer3.animation(forKey: "Turn3")
        //blankLayer3.beginTime = CMTimeGetSeconds(Audio3Time) - 1
        blankLayer3.beginTime = Double(CMTimeGetSeconds(Audio3Time))
        
        blankLayer3.duration = CMTimeGetSeconds(TimeLength3) + 1
        
        blankLayer3.contents = Chalk!.cgImage
        
        let textLayer3 = CATextLayer()
        textLayer3.string = Quotes[2] as String
        //"Text Test"
        textLayer3.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer3.alignmentMode = kCAAlignmentCenter
        textLayer3.beginTime = CMTimeGetSeconds(Audio3Time)
        textLayer3.duration = CMTimeGetSeconds(TimeLength3)
        textLayer3.font = gameFont
        textLayer3.animation(forKey: "Turn3")
        textLayer3.isWrapped = true
        
        //textLayer1.
        
        let ImageLayer3:CALayer = CALayer()
        ImageLayer3.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayer3.contents = images2[2].cgImage
        ImageLayer3.beginTime = CMTimeGetSeconds(Audio3Time)
        ImageLayer3.duration = CMTimeGetSeconds(TimeLength3)
        ImageLayer3.animation(forKey: "Turn3")
        let bytextLayer3 = CATextLayer()
        bytextLayer3.string = users[2] as String
        //"Text Test"
        bytextLayer3.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer3.alignmentMode = kCAAlignmentCenter
        bytextLayer3.beginTime = CMTimeGetSeconds(Audio3Time)
        bytextLayer3.duration = CMTimeGetSeconds(TimeLength3)
        //textLayer1.r
        bytextLayer3.font = gameFontBy
        bytextLayer3.animation(forKey: "Turn3")
        bytextLayer3.backgroundColor = UIColor.black.cgColor
        bytextLayer3.cornerRadius = 10
        bytextLayer3.borderWidth = 2
        bytextLayer3.borderColor = UIColor.white.cgColor
        
        let T3:CALayer = CALayer()
        T3.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T3.contents = UIImage(named: "num3.png")?.cgImage
        T3.beginTime =  CMTimeGetSeconds(Audio3Time)
        T3.duration =  CMTimeGetSeconds(TimeLength3)
        T3.animation(forKey: "Turn3")
        
        //CREATING TURN 4
        let blankLayer4:CALayer = CALayer()
        blankLayer4.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        //blankLayer4.backgroundColor = UIColor.blackColor().CGColor
        blankLayer4.animation(forKey: "Turn4")
        
        blankLayer4.duration = Double(CMTimeGetSeconds(TimeLength4))
        blankLayer4.beginTime = Double(CMTimeGetSeconds(Audio4Time))
        
        blankLayer4.contents = Chalk!.cgImage
        
        
        let textLayer4 = CATextLayer()
        textLayer4.string = Quotes[3] as String
        //"Text Test"
        textLayer4.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer4.alignmentMode = kCAAlignmentCenter
        textLayer4.beginTime = CMTimeGetSeconds(Audio4Time)
        textLayer4.duration = CMTimeGetSeconds(TimeLength4)
        textLayer4.font = gameFont
        textLayer4.animation(forKey: "Turn4")
        textLayer4.isWrapped = true
        
        
        //textLayer1.
        
        let ImageLayer4:CALayer = CALayer()
        ImageLayer4.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        
        ImageLayer4.contents = images2[3].cgImage
        
        
        ImageLayer4.beginTime = CMTimeGetSeconds(Audio4Time)
        ImageLayer4.duration = CMTimeGetSeconds(TimeLength4)
        
        let bytextLayer4 = CATextLayer()
        bytextLayer4.string = users[3] as String
        //"Text Test"
        bytextLayer4.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer4.alignmentMode = kCAAlignmentCenter
        bytextLayer4.beginTime = CMTimeGetSeconds(Audio4Time)
        bytextLayer4.duration = CMTimeGetSeconds(TimeLength4)
        //textLayer1.r
        bytextLayer4.font = gameFontBy
        bytextLayer4.animation(forKey: "Turn4")
        bytextLayer4.backgroundColor = UIColor.black.cgColor
        bytextLayer4.cornerRadius = 10
        bytextLayer4.borderWidth = 2
        bytextLayer4.borderColor = UIColor.white.cgColor
        
        let T4:CALayer = CALayer()
        T4.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T4.contents = UIImage(named: "num4.png")?.cgImage
        T4.beginTime = CMTimeGetSeconds(Audio4Time)
        T4.duration =  CMTimeGetSeconds(TimeLength4)
        T4.animation(forKey: "Turn4")
        
        //CREATING TURN 5
        let blankLayer5:CALayer = CALayer()
        blankLayer5.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        blankLayer5.backgroundColor = UIColor.black.cgColor
        blankLayer5.animation(forKey: "Turn5")
        blankLayer5.duration = Double(CMTimeGetSeconds(TimeLength5))
        blankLayer5.beginTime = Double(CMTimeGetSeconds(Audio5Time))
        blankLayer5.contents = Chalk!.cgImage
        
        let textLayer5 = CATextLayer()
        textLayer5.string = Quotes[4] as String
        //"Text Test"
        textLayer5.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer5.alignmentMode = kCAAlignmentCenter
        textLayer5.beginTime = CMTimeGetSeconds(Audio5Time)
        textLayer5.duration = CMTimeGetSeconds(TimeLength5)
        textLayer5.font = gameFont
        textLayer5.animation(forKey: "Turn5")
        textLayer5.isWrapped = true
        
        //textLayer1.
        
        let ImageLayer5:CALayer = CALayer()
        ImageLayer5.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        
        ImageLayer5.contents = images2[4].cgImage
        ImageLayer5.beginTime = CMTimeGetSeconds(Audio5Time)
        ImageLayer5.duration = CMTimeGetSeconds(TimeLength5)
        let bytextLayer5 = CATextLayer()
        bytextLayer5.string = users[4] as String
        //"Text Test"
        bytextLayer5.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer5.alignmentMode = kCAAlignmentCenter
        bytextLayer5.beginTime = CMTimeGetSeconds(Audio5Time)
        bytextLayer5.duration = CMTimeGetSeconds(TimeLength5)
        //textLayer1.r
        bytextLayer5.font = gameFontBy
        bytextLayer5.animation(forKey: "Turn5")
        bytextLayer5.backgroundColor = UIColor.black.cgColor
        bytextLayer5.cornerRadius = 10
        bytextLayer5.borderWidth = 2
        bytextLayer5.borderColor = UIColor.white.cgColor
        
        
        let T5:CALayer = CALayer()
        T5.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T5.contents = UIImage(named: "num5.png")?.cgImage
        T5.beginTime =  CMTimeGetSeconds(Audio5Time)
        T5.duration =  CMTimeGetSeconds(TimeLength5)
        T5.animation(forKey: "Turn5")
        //////////
        
        let textLayer6 = CATextLayer()
        textLayer6.string = Quotes[5] as String
        //"Text Test"
        textLayer6.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer6.alignmentMode = kCAAlignmentCenter
        textLayer6.beginTime = CMTimeGetSeconds(Audio6Time)
        textLayer6.duration = CMTimeGetSeconds(TimeLength6)
        //textLayer1.r
        textLayer6.font = gameFont
        textLayer6.animation(forKey: "Turn6")
        textLayer6.isWrapped = true
        
        
        let bytextLayer6 = CATextLayer()
        bytextLayer6.string = users[5] as String
        //"Text Test"
        bytextLayer6.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer6.alignmentMode = kCAAlignmentCenter
        bytextLayer6.beginTime =  CMTimeGetSeconds(Audio6Time)
        bytextLayer6.duration =  CMTimeGetSeconds(TimeLength6)
        //textLayer1.r
        bytextLayer6.font = gameFontBy
        bytextLayer6.animation(forKey: "Turn6")
        bytextLayer6.backgroundColor = UIColor.black.cgColor
        bytextLayer6.cornerRadius = 10
        bytextLayer6.borderWidth = 2
        bytextLayer6.borderColor = UIColor.white.cgColor
        
        
        let ImageLayer6:CALayer = CALayer()
        ImageLayer6.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        if TurnStructure6.mediaType == "gif" {
            
            print("Turn 6 is a Gif")
            
            //var ImageLayer6AV = AVPlayerLayer
            
            let gifURL = URL(string: "\(TurnStructure6.turnURL).gif")
            //images2.append(UIImage.animatedImageWithAnimatedGIFURL(gifURL))
            ImageLayer6.contents = UIImage.animatedImage(withAnimatedGIFURL: gifURL)
            
            
        } else {
            
            print("Turn 6 is NOT a Gif")
            
            
            //images2.append(images[9])
            ImageLayer6.contents = images2[5].cgImage
        }
        
        ImageLayer6.contents = images2[5].cgImage
        
        //ImageLayer6.contents = images2[5].CGImage
        ImageLayer6.beginTime =  CMTimeGetSeconds(Audio6Time)
        ImageLayer6.duration =  CMTimeGetSeconds(TimeLength6)
        ImageLayer6.animation(forKey: "Turn6")
        
        let blankLayer6:CALayer = CALayer()
        blankLayer6.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // blankLayer1.backgroundColor = UIColor.blackColor().CGColor
        blankLayer6.animation(forKey: "Turn6")
        blankLayer6.beginTime = CMTimeGetSeconds(Audio6Time)
        //CMTimeGetSeconds(Audio1Time) - 1
        
        blankLayer6.duration = CMTimeGetSeconds(TimeLength6)
        blankLayer6.contents = Chalk!.cgImage
        //ImageLayer1.position =
        
        let T6:CALayer = CALayer()
        T6.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T6.contents = UIImage(named: "num6.png")?.cgImage
        T6.beginTime =  CMTimeGetSeconds(Audio6Time)
        T6.duration =  CMTimeGetSeconds(TimeLength6)
        T6.animation(forKey: "Turn6")
        
        /*
        let AudioLayer1 = CALayer()
        AudioLayer1.contents = AudioClips[0]
        AudioLayer1.beginTime = CFTimeInterval(6.0)
        AudioLayer1.duration = CFTimeInterval(10.0)
        */
        
        
        //CREATING TURN 2
        let textLayer7 = CATextLayer()
        textLayer7.string = Quotes[6] as String
        textLayer7.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer7.alignmentMode = kCAAlignmentCenter
        textLayer7.beginTime =  CMTimeGetSeconds(Audio7Time)
        textLayer7.duration =  CMTimeGetSeconds(TimeLength7)
        textLayer7.font = gameFont
        textLayer7.animation(forKey: "Turn7")
        textLayer7.isWrapped = true
        
        
        let bytextLayer7 = CATextLayer()
        bytextLayer7.string = users[6] as String
        //"Text Test"
        bytextLayer7.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer7.alignmentMode = kCAAlignmentCenter
        bytextLayer7.beginTime = CMTimeGetSeconds(Audio7Time)
        bytextLayer7.duration = CMTimeGetSeconds(TimeLength7)
        //textLayer1.r
        bytextLayer7.font = gameFontBy
        bytextLayer7.animation(forKey: "Turn7")
        bytextLayer7.backgroundColor = UIColor.black.cgColor
        bytextLayer7.cornerRadius = 10
        bytextLayer7.borderWidth = 2
        bytextLayer7.borderColor = UIColor.white.cgColor
        
        let T7:CALayer = CALayer()
        T7.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T7.contents = UIImage(named: "num7.png")?.cgImage
        T7.beginTime =  CMTimeGetSeconds(Audio7Time)
        T7.duration =  CMTimeGetSeconds(TimeLength7)
        T7.animation(forKey: "Turn7")
        
        let ImageLayer7:CALayer = CALayer()
        ImageLayer7.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayer7.contents = images2[6].cgImage
        
        ImageLayer7.beginTime = CMTimeGetSeconds(Audio7Time)
        ImageLayer7.duration = CMTimeGetSeconds(TimeLength7)
        ImageLayer7.animation(forKey: "Turn7")
        let blankLayer7:CALayer = CALayer()
        blankLayer7.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // blankLayer2.backgroundColor = UIColor.blackColor().CGColor
        blankLayer7.animation(forKey: "Turn7")
        // blankLayer2.beginTime = (blankLayer1.beginTime - 0.5) + Double(CMTimeGetSeconds(Audio2Time))
        blankLayer7.beginTime = Double(CMTimeGetSeconds(Audio7Time))
        
        
        blankLayer7.contents = Chalk!.cgImage
        
        print("BlankLayer2 begin time = \(blankLayer7.beginTime - 0.5) + \(Double(CMTimeGetSeconds(Audio7Time)))")
        
        
        //CMTimeGetSeconds(Audio2Time) - 1
        blankLayer7.duration = Double(CMTimeGetSeconds(TimeLength7))
        
        
        //CREATING TURN 3
        let blankLayer8:CALayer = CALayer()
        blankLayer8.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        blankLayer8.backgroundColor = UIColor.black.cgColor
        blankLayer8.animation(forKey: "Turn8")
        //blankLayer3.beginTime = CMTimeGetSeconds(Audio3Time) - 1
        blankLayer8.beginTime = Double(CMTimeGetSeconds(Audio8Time))
        
        blankLayer8.duration = Double(CMTimeGetSeconds(TimeLength8))
        blankLayer8.contents = Chalk!.cgImage
        
        let textLayer8 = CATextLayer()
        textLayer8.string = Quotes[7] as String
        //"Text Test"
        textLayer8.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer8.alignmentMode = kCAAlignmentCenter
        textLayer8.beginTime = CMTimeGetSeconds(Audio8Time)
        textLayer8.duration = CMTimeGetSeconds(TimeLength8)
        textLayer8.font = gameFont
        textLayer8.isWrapped = true
        textLayer8.animation(forKey: "Turn8")
        //textLayer1.
        
        let ImageLayer8:CALayer = CALayer()
        ImageLayer8.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayer8.contents = images2[7].cgImage
        ImageLayer8.beginTime = CMTimeGetSeconds(Audio8Time)
        ImageLayer8.duration = CMTimeGetSeconds(TimeLength8)
        ImageLayer8.animation(forKey: "Turn8")
        let bytextLayer8 = CATextLayer()
        bytextLayer8.string = users[7] as String
        //"Text Test"
        bytextLayer8.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer8.alignmentMode = kCAAlignmentCenter
        bytextLayer8.beginTime = CMTimeGetSeconds(Audio8Time)
        bytextLayer8.duration = CMTimeGetSeconds(TimeLength8)
        //textLayer1.r
        bytextLayer8.font = gameFontBy
        bytextLayer8.animation(forKey: "Turn8")
        bytextLayer8.backgroundColor = UIColor.black.cgColor
        bytextLayer8.cornerRadius = 10
        bytextLayer8.borderWidth = 2
        bytextLayer8.borderColor = UIColor.white.cgColor
        
        let T8:CALayer = CALayer()
        T8.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T8.contents = UIImage(named: "num8.png")?.cgImage
        T8.beginTime =  CMTimeGetSeconds(Audio8Time)
        T8.duration =  CMTimeGetSeconds(TimeLength8)
        T8.animation(forKey: "Turn8")
        
        //CREATING TURN 9
        let blankLayer9:CALayer = CALayer()
        blankLayer9.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        //blankLayer4.backgroundColor = UIColor.blackColor().CGColor
        blankLayer9.animation(forKey: "Turn9")
        blankLayer9.beginTime = CMTimeGetSeconds(Audio9Time)
        blankLayer9.duration = CMTimeGetSeconds(TimeLength9)
        blankLayer9.contents = Chalk!.cgImage
        
        
        let textLayer9 = CATextLayer()
        textLayer9.string = Quotes[8] as String
        //"Text Test"
        textLayer9.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer9.alignmentMode = kCAAlignmentCenter
        textLayer9.beginTime = CMTimeGetSeconds(Audio9Time)
        textLayer9.duration = CMTimeGetSeconds(TimeLength9)
        textLayer9.font = gameFont
        textLayer9.animation(forKey: "Turn9")
        textLayer9.isWrapped = true
        
        //textLayer1.
        
        let ImageLayer9:CALayer = CALayer()
        ImageLayer9.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        
        ImageLayer9.contents = images2[8].cgImage
        ImageLayer9.beginTime = CMTimeGetSeconds(Audio9Time)
        ImageLayer9.duration = CMTimeGetSeconds(TimeLength9)
        let bytextLayer9 = CATextLayer()
        bytextLayer9.string = users[8] as String
        //"Text Test"
        bytextLayer9.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer9.alignmentMode = kCAAlignmentCenter
        bytextLayer9.beginTime = CMTimeGetSeconds(Audio9Time)
        bytextLayer9.duration = CMTimeGetSeconds(TimeLength9)
        //textLayer1.r
        bytextLayer9.font = gameFontBy
        bytextLayer9.animation(forKey: "Turn9")
        bytextLayer9.backgroundColor = UIColor.black.cgColor
        bytextLayer9.cornerRadius = 10
        bytextLayer9.borderWidth = 2
        bytextLayer9.borderColor = UIColor.white.cgColor
        
        let T9:CALayer = CALayer()
        T9.frame = CGRect(x: (size.width * 0.25) / 2, y: 20, width: 40,  height: 40)
        T9.contents = UIImage(named: "num9.png")?.cgImage
        T9.beginTime =  CMTimeGetSeconds(Audio9Time)
        T9.duration =  CMTimeGetSeconds(TimeLength9)
        T9.animation(forKey: "Turn9")
        
        //CREATING TURN 5
        let blankLayer10:CALayer = CALayer()
        blankLayer10.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        blankLayer10.backgroundColor = UIColor.black.cgColor
        blankLayer10.animation(forKey: "Turn10")
        blankLayer10.beginTime = CMTimeGetSeconds(Audio10Time)
        blankLayer10.duration = CMTimeGetSeconds(TimeLength10);
        blankLayer10.contents = Chalk!.cgImage
        
        let textLayer10 = CATextLayer()
        textLayer10.string = Quotes[9] as String
        //"Text Test"
        textLayer10.frame = CGRect(x: 0, y: 50, width: size.width, height: size.height / 2)
        textLayer10.alignmentMode = kCAAlignmentCenter
        textLayer10.beginTime = CMTimeGetSeconds(Audio10Time)
        textLayer10.duration = CMTimeGetSeconds(TimeLength10)
        textLayer10.font = gameFont
        textLayer10.animation(forKey: "Turn10")
        textLayer10.isWrapped = true
        //textLayer1.
        
        let ImageLayer10:CALayer = CALayer()
        ImageLayer10.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        
        ImageLayer10.contents = images2[9].cgImage
        ImageLayer10.beginTime = CMTimeGetSeconds(Audio10Time)
        ImageLayer10.duration = CMTimeGetSeconds(TimeLength10)
        
        let bytextLayer10 = CATextLayer()
        bytextLayer10.string = users[9] as String
        //"Text Test"
        bytextLayer10.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: size.width * 0.75, height: size.height / 7)
        bytextLayer10.alignmentMode = kCAAlignmentCenter
        bytextLayer10.beginTime = CMTimeGetSeconds(Audio10Time)
        bytextLayer10.duration = CMTimeGetSeconds(TimeLength10)
        //textLayer1.r
        bytextLayer10.font = gameFontBy
        bytextLayer10.animation(forKey: "Turn10")
        bytextLayer10.backgroundColor = UIColor.black.cgColor
        bytextLayer10.cornerRadius = 10
        bytextLayer10.borderWidth = 2
        bytextLayer10.borderColor = UIColor.white.cgColor
        
        let T10:CALayer = CALayer()
        T10.frame = CGRect(x: (size.width * 0.25) / 2, y: 15, width: 40,  height: 40)
        T10.contents = UIImage(named: "num10.png")?.cgImage
        T10.beginTime =  CMTimeGetSeconds(Audio10Time)
        T10.duration =  CMTimeGetSeconds(TimeLength10)
        T10.animation(forKey: "Turn10")
        
        
        //CREATING TURN 5
        let blankLayer11:CALayer = CALayer()
        blankLayer11.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        blankLayer11.backgroundColor = UIColor.black.cgColor
        blankLayer11.animation(forKey: "End")
        blankLayer11.beginTime = CMTimeGetSeconds(Audio10Time) + CMTimeGetSeconds(TimeLength10)
        
        // blankLayer11.duration = CMTimeGetSeconds(TimeLength10);
        blankLayer11.contents = Chalk!.cgImage
        
        //PICS & QUOTES AD IMAGE
        let ImageLayerAd1:CALayer = CALayer()
        ImageLayerAd1.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        ImageLayerAd1.contents = UIImage(named: "PQAdd1.png")!.cgImage
        ImageLayerAd1.beginTime = CMTimeGetSeconds(Audio10Time) + CMTimeGetSeconds(TimeLength10) + 1
        //ImageLayerAd1.duration = CMTimeGetSeconds(TimeLength10)
        
        
        
        let parentLayer1:CALayer = CALayer()
        //parentLayer.fame = CGRectMake(0, 0, )
        parentLayer1.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        parentLayer1.addSublayer(videoLayer)
        parentLayer1.addSublayer(titleLayer)
        parentLayer1.addSublayer(blankLayer0)
        
        
        parentLayer1.addSublayer(blankLayer1)
        parentLayer1.addSublayer(ImageLayer1)
        parentLayer1.addSublayer(textLayer1)
        parentLayer1.addSublayer(bytextLayer1)
        parentLayer1.addSublayer(T1)
        //// parentLayer1.addSublayer(AudioLayer1)
        
        
        parentLayer1.addSublayer(blankLayer2)
        parentLayer1.addSublayer(ImageLayer2)
        parentLayer1.addSublayer(textLayer2)
        parentLayer1.addSublayer(bytextLayer2)
        parentLayer1.addSublayer(T2)
        
        parentLayer1.addSublayer(blankLayer3)
        parentLayer1.addSublayer(ImageLayer3)
        parentLayer1.addSublayer(textLayer3)
        parentLayer1.addSublayer(bytextLayer3)
        parentLayer1.addSublayer(T3)
        
        
        parentLayer1.addSublayer(blankLayer4)
        parentLayer1.addSublayer(ImageLayer4)
        parentLayer1.addSublayer(textLayer4)
        parentLayer1.addSublayer(bytextLayer4)
        parentLayer1.addSublayer(T4)
        
        parentLayer1.addSublayer(blankLayer5)
        parentLayer1.addSublayer(ImageLayer5)
        parentLayer1.addSublayer(textLayer5)
        parentLayer1.addSublayer(bytextLayer5)
        parentLayer1.addSublayer(T5)
        
        parentLayer1.addSublayer(blankLayer6)
        parentLayer1.addSublayer(ImageLayer6)
        parentLayer1.addSublayer(textLayer6)
        parentLayer1.addSublayer(bytextLayer6)
        parentLayer1.addSublayer(T6)
        
        //// parentLayer1.addSublayer(AudioLayer1)
        
        
        parentLayer1.addSublayer(blankLayer7)
        parentLayer1.addSublayer(ImageLayer7)
        parentLayer1.addSublayer(textLayer7)
        parentLayer1.addSublayer(bytextLayer7)
        parentLayer1.addSublayer(T7)
        
        parentLayer1.addSublayer(blankLayer8)
        parentLayer1.addSublayer(ImageLayer8)
        parentLayer1.addSublayer(textLayer8)
        parentLayer1.addSublayer(bytextLayer8)
        parentLayer1.addSublayer(T8)
        
        parentLayer1.addSublayer(blankLayer9)
        parentLayer1.addSublayer(ImageLayer9)
        parentLayer1.addSublayer(textLayer9)
        parentLayer1.addSublayer(bytextLayer9)
        parentLayer1.addSublayer(T9)
        
        parentLayer1.addSublayer(blankLayer10)
        parentLayer1.addSublayer(ImageLayer10)
        parentLayer1.addSublayer(textLayer10)
        parentLayer1.addSublayer(bytextLayer10)
        parentLayer1.addSublayer(T10)
        parentLayer1.addSublayer(blankLayer11)
        parentLayer1.addSublayer(ImageLayerAd1)
        
        
        //GIF Test
        
        let ImageLayerGIF:CALayer = CALayer()
        ImageLayerGIF.frame = CGRect(x: (size.width / 3) / 2, y: 5, width: (size.width / 3) * 2, height: size.height)
        
        ImageLayerGIF.contents = images2[9].cgImage
        ImageLayerGIF.beginTime = CMTimeGetSeconds(Audio10Time)
        ImageLayerGIF.duration = CMTimeGetSeconds(TimeLength10)
        
        
        
        
        // parentLayer1.addSublayer(AudioLayer2)
        
        //  view.layer.addSublayer(parentLayer1)
        // compVideoTrack.
        print("Added the layers to the parent layer")
        let gameComposition1 = AVMutableVideoComposition()
        
        gameComposition1.frameDuration = CMTimeMake(1, 30)
        gameComposition1.renderSize = size
        gameComposition1.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer1)
        
        
        
        // let layerInstruction = AVMU
        let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compVideoTrack)
        
        let Turn1Instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compVideoTrack)
        // Turn1Instruction.
        
        
        let mainInstruction = AVMutableVideoCompositionInstruction()
        
        mainInstruction.timeRange = vid_timerange
        
        //        mainInstruction.timeRange = CMTimeRange(start: CMTimeMakeWithSeconds(10, 10), end: CMTimeMakeWithSeconds(10, 20))
        
        mainInstruction.layerInstructions = [layerInstruction]
        
        // mainInstruction.layerInstructions = NSArray(layerInstructions)
        //  mainInstruction.s
        //  mainInstruction.renderSize = size
        //mixComposition.instructions = [mainInstruction]
        gameComposition1.instructions = [mainInstruction]
        
        
        // 4 - Get path
        
        
        //let savePath = (documentDirectory as NSString).stringByAppendingPathComponent("mergeVideoTemp3-\(date).mov")
        
        
        let savePath = (documentDirectory as NSString).appending("/mergeVideoTemp.mov")
        
        print("Save Path = \(savePath)")
        let SaveUrl = URL(fileURLWithPath: savePath)
        
        
        //Remove old video
        if FileManager.default.fileExists(atPath: savePath as String) {
            print("Deleting existing file\n")
            
            do {
                
                try FileManager.default.removeItem(atPath: savePath as String)
            } catch {
                print("Error = \(error)")
            }
        }
        
        let videoSettings = [ AVVideoCodecKey: AVVideoCodecH264, AVVideoWidthKey: 640, AVVideoHeightKey: 480] as [String : Any]
        
        // 5 - Create Exporter
        let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
        
        //   let exporter2 = AVAssetExportSession(asset: gameComposition1, presetName: AVAssetExportPresetHighestQuality)
        print("Supported Export File Types =\(exporter!.supportedFileTypes)")
        
        exporter!.outputURL = SaveUrl
        print("About to add the overlay composition")
        exporter!.videoComposition = gameComposition1
        exporter!.audioMix = audioZeroMix
        exporter!.outputFileType = AVFileTypeQuickTimeMovie
        exporter!.shouldOptimizeForNetworkUse = true
        //exporter!.videoComposition = mainComposition
        
        // exporter!.videoComposition = gameVideoComposition
        
        // 6 - Perform the Export
        exporter!.exportAsynchronously() {
            DispatchQueue.main.async(execute: { () -> Void in
                // let progressHUD = ProgressHUD(text: "Creating Video, Please Wait...")
                //   self.view.addSubview(progressHUD)
                self.exportDidFinish(exporter!)
                //  progressHUD.removeFromSuperview()
            })
        }
        //  }
    }
    

    
    
    func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0,y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
    func createPhotoReel2 () {
        
        
        
        
        let TurnStructure1 = ThisGameTurnInfoArray[0]
        let TurnStructure2 = ThisGameTurnInfoArray[1]
        let TurnStructure3 = ThisGameTurnInfoArray[2]
        let TurnStructure4 = ThisGameTurnInfoArray[3]
        let TurnStructure5 = ThisGameTurnInfoArray[4]
        let TurnStructure6 = ThisGameTurnInfoArray[5]
        let TurnStructure7 = ThisGameTurnInfoArray[6]
        let TurnStructure8 = ThisGameTurnInfoArray[7]
        let TurnStructure9 = ThisGameTurnInfoArray[8]
        let TurnStructure10 = ThisGameTurnInfoArray[9]
        
        
        //SET UP TRACK 1
        
      //  if TurnStructure1.mediaType == "audio" {

        
        
        
        
        print("adding images")
        let image1 = self.image1
        let image2 = self.image2
        let image3 = self.image3
        let image4 = self.image4
        let image5 = self.image5
        let image6 = self.image6
        let image7 = self.image7
        let image8 = self.image8
        let image9 = self.image9
        let image10 = self.image10
        
        
        
        print("adding quotes")
        
        var quote1 = NSString()
        var quote2 = NSString()
        var quote3 = NSString()
        var quote4 = NSString()
        var quote5 = NSString()
        var quote6 = NSString()
        var quote7 = NSString()
        var quote8 = NSString()
        var quote9 = NSString()
        var quote10 = NSString()
        
        if TurnStructure1.mediaType == "audio" {
        //if MediaTypeArray[0] == "audio" {
            quote1 = "(Audio Clip, convert to video to share)"
        } else {
            quote1 = Quotes[0]
        }
        
        if TurnStructure2.mediaType == "audio" {
        //if MediaTypeArray[1] == "audio" {
            quote2 = "(Audio Clip, convert to video to share)"
        } else {
            quote2 = Quotes[1]
        }
        
       if TurnStructure3.mediaType == "audio" {
        //if MediaTypeArray[2] == "audio" {
            quote3 = "(Audio Clip, convert to video to share)"
        } else {
            quote3 = Quotes[2]
        }
        
        if TurnStructure4.mediaType == "audio" {
        //if MediaTypeArray[3] == "audio" {
            quote4 = "(Audio Clip, convert to video to share)"
        } else {
            quote4 = Quotes[3]
        }
        
        
       if TurnStructure5.mediaType == "audio" {
     //   if MediaTypeArray[4] == "audio" {
            quote5 = "(Audio Clip, convert to video to share)"
        } else {
            quote5 = Quotes[4]
        }
        
        if TurnStructure6.mediaType == "audio" {
       // if MediaTypeArray[5] == "audio" {
            quote6 = "(Audio Clip, convert to video to share)"
        } else {
            quote6 = Quotes[5]
        }
        
        if TurnStructure7.mediaType == "audio" {
     //   if MediaTypeArray[6] == "audio" {
            quote7 = "(Audio Clip, convert to video to share)"
        } else {
            quote7 = Quotes[6]
        }
        if TurnStructure8.mediaType == "audio" {
       // if MediaTypeArray[7] == "audio" {
            quote8 = "(Audio Clip, convert to video to share)"
        } else {
            quote8 = Quotes[7]
        }
        
       if TurnStructure9.mediaType == "audio" {
       // if MediaTypeArray[8] == "audio" {
            quote9 = "(Audio Clip, convert to video to share)"
        } else {
            quote9 = Quotes[8]
        }
     
        if TurnStructure10.mediaType == "audio" {
       // if MediaTypeArray[9] == "audio" {
            quote10 = "(Audio Clip, convert to video to share)"
        } else {
            quote10 = Quotes[9]
        }
        
        let n1 = UIImage(named: "num1.png")
        let n2 = UIImage(named: "num2.png")
        let n3 = UIImage(named: "num3.png")
        let n4 = UIImage(named: "num4.png")
        let n5 = UIImage(named: "num5.png")
        let n6 = UIImage(named: "num6.png")
        let n7 = UIImage(named: "num7.png")
        let n8 = UIImage(named: "num8.png")
        let n9 = UIImage(named: "num9.png")
        let n10 = UIImage(named: "num10.png")
        
        //let GameLogo = UIImage(named: "Pics&Quote Logo.png")
        //let GameLogo = UIImage(named: "PQPhoto2.png")
        let GameLogo = UIImage(named: "PQLogoShadow.png")
        
        
        
        
        
        print("Adding quotebox")
        let quoteboxSqbottom = UIImage(named: "QuoteBoxSquare.png")
        let quoteboxSq = UIImage(named: "QuoteBoxSquare_middle.png")
        let quoteboxSqtop = UIImage(named: "QuoteBoxSquare_top.png")
        
        
        
        //var newSize = CGSizeMake(NSString
        
        let DeviceWidth = self.view.frame.width
        let middleScreenX = DeviceWidth / 2
        let middle = middleScreenX - 125
        
        // var middle:CGFloat = 5
        
        let DeviceHeight:CGFloat = 3000
        
        //var middleScreenY = DeviceHeight / 2
        
        
        
        let XGrid = middleScreenX / 4
        let XGrid2 = middleScreenX + XGrid
        
        
        
        
        let newSize = CGSize(width: self.view.frame.size.width, height: DeviceHeight)
        UIGraphicsBeginImageContext(newSize)
        
        
        let font = UIFont(name: "ChalkboardSE-Regular", size: 20.0)
        
        //UIFont(name: "Chalkduster", size: 20.0)
        //let font = UIFont(size: 40.0)
        
        let fontTitle = UIFont(name: "Chalkduster", size: 25.0)
        
        let text = quote1.description
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        
        let textColor = UIColor.black
        let textColorTitle = UIColor.white
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.white
        shadow.shadowOffset = CGSize(width: 0,height: 1)
        // let textColorShadow = UIColor.whiteColor()
        
        var textFontAttributes: [String : AnyObject]?
        var textFontAttributesTitle: [String : AnyObject]?
        
        if let actualFont = font {
            textFontAttributes = [NSFontAttributeName: actualFont, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
            
        }
        
        if let actualFontTitle = fontTitle {
            textFontAttributesTitle = [NSFontAttributeName: actualFontTitle, NSForegroundColorAttributeName: textColorTitle, NSParagraphStyleAttributeName: textStyle]
            //, NSShadowAttributeName: shadow]
            
        }
        
        
        let RectTitle = CGRect(x: XGrid2-100,y: 25,width: 115,height: 100)
        let RectBG = CGRect(x: 0,y: 0,width: DeviceWidth,height: DeviceHeight)
        
        
        let Rect1 = CGRect(x: middle,y: 130,width: 250,height: 250)
        
        let Rect2 = CGRect(x: middle,y: 400,width: 250,height: 250)
        
        
        let Rect3 = CGRect(x: middle,y: 670,width: 250,height: 250)
        
        
        
        let Rect4 = CGRect(x: middle,y: 940,width: 250,height: 250)
        
        let Rect5 = CGRect(x: middle,y: 1210,width: 250,height: 250)
        
        let Rect6 = CGRect(x: middle,y: 1480,width: 250,height: 250)
        
        let Rect7 = CGRect(x: middle,y: 1750,width: 250,height: 250)
        
        let Rect8 = CGRect(x: middle,y: 2020,width: 250,height: 250)
        
        let Rect9 = CGRect(x: middle,y: 2290,width: 250,height: 250)
        
        let Rect10 = CGRect(x: middle,y: 2560,width: 250,height: 250)
        
        
        
        let qRect1 = CGRect(x: middle+15,y: 170,width: 230,height: 220)
        
        let qRect2 = CGRect(x: middle+15,y: 440,width: 230,height: 220)
        
        let qRect3 = CGRect(x: middle+15,y: 710,width: 230,height: 220)
        
        let qRect4 = CGRect(x: middle+15,y: 980,width: 230,height: 220)
        
        let qRect5 = CGRect(x: middle+15,y: 1250,width: 230,height: 220)
        
        let qRect6 = CGRect(x: middle+15,y: 1520,width: 230,height: 220)
        
        let qRect7 = CGRect(x: middle+15,y: 1790,width: 230,height: 220)
        
        let qRect8 = CGRect(x: middle+15,y: 2060,width: 230,height: 220)
        
        let qRect9 = CGRect(x: middle+15,y: 2330,width: 230,height: 220)
        
        let qRect10 = CGRect(x: middle+15,y: 2600,width: 230,height: 220)
        
        
        let nRect1 = CGRect(x: 5,y: 180,width: 40,height: 40)
        
        let nRect2 = CGRect(x: 5,y: 450,width: 40,height: 40)
        
        
        
        let nRect3 = CGRect(x: 5,y: 720,width: 40,height: 40)
        
        
        
        let nRect4 = CGRect(x: 5,y: 990,width: 40,height: 40)
        
        let nRect5 = CGRect(x: 5,y: 1260,width: 40,height: 40)
        
        let nRect6 = CGRect(x: 5,y: 1530,width: 40,height: 40)
        
        let nRect7 = CGRect(x: 5,y: 1800,width: 40,height: 40)
        
        let nRect8 = CGRect(x: 5,y: 2070,width: 40,height: 40)
        
        let nRect9 = CGRect(x: 5,y: 2340,width: 40,height: 40)
        
        let nRect10 = CGRect(x: 5,y: 2610,width: 40,height: 40)
        
        
       // let BGColor = getImageWithColor(UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 1.0), size: CGSize(width: DeviceWidth, height: DeviceHeight))
        
        
        let BGColor = getImageWithColor(UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0), size: CGSize(width: DeviceWidth, height: DeviceHeight))

        
        BGColor.draw(in: RectBG, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        var title = "Pics & Quotes"
        
        GameLogo!.draw(in: RectTitle, blendMode:CGBlendMode.normal, alpha: 1.0)
        
        
        // title.drawInRect(RectTitle, withAttributes: textFontAttributesTitle)
        
        if (TheGameStyle != "picture") {
            
            print("framing quote style images")
            
            
            quoteboxSqtop!.draw(in: Rect1, blendMode:CGBlendMode.normal, alpha: 1.0)
            //quote1.drawInRect(CGRectMake(XGrid,Row1,YGrid,YGrid), withAttributes: textFontAttributes, blendMode:kCGBlendModeNormal, alpha: 1.0)
            quote1.draw(in: qRect1, withAttributes: textFontAttributes)
            
            
            image2.draw(in: Rect2, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            quoteboxSq!.draw(in: Rect3, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote3.draw(in: qRect3, withAttributes: textFontAttributes)
            
            
            
            image4.draw(in: Rect4, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            
            
            quoteboxSq!.draw(in: Rect5, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote5.draw(in: qRect5, withAttributes: textFontAttributes)
            
            
            //6
            image6.draw(in: Rect6, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            //7
            quoteboxSq!.draw(in: Rect7, blendMode:CGBlendMode.normal, alpha: 1.0)
            quote7.draw(in: qRect7, withAttributes: textFontAttributes)
            
            
            
            
            image8.draw(in: Rect8, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            
            quoteboxSq!.draw(in: Rect9, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote9.draw(in: qRect9, withAttributes: textFontAttributes)
            
            
            
            image10.draw(in: Rect10, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
        } else  {
            
            print("framing picture style images")
            
            
            
            image1.draw(in: Rect1, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            
            quoteboxSq!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            //quote1.drawInRect(CGRectMake(XGrid,Row1,YGrid,YGrid), withAttributes: textFontAttributes, blendMode:kCGBlendModeNormal, alpha: 1.0)
            quote2.draw(in: qRect2, withAttributes: textFontAttributes)
            
            
            
            image3.draw(in: Rect3, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            
            quoteboxSq!.draw(in: Rect4, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote4.draw(in: qRect4, withAttributes: textFontAttributes)
            
            
            
            image5.draw(in: Rect5, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            
            quoteboxSq!.draw(in: Rect6, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote6.draw(in: qRect6, withAttributes: textFontAttributes)
            
            
            
            image7.draw(in: Rect7, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            quoteboxSq!.draw(in: Rect8, blendMode:CGBlendMode.normal, alpha: 1.0)
            quote8.draw(in: qRect8, withAttributes: textFontAttributes)
            
            image9.draw(in: Rect9, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            
            quoteboxSqbottom!.draw(in: Rect10, blendMode: CGBlendMode.normal, alpha: 1.0)
            quote10.draw(in: qRect10, withAttributes: textFontAttributes)
            
            
        }
        
        
        n1!.draw(in: nRect1, blendMode: CGBlendMode.normal, alpha: 1.0)
        n2!.draw(in: nRect2, blendMode: CGBlendMode.normal, alpha: 1.0)
        n3!.draw(in: nRect3, blendMode: CGBlendMode.normal, alpha: 1.0)
        n4!.draw(in: nRect4, blendMode: CGBlendMode.normal, alpha: 1.0)
        n5!.draw(in: nRect5, blendMode: CGBlendMode.normal, alpha: 1.0)
        n6!.draw(in: nRect6, blendMode: CGBlendMode.normal, alpha: 1.0)
        n7!.draw(in: nRect7, blendMode: CGBlendMode.normal, alpha: 1.0)
        n8!.draw(in: nRect8, blendMode: CGBlendMode.normal, alpha: 1.0)
        n9!.draw(in: nRect9, blendMode: CGBlendMode.normal, alpha: 1.0)
        n10!.draw(in: nRect10, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData = UIImagePNGRepresentation(newImage)
        
        
      //  images.append(newImage)
        FullGameImage = newImage
        print("image count = \(images.count)")
        // testImageView.image = newImage
        
    }
    
    
}

extension GalleryItemViewController {
    //}: FBFriendsViewControllerDelegate {
    func FailViewControllerFinished(_ failviewController: FailViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        /*
        let replaceRow = 2
        var EmailInfo = [NSString]()
        */
        //let item : String = EmailInfo[replaceRow] as String;
        
        
        /*
        let item = failviewController.TotalFails
        print("replacing item in fail array , adding \(item)")
        NumFails.removeAtIndex(ReplaceAtRowNum);
        
        NumFails.insert(item, atIndex: ReplaceAtRowNum)
        
        */
        
        
    }
}
extension GalleryItemViewController {
    //}: FBFriendsViewControllerDelegate {
    func LikesViewControllerFinished(_ likesviewController: LikesViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        
        /*
        let item  = likesviewController.TotalLikes
        print("replacing item in like array , adding \(item)")
        // let item2  = likesviewController.LikedPUshed
        NumFails.removeAtIndex(ReplaceAtRowNum);
        
        NumFails.insert(item, atIndex: ReplaceAtRowNum)
        */
        
        
        
        //  LikedPushedArray.removeAtIndex(ReplaceAtRowNum);
        
        //  LikedPushedArray.insert(item2, atIndex: ReplaceAtRowNum)
    }
}

struct CompleteGameDataNew {
    
    //let GameCategory : String
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
    //  let GameTurnNumber : String
    //   let GameIsComplete : String
    //   let GameUsersTurn : String
    //    let GameLastTurnTime : String
    let GameTimeLimit : String
    //    let GameCanTakeTurn : String
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
    //   let GameUsersTurnID : String
    let GameContent : String
    let GameSearchString : String
    //  let Turn1MediaType: String
    //   let Turn1URLString: String
    //   let LastTurnUser: String
    let GameSetting: String
    
    let Turn1URLx: String
    let Turn2URLx: String
    let Turn3URLx: String
    let Turn4URLx: String
    let Turn5URLx: String
    let Turn6URLx: String
    let Turn7URLx: String
    let Turn8URLx: String
    let Turn9URLx: String
    let Turn10URLx: String
    
    let like1: String
    let like2: String
    let like3: String
    let like4: String
    let like5: String
    let like6: String
    let like7: String
    let like8: String
    let like9: String
    let like10: String
    
    let fail1: String
    let fail2: String
    let fail3: String
    let fail4: String
    let fail5: String
    let fail6: String
    let fail7: String
    let fail8: String
    let fail9: String
    let fail10: String
    
    let media1: String
    let media2: String
    let media3: String
    let media4: String
    let media5: String
    let media6: String
    let media7: String
    let media8: String
    let media9: String
    let media10: String
    
    
}

struct ThisGameTurnInfo {
    
    let playerName: String
    let playerID: String
    let likes: String
    let fails: String
    let turnURL: String
    let mediaType: String
    let TurnNumber: String
    
}

extension UIImageView {
    func downloadedFrom(link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = URL(string: link)
            else {return}
        contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
}


/*
extension UIImage {
    func downloadedFrom(link link:String) -> UIImage {
        
        var image = UIImage(named: "noImage.png")!
        
        guard
            let url = NSURL(string: link)
            else {return image}
       // contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                //self.image = image
                return image
            }
        }).resume()
    }
}
*/
