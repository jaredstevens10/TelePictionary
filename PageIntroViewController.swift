//
//  PageIntroViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/19/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import AssetsLibrary
import Social
import MessageUI
import AVFoundation
import CoreMedia
import MediaPlayer
import CoreData
//import CAKey

class PageIntroViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate, LikesViewControllerDelegate, FailViewControllerDelegate, SocialViewControllerDelegate,UIPopoverPresentationControllerDelegate {
    
    
    var pulse = CABasicAnimation()
    
    @IBOutlet weak var commentBTN: UIButton!
    
    var CompletedGameIDs = [String]()
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    var likeURL1: URL!
    var ImageDataArray = [Data]()
    var numberImages = [UIImage(named: "num1.png"), UIImage(named: "num2.png"), UIImage(named: "num3.png"), UIImage(named: "num4.png"), UIImage(named: "num5.png"), UIImage(named: "num6.png"), UIImage(named: "num7.png"), UIImage(named: "num8.png"), UIImage(named: "num9.png"), UIImage(named: "num10.png"), UIImage(named: "num1.png")]
    var FullGameImage = UIImage()
    var useimageURLArray = [NSString]()
    var imageURLArray = [NSString]()
    var thepreviousquote = NSString()
    var socialviewcontroller: SocialViewController = SocialViewController()
    var PreviousQuote = NSString()
    var PreviousImage = UIImage()
    //var documentController: UIDocumentInteractionController
    var likeviewcontroller: LikesViewController = LikesViewController()
    var CanCreateVideo = Bool()
    var failviewcontroller: FailViewController = FailViewController()
    var LoadsArray = [true, false, false, false, false, false, false, false, false, false, false]
    var HideArray = [false, false, false, false, false, false, false, false, false, false, true]
        //{
    var imageURL = NSString()
    var imagesURL = [NSString]()
    var userID = NSString()
    @IBOutlet var NumCommentsLBL: UILabel!
    var NumComments = NSString()
    var NumFails = [Int]()
    var theNumFails = NSString()
    var theNumLikes = NSString()
    var documentController: UIDocumentInteractionController!
    var VideoFile: URL!
    var LikedPushedArray = [Bool]()
    var LikePushed = Bool()
    var FailPushedArray = [Bool]()
    var hideBorder = Bool()
   
    @IBOutlet var ViewFailBTN: UIButton!
    @IBOutlet var ViewFailLBL: UILabel!
    
    @IBOutlet var ViewLikesLBL: UILabel!
    
    
    
    let SShare = SocialShare(text: "Share your game")
    
    let progressHUD = ProgressHUD(text: "Creating Video...")
    
    var moviePlayer : MPMoviePlayerController!
    
    let prefs = UserDefaults.standard
    var  FunQuoteBox = [UIImage]()
    @IBOutlet var CloseBTN: UIButton!
    @IBOutlet var View1: UIView!
    @IBOutlet var ViewHolder: UIView!

    @IBOutlet var View1CloseBTN: UIButton!

    @IBOutlet var View1TOP: NSLayoutConstraint!
    @IBOutlet var ViewHolderTOP: NSLayoutConstraint!
    var ViewHowTo = Bool()
    
    @IBOutlet weak var testImageView: UIImageView!
    
    var PageNum = Int()
    var PageNum2 = Int8()
    var indexNum = Int()
    
    @IBOutlet weak var backBTN: UIButton!
    
    @IBOutlet weak var likeBTN: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var uploadBTn: UIButton!
    //@IBOutlet weak var toolBar: UIToolbar!
    
    var numbersTest = [0,1,2,3,4,5,6,7,8,9,10]
    var numberTest = Int()
    
    var strLabel = UILabel()
    var messageFrame = UIView()
    
    var ActivityInd = UIActivityIndicatorView()
    
    var QBoxImage = UIImage(named: "QuoteBoxImage.png")
    var ImageFrame = UIImage(named: "imageFrame.png")
    
    var QuoteBox = [UIImage]()
    
    var FrameImages = [UIImage]()
    
    var thequote = NSString()
    var theimage = UIImage()
    var theUser = NSString()
    var theUserID = NSString()
    var theTurn = NSString()
    var NewLikes = Int()
    var ReplaceAtRowNum = Int()
    var userNames = [NSString]()
    var TurnNumbers = [NSString]()
    
    var theTurnNumber = NSString()
    
    var PlayHidden = [Bool]()
    var StopHidden = [Bool]()
    
    //[ UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png"), UIImage(named: "QuoteBoxImage.png") ]
  //  @IBOutlet weak var loadingRing: UIActivityIndicatorView!
    
    var GAME_ID = NSString()
    
    
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
    var username = NSString()    
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
    var TurnInfo = ["Turn1","Turn2","Turn3","Turn4","Turn5","Turn6","Turn7","Turn8","Turn9","Turn10","Turn11"]
    
//  var images = ["pencilpic.png","pencilpic.png","pencilpic.png","pencilpic.png"]

 //   let pageTitles = ["Title 1", "Title 2", "Title 3", "Title 4"]
    
    var GameNameInfo = NSString()
    
    var pageViewController : UIPageViewController!
    
    func progressBarDisplayer(_ msg:String, _ indicator:Bool){
        print(msg)
        strLabel = UILabel(frame: CGRect(x:50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.darkGray
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
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        print("Swipe left")
        
        
    }
    @IBAction func swiped(_ sender: AnyObject) {
        
        
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        
        self.ViewFailLBL.text = theNumFails as String
        self.ViewLikesLBL.text = theNumLikes as String
        //reset()
        
        //PageNum2++
        
     //   let PageTemp = Int(index)
        
      //  PageNum2 = PageTemp
        
        print("pageNum2 = \(index)")
        print("Index is \(index)")
    }
    
    /*
    func FBShare(theImage: UIImage) {
        let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        photo.image = theImage as UIImage
        photo.userGenerated = true
        let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo]
    }
*/
    
    
    func reset() {
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        self.addChildViewController(pageViewController)
        
        self.view.addSubview(pageViewController.view)
        
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    func resetRefresh(_ index: Int) {
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        self.addChildViewController(pageViewController)
        
        self.view.addSubview(pageViewController.view)
        
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    
    @IBAction func start(_ sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(0)
        
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
      //  reset()
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        
        
        GetCompletedGamesData()
        
        if !CompletedGameIDs.contains(GAME_ID as String) {
        
        ShowGameAsViewed(GAME_ID)
        
        var CompletedCount = self.prefs.integer(forKey: "comGames")
        CompletedCount -= 1
        
        UserDefaults.standard.set(CompletedCount, forKey: "comGames")
            
        }
        
    //reset()
    }
    
    func GetCompletedGamesData() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext!
        
        if let managedContext = appDelegate.managedObjectContext {
             let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CompletedGames")
           // let fetchRequest = NSFetchRequest(entityName: "CompletedGames")
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
    
    func AddLike(_ notification:Notification) {

        let data = (notification as NSNotification).userInfo
        let newNumber1 = data!["likes"] as! String
        let LikeIndex1 = data!["index"] as! String
        let newNumber = Int(newNumber1)
        let LikeIndex = Int(LikeIndex1)
        print("like number = \(newNumber)")
        print("Like index = \(LikeIndex)")
        
        let CurrentLikes = LikeArray[LikeIndex!]
        print("current likes = \(CurrentLikes)")
        
        let NewLikes = CurrentLikes + newNumber!
        print("new Like = \(NewLikes)")
        
        
        self.LikeArray.insert(NewLikes, at: LikeIndex!)
        
        self.LikeArray.remove(at: LikeIndex!);
     
        self.ViewLikesLBL.text = NewLikes.description as String
        
        //["message"].stringValue
    }
    
    func AddFail(_ notification:Notification) {
        let data = (notification as NSNotification).userInfo
        let newNumber1 = data!["fails"] as! String
        let LikeIndex1 = data!["index"] as! String
        let newNumber = Int(newNumber1)
        let LikeIndex = Int(LikeIndex1)
        print("fail number = \(newNumber)")
        print("fail index = \(LikeIndex)")
        
        let CurrentLikes = NumFails[LikeIndex!]
        print("current fails = \(CurrentLikes)")
        
        let NewLikes = CurrentLikes + newNumber!
        print("new Fails = \(NewLikes)")
        
        self.NumFails.insert(NewLikes, at: LikeIndex!)

        self.NumFails.remove(at: LikeIndex!);
     
        
        
           self.ViewFailLBL.text = NewLikes.description as String
    }
    
    
    func DeleteLike(_ notification:Notification) {
        
        let data = (notification as NSNotification).userInfo
        let newNumber1 = data!["likes"] as! String
        let LikeIndex1 = data!["index"] as! String
        let newNumber = Int(newNumber1)
        let LikeIndex = Int(LikeIndex1)
        print("like number = \(newNumber)")
        print("Like index = \(LikeIndex)")
        
        let CurrentLikes = LikeArray[LikeIndex!]
        print("current likes = \(CurrentLikes)")
        
        let NewLikes = CurrentLikes - newNumber!
        print("new Like = \(NewLikes)")
        
        
        self.LikeArray.insert(NewLikes, at: LikeIndex!)
        
        self.LikeArray.remove(at: LikeIndex!);
        
        self.ViewLikesLBL.text = NewLikes.description as String
        
        //["message"].stringValue
    }
    
    func DeleteFail(_ notification:Notification) {
        let data = (notification as NSNotification).userInfo
        let newNumber1 = data!["fails"] as! String
        let LikeIndex1 = data!["index"] as! String
        let newNumber = Int(newNumber1)
        let LikeIndex = Int(LikeIndex1)
        print("fail number = \(newNumber)")
        print("fail index = \(LikeIndex)")
        
        let CurrentLikes = NumFails[LikeIndex!]
        print("current fails = \(CurrentLikes)")
        
        let NewLikes = CurrentLikes - newNumber!
        print("new Fails = \(NewLikes)")
        
        self.NumFails.insert(NewLikes, at: LikeIndex!)
        
        self.NumFails.remove(at: LikeIndex!);
        
        
        
        self.ViewFailLBL.text = NewLikes.description as String
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(PageIntroViewController.AddLike(_:)), name: NSNotification.Name(rawValue: "AddLike"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PageIntroViewController.AddFail(_:)), name: NSNotification.Name(rawValue: "AddFail"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PageIntroViewController.DeleteLike(_:)), name: NSNotification.Name(rawValue: "DeleteLike"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PageIntroViewController.DeleteFail(_:)), name: NSNotification.Name(rawValue: "DeleteFail"),  object: nil)

        likeviewcontroller.likedelegate=self
        failviewcontroller.faildelegate=self
        socialviewcontroller.socialdelegate=self
      
        
        self.navigationController?.popoverPresentationController?.backgroundColor = UIColor.lightGray
        
        TurnNumbers.append("Turn1")
        TurnNumbers.append("Turn2")
        TurnNumbers.append("Turn3")
        TurnNumbers.append("Turn4")
        TurnNumbers.append("Turn5")
        TurnNumbers.append("Turn6")
        TurnNumbers.append("Turn7")
        TurnNumbers.append("Turn8")
        TurnNumbers.append("Turn9")
        TurnNumbers.append("Turn10")
        TurnNumbers.append("Turn11")
        
        
  //  NSNotificationCenter.defaultCenter().postNotificationName("progressLoader", object: nil, userInfo: ["progress":0.1]);
        
        NumCommentsLBL.text = NumComments as String
        
      //  FunQuoteBox.append(UIImage(named: "QBox1.png")!)
      //  FunQuoteBox.append(UIImage(named: "QBox2.png")!)
      //  FunQuoteBox.append(UIImage(named: "QBox3.png")!)
      //  FunQuoteBox.append(UIImage(named: "QBox4.png")!)
       // FunQuoteBox.append(UIImage(named: "QBox5.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box1.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box2.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box3.png")!)
        FunQuoteBox.append(UIImage(named: "Q2Box4.png")!)
        
        
        
        pulse = CABasicAnimation(keyPath: "opacity")
        pulse.duration = 1
        pulse.fromValue = 0.3
        pulse.toValue = 1
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.autoreverses = true
        pulse.repeatCount = FLT_MAX
        
        
        
       // self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameCompleteViewController") as! GameCompleteViewController
       // self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
       // self.pageViewController.dataSource = self
        
        print("Page Intro loaded")
        self.index = 0
        
  //  NSNotificationCenter.defaultCenter().postNotificationName("progressLoader", object: nil, userInfo: ["progress":0.2]);
        
        if Reachability.isConnectedToNetwork() {
            
        //    println("is connected")
        //    progressBarDisplayer("Getting Game Data", true)
            //images = ["",Turn2Image,"",Turn4Image,"",Turn6Image,"",Turn8Image,"",Turn10Image]
            
            
            //  self.TableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            // var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            // view.addGestureRecognizer(tap)
            
            let prefs:UserDefaults = UserDefaults.standard
            
            if GAME_ID == "demo" {
                username = "demoName"
                userID = "demoID"
                
                
            } else {
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            
            }
           // username = prefs.valueForKey("USERNAME") as! NSString as String
          //  userID = prefs.valueForKey("PLAYERID") as! NSString as String
            let URLData = CompleteGameData(GAME_ID, username: username)
            //println(test)
            var GameInfo = FilterGameData(URLData)
            
            
            
   //     NSNotificationCenter.defaultCenter().postNotificationName("progressLoader", object: nil, userInfo: ["progress":0.5]);
            
          //  print("Game Info: \(GameInfo)")
            
            //QuoteBox.append(QBoxImage!)
            
            GameNameInfo = GameInfo[0] as NSString
            GameIDInfo = GameInfo[1] as NSString
            Player1Info = GameInfo[2] as NSString
            Player2Info = GameInfo[3] as NSString
            Player3Info = GameInfo[4] as NSString
            Player4Info = GameInfo[5] as NSString
            Player5Info = GameInfo[6] as NSString
            Player6Info = GameInfo[7] as NSString
            Player7Info = GameInfo[8] as NSString
            Player8Info = GameInfo[9] as NSString
            Player9Info = GameInfo[10] as NSString
            Player10Info = GameInfo[11] as NSString
            Turn1Info = GameInfo[12] as NSString
            Turn2Info = GameInfo[13] as NSString
            Turn3Info = GameInfo[14] as NSString
            Turn4Info = GameInfo[15] as NSString
            Turn5Info = GameInfo[16] as NSString
            Turn6Info = GameInfo[17] as NSString
            Turn7Info = GameInfo[18] as NSString
            Turn8Info = GameInfo[19] as NSString
            Turn9Info = GameInfo[20] as NSString
            Turn10Info = GameInfo[21] as NSString
            GameStyleInfo = GameInfo[22] as NSString
            
            /*
            Like1Info = GameInfo[23] as NSString
            Like2Info = GameInfo[24] as NSString
            Like3Info = GameInfo[25] as NSString
            Like4Info = GameInfo[26] as NSString
            Like5Info = GameInfo[27] as NSString
            Like6Info = GameInfo[28] as NSString
            Like7Info = GameInfo[29] as NSString
            Like8Info = GameInfo[30] as NSString
            Like9Info = GameInfo[31] as NSString
            Like10Info = GameInfo[32] as NSString
            LikeGameInfo = GameInfo[33] as NSString
            
*/
/*
            TurnNumberInfo = GameInfo[12] as! [(NSString)]
            IsCompleteInfo = GameInfo[13] as! [(NSString)]
            UsersTurnInfo = GameInfo[14] as! [(NSString)]
            */
            
            
    //    NSNotificationCenter.defaultCenter().postNotificationName("progressLoader", object: nil, userInfo: ["progress":0.7]);
            
            print(GameNameInfo)
            print(GameStyleInfo)
            
         
            
            if ( GameStyleInfo.description != "picture" ) {
                
                var Turn2Image = UIImage()
                var Turn4Image = UIImage()
                var Turn6Image = UIImage()
                var Turn8Image = UIImage()
                var Turn10Image = UIImage()
                print("Quote Style")
                var Turn2Data = Data()
                var Turn4Data = Data()
                var Turn6Data = Data()
                var Turn8Data = Data()
                var Turn10Data = Data()
                
                if useimageURLArray[1] == "yes" {
                    
                    if MediaTypeArray[1] == "gif" {
                        
                        let FileURL = "\(imageURLArray[1]).gif"
                        let url = URL(string: FileURL as String)
                        Turn2Data = try! Data(contentsOf: url!)
                        //ImageDataArray.append(Turn2Data)
                        
                    } else {
                    
                    let FileURL = "\(imageURLArray[1]).jpg"
                    let url = URL(string: FileURL as String)
                    Turn2Data = try! Data(contentsOf: url!)
                   // ImageDataArray.append(Turn2Data)
                        
                    }
                    
                } else {

                Turn2Data = Data(base64Encoded: Turn2Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
               // ImageDataArray.append(Turn2Data)
                
                }
                if let Turn2ImageTemp = UIImage(data: Turn2Data){
                    Turn2Image = UIImage(data: Turn2Data)!
                } else {
                    Turn2Image = UIImage(named: "noImage.png")!
                }
           // let Turn2Image = UIImage(data: Turn2Data)
                
            
                
                if useimageURLArray[3] == "yes" {
                    if MediaTypeArray[3] == "gif" {
                        
                        let FileURL = "\(imageURLArray[3]).gif"
                        let url = URL(string: FileURL as String)
                        Turn4Data = try! Data(contentsOf: url!)
                      //  ImageDataArray.append(Turn4Data)
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[3]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn4Data = try! Data(contentsOf: url!)
                      //  ImageDataArray.append(Turn4Data)
                    }
                    
                    
                } else {
                    Turn4Data = Data(base64Encoded: Turn4Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                  //  ImageDataArray.append(Turn4Data)
                }
                //let Turn4Image = UIImage(data: Turn4Data)
                
                if let Turn4ImageTemp = UIImage(data: Turn4Data){
                    Turn4Image = UIImage(data: Turn4Data)!
                } else {
                    Turn4Image = UIImage(named: "noImage.png")!
                }
                
                if useimageURLArray[5] == "yes" {
                    if MediaTypeArray[5] == "gif" {
                        
                        let FileURL = "\(imageURLArray[5]).gif"
                        let url = URL(string: FileURL as String)
                        Turn6Data = try! Data(contentsOf: url!)
                      //  ImageDataArray.append(Turn6Data)
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[5]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn6Data = try! Data(contentsOf: url!)
                     //   ImageDataArray.append(Turn6Data)
                    }
                } else {
                    Turn6Data = Data(base64Encoded: Turn6Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                  //  ImageDataArray.append(Turn6Data)
                }
                
                if let Turn6ImageTemp = UIImage(data: Turn6Data){
                    Turn6Image = UIImage(data: Turn6Data)!
                } else {
                    Turn6Image = UIImage(named: "noImage.png")!
                }
                //let Turn6Image = UIImage(data: Turn6Data)
      
                if useimageURLArray[7] == "yes" {
                    if MediaTypeArray[7] == "gif" {
                        
                        let FileURL = "\(imageURLArray[7]).gif"
                        let url = URL(string: FileURL as String)
                        Turn8Data = try! Data(contentsOf: url!)
                      //  ImageDataArray.append(Turn8Data)
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[7]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn8Data = try! Data(contentsOf: url!)
                      //  ImageDataArray.append(Turn8Data)
                    }
                } else {
                    Turn8Data = Data(base64Encoded: Turn8Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                 //   ImageDataArray.append(Turn8Data)
                }
                if let Turn8ImageTemp = UIImage(data: Turn8Data){
                    Turn8Image = UIImage(data: Turn8Data)!
                } else {
                    Turn8Image = UIImage(named: "noImage.png")!
                }
                //let Turn8Image = UIImage(data: Turn8Data)
            
                if useimageURLArray[9] == "yes" {
                    if MediaTypeArray[9] == "gif" {
                        
                        let FileURL = "\(imageURLArray[9]).gif"
                        let url = URL(string: FileURL as String)
                        Turn10Data = try! Data(contentsOf: url!)
                        
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[9]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn10Data = try! Data(contentsOf: url!)
                        
                    }
                } else {
                    Turn10Data = Data(base64Encoded: Turn10Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
                if let Turn10ImageTemp = UIImage(data: Turn10Data){
                    Turn10Image = UIImage(data: Turn10Data)!
                } else {
                    Turn10Image = UIImage(named: "noImage.png")!
                }
               // let Turn10Image = UIImage(data: Turn10Data)
               // ImageDataArray.append(Turn10Data)
                
            
            let ph = UIImage(named: "blank_image.png")
            let boomBox = UIImage(named: "BoomBox1.png")
            let blank_quote = " "
                
            self.FrameImages.append(ph!)
            self.FrameImages.append(self.ImageFrame!)
            self.FrameImages.append(ph!)
            self.FrameImages.append(self.ImageFrame!)
            self.FrameImages.append(ph!)
            self.FrameImages.append(self.ImageFrame!)
            self.FrameImages.append(ph!)
            self.FrameImages.append(self.ImageFrame!)
            self.FrameImages.append(ph!)
            self.FrameImages.append(self.ImageFrame!)
                
            self.FrameImages.append(ph!)
                
                var blankData = Data()
                
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn2Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn4Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn6Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn8Data)
                self.ImageDataArray.append(blankData)
                
                if GAME_ID == "demo" {
                    let likepath = dirpath.stringByAppendingPathComponent("DemoImageTurn.jpg") as String
                    likeURL1 = URL(fileURLWithPath: likepath)
                    let likeURL1Data = try! Data(contentsOf: likeURL1)
                    if likeURL1Data != nil {

                    self.ImageDataArray.append(likeURL1Data)
                    } else {
                      self.ImageDataArray.append(Turn10Data)
                    }
                } else {
                    self.ImageDataArray.append(Turn10Data)
                }
                self.ImageDataArray.append(Turn10Data)
                self.ImageDataArray.append(blankData)
                
                
                
        print("USe Image URL = \(useimageURLArray[3])")
        print("Turn 4 url = \(imageURLArray[3]).jpg")
        print("Turn 4 = \(Turn4Data)")

   
                
               self.images.append(ph!)
                
          //      if Turn2Image! != nil {
            self.images.append(Turn2Image)
              
                /*
                } else {
               self.images.append(ph!)
                }
*/
                
            self.images.append(ph!)
            self.images.append(Turn4Image)
            self.images.append(ph!)
            self.images.append(Turn6Image)
            self.images.append(ph!)
            self.images.append(Turn8Image)
            self.images.append(ph!)
                
                if GAME_ID == "demo" {
                    let likepath = dirpath.stringByAppendingPathComponent("DemoImageTurn.jpg") as String
                    likeURL1 = URL(fileURLWithPath: likepath)
                    let likeURL1Data = try? Data(contentsOf: likeURL1)
                    if likeURL1Data != nil {
                    self.images.append(UIImage(data: likeURL1Data!)!)
                    } else {
                      self.images.append(Turn10Image)
                    }
               // UIImage(data: Turn10Data)
                } else {
            self.images.append(Turn10Image)
                }
           // images.append(ph!)
          //  images = [ph,Turn2Image!,ph,Turn4Image!,ph,Turn6Image!,ph,Turn8Image!,ph,Turn10Image!]
                
            //1
            if MediaTypeArray[0] == "audio" {
                
                var AudioData = Data()
                
                if useimageURLArray[0] == "yes" {
                    
                    let FileURL = "\(imageURLArray[0]).mp3"
                    let url = URL(string: FileURL as String)
                    AudioData = try! Data(contentsOf: url!)
                    
                } else {
                
                    AudioData = Data(base64Encoded: Turn1Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    
                    print("Added Turn1 Audio !!!!!!!!!!!!!!")
                    //let Turn1Audio = UIImage(data: Audio1Data!)
                
         //       let Data2 = try NSString(data: AudioData!, encoding: NSUTF8StringEncoding)!
              
           //     let Audio1Data = try NSData(base64EncodedString: Data2 as String, options: NSDataBase64DecodingOptions(rawValue: 0))!
                
                }
                
                AudioClips.append(AudioData)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                
                PlayHidden.append(false)
                StopHidden.append(false)
                
                

            } else {
                
            AudioClips.append(EmptyAudio)
            Quotes.append(Turn1Info)
                let randomBox = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                QuoteBox.append(FunQuoteBox[randomBox])
                PlayHidden.append(true)
                StopHidden.append(true)
                
                
            }
                
                
             //2
            AudioClips.append(EmptyAudio)
            Quotes.append(blank_quote as NSString)
            QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
            //3
            if MediaTypeArray[2] == "audio" {
                
                
                var AudioData = Data()
                
                if useimageURLArray[2] == "yes" {
                    
                    let FileURL = "\(imageURLArray[2]).mp3"
                    let url = URL(string: FileURL as String)
                    AudioData = try! Data(contentsOf: url!)
                    
                } else {
                
                    AudioData = Data(base64Encoded: Turn3Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
 
                AudioClips.append(AudioData)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(false)
                StopHidden.append(false)
                
            } else {
                
            AudioClips.append(EmptyAudio)
            Quotes.append(Turn3Info)
                //QuoteBox.append(QBoxImage!)
                let randomBox2 = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                QuoteBox.append(FunQuoteBox[randomBox2])
                PlayHidden.append(true)
                StopHidden.append(true)
                
                
                }
                
                
            //4
            AudioClips.append(EmptyAudio)
            Quotes.append(blank_quote as NSString)
            QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
          
            //5
                if MediaTypeArray[4] == "audio" {
           
                    var AudioData = Data()
                    
                    if useimageURLArray[4] == "yes" {
                        
                        let FileURL = "\(imageURLArray[4]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn5Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                } else {
                    
                AudioClips.append(EmptyAudio)
                Quotes.append(Turn5Info)
               // QuoteBox.append(QBoxImage!)
               let randomBox3 = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                QuoteBox.append(FunQuoteBox[randomBox3])
                    
                    PlayHidden.append(true)
                    StopHidden.append(true)
                    
                    
                }
                
                
             //6
            AudioClips.append(EmptyAudio)
            Quotes.append(blank_quote as NSString)
            QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                

            //7
            if MediaTypeArray[6] == "audio" {
                var AudioData = Data()
                
                if useimageURLArray[6] == "yes" {
                    
                    let FileURL = "\(imageURLArray[6]).mp3"
                    let url = URL(string: FileURL as String)
                    AudioData = try! Data(contentsOf: url!)
                    
                } else {
                    
                    AudioData = Data(base64Encoded: Turn7Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
                
                AudioClips.append(AudioData)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(false)
                StopHidden.append(false)
            } else {
                
                AudioClips.append(EmptyAudio)
                Quotes.append(Turn7Info)
                QuoteBox.append(QBoxImage!)
                PlayHidden.append(true)
                StopHidden.append(true)
                }
                
            //8
            AudioClips.append(EmptyAudio)
            Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
             //9
            if MediaTypeArray[8] == "audio" {
                
                var AudioData = Data()
                
                if useimageURLArray[8] == "yes" {
                    
                    let FileURL = "\(imageURLArray[8]).mp3"
                    let url = URL(string: FileURL as String)
                    AudioData = try! Data(contentsOf: url!)
                    
                } else {
                    
                    AudioData = Data(base64Encoded: Turn9Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
                
                AudioClips.append(AudioData)
                
                 Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(false)
                StopHidden.append(false)
            } else {
                AudioClips.append(EmptyAudio)
                Quotes.append(Turn9Info)

                QuoteBox.append(QBoxImage!)
                PlayHidden.append(true)
                StopHidden.append(true)
                }
                
                //10 //11
            Quotes.append(blank_quote as NSString)
            Quotes.append(blank_quote as NSString)
            AudioClips.append(EmptyAudio)
            AudioClips.append(EmptyAudio)
                QuoteBox.append(ph!)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                PlayHidden.append(true)
                StopHidden.append(true)
                
                self.userNames.append(self.Player1Info)
                self.userNames.append(self.Player2Info)
                self.userNames.append(self.Player3Info)
                self.userNames.append(self.Player4Info)
                self.userNames.append(self.Player5Info)
                self.userNames.append(self.Player6Info)
                self.userNames.append(self.Player7Info)
                self.userNames.append(self.Player8Info)
                self.userNames.append(self.Player9Info)
                
                if GAME_ID == "demo" {
                self.userNames.append("You")
                } else {
                self.userNames.append(self.Player10Info)
                }
                
                self.userNames.append("Game Complete")
                
                
                self.users.append("By: \(self.Player1Info)" as NSString)
                self.users.append("By: \(self.Player2Info)" as NSString)
                self.users.append("By: \(self.Player3Info)" as NSString)
                self.users.append("By: \(self.Player4Info)" as NSString)
                self.users.append("By: \(self.Player5Info)" as NSString)
                self.users.append("By: \(self.Player6Info)" as NSString)
                self.users.append("By: \(self.Player7Info)" as NSString)
                self.users.append("By: \(self.Player8Info)" as NSString)
                self.users.append("By: \(self.Player9Info)" as NSString)
                 if GAME_ID == "demo" {
                    self.users.append("By: You")
                } else {
                    self.users.append("By: \(self.Player10Info)" as NSString)
                }
                self.users.append("Game Complete")
                
                /*
            QuoteBox.append(QBoxImage!)
            QuoteBox.append(ph!)
            QuoteBox.append(QBoxImage!)
            QuoteBox.append(ph!)
            QuoteBox.append(QBoxImage!)
            QuoteBox.append(ph!)
            QuoteBox.append(QBoxImage!)
            QuoteBox.append(ph!)
            QuoteBox.append(QBoxImage!)
            QuoteBox.append(ph!)
            QuoteBox.append(ph!)
*/

/*
                               //images.append(ph!)
                Fimages.append(createQuotePictures(Turn1Info as String))
                Fimages.append(Turn2Image!)
                //images.append(ph!)
                Fimages.append(createQuotePictures(Turn3Info as String))
                Fimages.append(Turn4Image!)
                // Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn5Info as String))
                
                Fimages.append(Turn6Image!)
                //Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn7Info as String))
                
                
                Fimages.append(Turn8Image!)
                //Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn9Info as String))
                Fimages.append(Turn10Image!)
         */
            
          //  pageTitles = ["Title 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6", "Title 7", "Title 8", "Title 9", "Title 10"]
                
            } else {
                var Turn2Image = UIImage()
                var Turn4Image = UIImage()
                var Turn6Image = UIImage()
                var Turn8Image = UIImage()
                var Turn10Image = UIImage()
                
                print("Picture style game")
             
                var Turn2Data = Data()
                var Turn4Data = Data()
                var Turn6Data = Data()
                var Turn8Data = Data()
                var Turn10Data = Data()
                
                if useimageURLArray[0] == "yes" {
                    
                    if MediaTypeArray[0] == "gif" {
                        
                        let FileURL = "\(imageURLArray[0]).gif"
                        let url = URL(string: FileURL as String)
                        Turn2Data = try! Data(contentsOf: url!)
                        
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[0]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn2Data = try! Data(contentsOf: url!)
                        
                    }
                    
                } else {
                    
                    Turn2Data = Data(base64Encoded: Turn1Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    
                }
               
                
                if let Turn2ImageTemp = UIImage(data: Turn2Data){
                    Turn2Image = UIImage(data: Turn2Data)!
                } else {
                    Turn2Image = UIImage(named: "noImage.png")!
                }
                //ImageDataArray.append(Turn2Data)
                
                
                if useimageURLArray[2] == "yes" {
                  
                    
                    
                    if MediaTypeArray[2] == "gif" {
                        
                        let FileURL = "\(imageURLArray[2]).gif"
                        let url = URL(string: FileURL as String)
                        Turn4Data = try! Data(contentsOf: url!)
                        
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[2]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn4Data = try! Data(contentsOf: url!)
                        
                    }
                    
                } else {
                    Turn4Data = Data(base64Encoded: Turn3Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
                
                
                if let Turn4ImageTemp = UIImage(data: Turn4Data){
                    Turn4Image = UIImage(data: Turn4Data)!
                } else {
                    Turn4Image = UIImage(named: "noImage.png")!
                }
              //  ImageDataArray.append(Turn4Data)
                
                //var Turn6Image = UIImage()
                
                //data: Turn6Data)
                
                if useimageURLArray[4] == "yes" {
                    
                    if MediaTypeArray[4] == "gif" {
                        
                        let FileURL = "\(imageURLArray[4]).gif"
                        let url = URL(string: FileURL as String)
                        Turn6Data = try! Data(contentsOf: url!)
                        //Turn6Image = UIImage(data: Turn6Dat!a)
                        Turn6Image = UIImage(named: "blank_image.png")!
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[4]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn6Data = try! Data(contentsOf: url!)
                        Turn6Image = UIImage(data: Turn6Data)!
                    }
                    
                } else {
                    Turn6Data = Data(base64Encoded: Turn5Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    
                    
                    if let Turn6ImageTemp = UIImage(data: Turn6Data){
                        Turn6Image = UIImage(data: Turn6Data)!
                    } else {
                        Turn6Image = UIImage(named: "noImage.png")!
                    }
                    //Turn6Image = UIImage(data: Turn6Data)!
                }
              //  ImageDataArray.append(Turn6Data)
                
                
                if useimageURLArray[6] == "yes" {
                    
                    
                    if MediaTypeArray[6] == "gif" {
                        
                        let FileURL = "\(imageURLArray[6]).gif"
                        let url = URL(string: FileURL as String)
                        Turn8Data = try! Data(contentsOf: url!)
                        
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[6]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn8Data = try! Data(contentsOf: url!)
                        
                    }
                    
                } else {
                    Turn8Data = Data(base64Encoded: Turn7Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
              //  let Turn8Image = UIImage(data: Turn8Data)
                
                
                if let Turn8ImageTemp = UIImage(data: Turn8Data){
                    Turn8Image = UIImage(data: Turn8Data)!
                } else {
                    Turn8Image = UIImage(named: "noImage.png")!
                }
              //  ImageDataArray.append(Turn8Data)
                
                if useimageURLArray[8] == "yes" {
                
                    
                    if MediaTypeArray[8] == "gif" {
                        
                        let FileURL = "\(imageURLArray[8]).gif"
                        let url = URL(string: FileURL as String)
                        Turn10Data = try! Data(contentsOf: url!)
                        
                        
                    } else {
                        
                        let FileURL = "\(imageURLArray[8]).jpg"
                        let url = URL(string: FileURL as String)
                        Turn10Data = try! Data(contentsOf: url!)
                        
                    }
                    
                } else {
                    Turn10Data = Data(base64Encoded: Turn9Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                }
                
                
                if let Turn10ImageTemp = UIImage(data: Turn10Data){
                    Turn10Image = UIImage(data: Turn10Data)!
                } else {
                    Turn10Image = UIImage(named: "noImage.png")!
                }
               // let Turn10Image = UIImage(data: Turn10Data)
             //   ImageDataArray.append(Turn10Data)
                
                let ph = UIImage(named: "blank_image.png")
                let boomBox = UIImage(named: "BoomBox1.png")
                let blank_quote = " "
                

                self.images.append(Turn2Image)
                self.images.append(ph!)
                //images.append(createQuotePictures(Turn2Info as String))
                self.images.append(Turn4Image)
                self.images.append(ph!)
                //images.append(createQuotePictures(Turn4Info as String))
                self.images.append(Turn6Image)
                self.images.append(ph!)
                self.images.append(Turn8Image)
                self.images.append(ph!)
                self.images.append(Turn10Image)
                self.images.append(ph!)
               // images.append(ph!)
                
                self.userNames.append(self.Player1Info)
                self.userNames.append(self.Player2Info)
                self.userNames.append(self.Player3Info)
                self.userNames.append(self.Player4Info)
                self.userNames.append(self.Player5Info)
                self.userNames.append(self.Player6Info)
                self.userNames.append(self.Player7Info)
                self.userNames.append(self.Player8Info)
                self.userNames.append(self.Player9Info)
                self.userNames.append(self.Player10Info)
                self.userNames.append("Game Complete")
                
                
                self.users.append("By: \(self.Player1Info)" as NSString)
                self.users.append("By: \(self.Player2Info)" as NSString)
                self.users.append("By: \(self.Player3Info)" as NSString)
                self.users.append("By: \(self.Player4Info)" as NSString)
                self.users.append("By: \(self.Player5Info)" as NSString)
                self.users.append("By: \(self.Player6Info)" as NSString)
                self.users.append("By: \(self.Player7Info)" as NSString)
                self.users.append("By: \(self.Player8Info)" as NSString)
                self.users.append("By: \(self.Player9Info)" as NSString)
                self.users.append("By: \(self.Player10Info)" as NSString)
                self.users.append("Game Complete")

                //1
                Quotes.append(blank_quote as NSString)
                AudioClips.append(EmptyAudio)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
                
                
                
                
                //2
                if MediaTypeArray[1] == "audio" {
                    var AudioData = Data()
                    
                    if useimageURLArray[1] == "yes" {
                        
                        let FileURL = "\(imageURLArray[1]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn2Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                    
                } else {
                    
                    AudioClips.append(EmptyAudio)
                    Quotes.append(Turn2Info)
                    //QuoteBox.append(QBoxImage!)
                    let randomBox2 = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                    
                    QuoteBox.append(FunQuoteBox[randomBox2])
                    
                    PlayHidden.append(true)
                    StopHidden.append(true)
                }

                //3
                AudioClips.append(EmptyAudio)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
                
                //4
                if MediaTypeArray[3] == "audio" {
                    var AudioData = Data()
                    
                    if useimageURLArray[3] == "yes" {
                        
                        let FileURL = "\(imageURLArray[3]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn4Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                } else {
                    
                    AudioClips.append(EmptyAudio)
                    Quotes.append(Turn4Info)
                    //QuoteBox.append(QBoxImage!)
                    
                    let randomBox = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                    QuoteBox.append(FunQuoteBox[randomBox])
                    
                    PlayHidden.append(true)
                    StopHidden.append(true)
                }
                
                
                //5
                AudioClips.append(EmptyAudio)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                
                
                //6
                if MediaTypeArray[5] == "audio" {
                   
                    var AudioData = Data()
                    
                    if useimageURLArray[5] == "yes" {
                        
                        let FileURL = "\(imageURLArray[5]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn6Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                } else {
                    
                    AudioClips.append(EmptyAudio)
                    Quotes.append(Turn6Info)
                    //QuoteBox.append(QBoxImage!)
                    
                    let randomBox3 = Int(arc4random_uniform(UInt32(FunQuoteBox.count)))
                    QuoteBox.append(FunQuoteBox[randomBox3])
                    PlayHidden.append(true)
                    StopHidden.append(true)
                }
                
                
                //7
                AudioClips.append(EmptyAudio)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)

                //8
                if MediaTypeArray[7] == "audio" {
                   
                    var AudioData = Data()
                    
                    if useimageURLArray[7] == "yes" {
                        
                        let FileURL = "\(imageURLArray[7]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn8Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                } else {
                    
                    AudioClips.append(EmptyAudio)
                    Quotes.append(Turn8Info)
                    QuoteBox.append(QBoxImage!)
                    PlayHidden.append(true)
                    StopHidden.append(true)
                }
                
                
                //9
                AudioClips.append(EmptyAudio)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
                //10
                if MediaTypeArray[9] == "audio" {
                    var AudioData = Data()
                    
                    if useimageURLArray[9] == "yes" {
                        
                        let FileURL = "\(imageURLArray[9]).mp3"
                        let url = URL(string: FileURL as String)
                        AudioData = try! Data(contentsOf: url!)
                        
                    } else {
                        
                        AudioData = Data(base64Encoded: Turn10Info as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    }
                    
                    AudioClips.append(AudioData)
                    Quotes.append(blank_quote as NSString)
                    QuoteBox.append(ph!)
                    PlayHidden.append(false)
                    StopHidden.append(false)
                } else {
                    
                    AudioClips.append(EmptyAudio)
                    Quotes.append(Turn10Info)
                    QuoteBox.append(QBoxImage!)
                    PlayHidden.append(true)
                    StopHidden.append(true)                }
                
                
                //11
                AudioClips.append(EmptyAudio)
                Quotes.append(blank_quote as NSString)
                QuoteBox.append(ph!)
                PlayHidden.append(true)
                StopHidden.append(true)
          
                /*
                QuoteBox.append(ph!)
                QuoteBox.append(QBoxImage!)
                QuoteBox.append(ph!)
                QuoteBox.append(QBoxImage!)
                QuoteBox.append(ph!)
                QuoteBox.append(QBoxImage!)
                QuoteBox.append(ph!)
                QuoteBox.append(QBoxImage!)
                QuoteBox.append(ph!)
                QuoteBox.append(QBoxImage!)
                QuoteBox.append(ph!)
                */
                
                FrameImages.append(ImageFrame!)
                FrameImages.append(ph!)
                FrameImages.append(ImageFrame!)
                FrameImages.append(ph!)
                FrameImages.append(ImageFrame!)
                FrameImages.append(ph!)
                FrameImages.append(ImageFrame!)
                FrameImages.append(ph!)
                FrameImages.append(ImageFrame!)
                FrameImages.append(ph!)
                
                FrameImages.append(ph!)
                
                
                var blankData = Data()
               
                self.ImageDataArray.append(Turn2Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn4Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn6Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn8Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(Turn10Data)
                self.ImageDataArray.append(blankData)
                self.ImageDataArray.append(blankData)
                
                /*
                Fimages.append(Turn2Image!)
                //images.append(ph!)
                Fimages.append(createQuotePictures(Turn2Info as String))
                Fimages.append(Turn4Image!)
                //images.append(ph!)
                Fimages.append(createQuotePictures(Turn4Info as String))
                Fimages.append(Turn6Image!)
               // Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn6Info as String))

                Fimages.append(Turn8Image!)
                //Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn6Info as String))

                
                Fimages.append(Turn10Image!)
                //Fimages.append(ph!)
                Fimages.append(createQuotePictures(Turn10Info as String))
*/
                // images.append(ph!)

            }
            /*
            dispatch_async(dispatch_get_main_queue()) {
                self.messageFrame.removeFromSuperview()
            }       // loadingRing.stopAnimating()
            */
            /*
            theimage = self.images[0]
            theUser = self.TurnInfo[0]
            theTurn = self.users[0]
            NewLikes = self.LikeArray[0]
*/
            PreviousQuote = ""
            createPhotoReel2()
            thepreviousquote = ""
            theTurnNumber = ""
            thequote = (self.Quotes[0] as NSString)
            theimage = (self.images[0] as UIImage)
            theMediaType = (self.MediaTypeArray[0] as NSString)
            PreviousMediaType = "NA"
            
            // theimage = (self.images[0] as UIImage)
            theUser = self.userNames[0]
            print("the user = \(theUser)")
            theTurn = self.TurnInfo[0] as NSString
            NewLikes = self.LikeArray[0]
            ReplaceAtRowNum = 0
         
            self.ViewFailLBL.text = NumFails[0].description
            self.ViewLikesLBL.text = LikeArray[0].description
            
            NumCommentsLBL.text = NumComments as String
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
        
        reset()
        
      /*
        View1.layer.cornerRadius = 10
        View1CloseBTN.layer.cornerRadius = 10
        
        
        ViewHolder.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        
        let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_GameComplete")
        
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
        NotificationCenter.default.post(name: Notification.Name(rawValue: "progressLoader"), object: nil, userInfo: ["progress":1.0]);
        
       NotificationCenter.default.post(name: Notification.Name(rawValue: "StopTimerNotification"), object: nil)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
       
    
    /*
    @IBAction func ViewHowTo(sender: AnyObject) {
        
         pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
       // let ViewHowTo = PageViewController
        if GameCompleteViewController.ViewHowTo {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                GameCompleteViewController.View1TOP.constant = middleY
                
                GameCompleteViewController.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                GameCompleteViewController.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            GameCompleteViewController.ViewHowTo = true
        }
        
    }
    */    
        
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! GameCompleteViewController
        var indexNew = vc.pageIndex as Int
        let indexPrevious = indexNew - 1
        
        if indexNew == self.images.count {
            hideBorder = true
        } else {
            hideBorder = false
        }
        
        
        if(indexNew < self.images.count) {
            
            //self.index = self.index! - 1
            
            
            //let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameCompleteViewController") as! GameCompleteViewController
            thequote = (self.Quotes[indexNew] as NSString)
            print("the quote before is \(thequote)")
            
            let testIndex = indexNew + 1
            //     theimage = (self.images[indexNew] as UIImage)
            print("AFTER test Index = \(testIndex.description)")
            
            /*
            if testIndex < 0 {
                theimage = (self.images[indexNew] as UIImage)
            } else {
            theimage = (self.images[testIndex] as UIImage)
            }
            */
            
            theimage = (self.images[indexNew] as UIImage)
            //theimage = (self.images[indexNew] as UIImage)
            theUser = self.userNames[indexNew]
            
            if indexPrevious < 0 {
                PreviousQuote = ""
                thepreviousquote = ""
                self.PreviousMediaType = "NA"
            } else {
            
            PreviousQuote = (self.Quotes[indexPrevious] as NSString)
            PreviousImage = (self.images[indexPrevious] as UIImage)
            thepreviousquote = (self.Quotes[indexPrevious] as NSString)
             self.PreviousMediaType = MediaTypeArray[indexPrevious]
            }
        
          
            
          //  print("the user = \(theUser)")
            theTurn = self.TurnInfo[indexNew] as NSString
            print("AFTER - the turn user = \(theTurn)")
         //   hideBorder = false
            NewLikes = self.LikeArray[indexNew]
            ReplaceAtRowNum = indexNew
            theTurnNumber = self.TurnNumbers[indexNew]
            theNumFails = NumFails[indexNew].description as NSString
            theNumLikes = LikeArray[indexNew].description as NSString
            self.ViewFailLBL.text = theNumFails as String
            self.ViewLikesLBL.text = theNumLikes as String
            self.theUserID = self.Game_Data_ArrayID[indexNew]
            LikePushed = LikedPushedArray[indexNew]
            self.hideBorder = HideArray[indexNew]
            self.theMediaType = MediaTypeArray[indexNew]
           
           // self.theMediaType = MediaTypeArray[indexNew]
            print("AFTER - NEW INDEX NEW after = \(indexNew.description)")

            indexNew += 1
           // self.index = self.index! + 1
            //pageContentViewController.ImageView.image = uploadImage
            //return pageContentViewController
            return self.viewControllerAtIndex(indexNew)
            //return pageContentViewController
            
           
        }
        return nil
        
    }
    /*
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    var index = (viewController as! GameCompleteViewController).pageIndex
    indexNum++
        
        /*
        theimage = self.images[index]
        theUser = self.TurnInfo[index]
        theTurn = self.users[index]
        print("The User = \(theUser)")
        NewLikes = self.LikeArray[index]
        ReplaceAtRowNum = index
        */
        
        index++
    
        print("indexNum: \(indexNum)")
        let countind = self.images.count
        print("images count: \(countind)")
        
        
        
    if(index == self.images.count){
    return nil
    }
        
        
    return self.viewControllerAtIndex(index)
    
    }
    */
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! GameCompleteViewController
        var indexNew = vc.pageIndex as Int
        var indexPrevious = indexNew - 1
        
        
        if indexNew == self.images.count {
            hideBorder = true
        } else {
            hideBorder = false
        }
        
        if(indexNew > 0) {
        
       // self.index = self.index! - 1
        
       
      //  let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameCompleteViewController") as! GameCompleteViewController
        
       //  indexNew--
            
                 // theimage = (self.images[self.index!] as? UIImage)!
            //thequote = (self.Quotes[indexNew] as NSString)
            
             thequote = (self.Quotes[indexNew] as NSString)
            print("the quote description before is \(thequote)")
            
            let testIndex = indexNew - 1
            print("BEFORE test Index = \(testIndex.description)")
            theimage = (self.images[indexNew] as UIImage)
            
          //  theimage = (self.images[testIndex] as UIImage)
            
           /*
            if testIndex < self.images.count {
                theimage = (self.images[indexNew] as UIImage)
            } else {
                theimage = (self.images[testIndex] as UIImage)
            }
*/
            //SWIFT 3 ERROR cannot subscript value of inout array
            PreviousQuote = (self.Quotes[indexPrevious] as NSString)
            PreviousImage = (self.images[indexPrevious] as UIImage)
            
            
            theUser = self.userNames[indexNew]
            self.theUserID = self.Game_Data_ArrayID[indexNew]
            
          //  print("the user = \(theUser)")
            theTurn = self.TurnInfo[indexNew] as NSString
            print("the turn user = \(theTurn)")
            NewLikes = self.LikeArray[indexNew]
            ReplaceAtRowNum = indexNew
            theTurnNumber = self.TurnNumbers[indexNew]
            theNumFails = NumFails[indexNew].description as NSString
            theNumLikes = LikeArray[indexNew].description as NSString
            self.hideBorder = HideArray[indexNew]
            self.ViewFailLBL.text = theNumFails as String
            self.ViewLikesLBL.text = theNumLikes as String
            self.theMediaType = MediaTypeArray[indexNew]
            self.PreviousMediaType = MediaTypeArray[indexPrevious]
            LikePushed = LikedPushedArray[indexNew]
     print("BEFORE - NEW INDEX NEW 1 before = \(indexNew.description)")
            indexNew -= 1
   print("BEFORE - NEW INDEX NEW 2 before = \(indexNew.description)")
       //pageContentViewController.ImageView.image = uploadImage
        //return pageContentViewController
        return self.viewControllerAtIndex(indexNew)
//return pageContentViewController
        } else {
            theimage = (self.images[indexNew] as UIImage)
            theUser = self.userNames[indexNew]
            self.theUserID = self.Game_Data_ArrayID[indexNew]
          //  print("the user = \(theUser)")
            theTurn = self.TurnInfo[indexNew] as NSString
            print("the turn user = \(theTurn)")
            NewLikes = self.LikeArray[indexNew]
            ReplaceAtRowNum = indexNew
            theTurnNumber = self.TurnNumbers[indexNew]
            theNumFails = NumFails[indexNew].description as NSString
            theNumLikes = LikeArray[indexNew].description as NSString
             LikePushed = LikedPushedArray[indexNew]
            self.ViewFailLBL.text = theNumFails as String
            self.ViewLikesLBL.text = theNumLikes as String
            self.theMediaType = MediaTypeArray[indexNew]
            self.PreviousMediaType = "NA"
            self.hideBorder = HideArray[indexNew]
            PreviousQuote = ""
            thepreviousquote = ""
           // PreviousImage = (self.images[indexPrevious] as UIImage)

            
             print("BEFORE - NEW INDEX zero NEW before= \(indexNew.description)")
            
        }
        
        return nil
    
        
    }
    
   /*
        indexNum--
        
    var index = (viewController as! GameCompleteViewController).pageIndex
        let PageNum: Int = index
        print("indexNum: \(indexNum)")
        //println("index is now \(index)")
        
        var uploadImage: UIImage = self.images[index] as UIImage
        
        
    if(index == 0){
    return nil
    }
    index--
        /*
        theimage = self.images[index]
        theUser = self.TurnInfo[index]
        theTurn = self.users[index]
        print("The User = \(theUser)")
        NewLikes = self.LikeArray[index]
        ReplaceAtRowNum = index
   */
        
    return self.viewControllerAtIndex(index)
    
    }

*/
    
    func viewControllerAtIndex(_ index : Int) -> UIViewController? {
       
       
    var indexPrevious = index - 1
        
    if((self.users.count == 0) || (index >= self.users.count)) {
    return nil
        
    }
        
      //  theimage = self.images[index] as UIImage
      
        
        print("CURRENT USER TURN = \(self.TurnInfo[index])")
    print("MEDIA TYPE ARRAY COUNT \(MediaTypeArray.count)")
        
        print("image url array \(imageURLArray.count)")
        
    let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameCompleteViewController") as! GameCompleteViewController
        
       // PageNum = index
        
       // println("pageNum  = \(index)")
    
    pageContentViewController.imageName = self.images[index]
    pageContentViewController.imageURL = self.imageURLArray[index]
    pageContentViewController.imageNSData = self.ImageDataArray[index]
        
    pageContentViewController.QuoteImageName = self.QuoteBox[index]
        
        print("the user is \(users[index])")
    
    pageContentViewController.titleText = self.users[index] as String
    pageContentViewController.QuoteText = self.Quotes[index] as String
        
    if index == 0 {
    pageContentViewController.QuoteTextPrevious = ""
    pageContentViewController.MediaTypePrevious = ""
   // pageContentViewController.AudioClipPrevious = ""
    
    } else {
    pageContentViewController.QuoteTextPrevious = self.Quotes[indexPrevious] as String
        pageContentViewController.MediaTypePrevious = self.MediaTypeArray[indexPrevious]
        pageContentViewController.AudioClipPrevious = self.AudioClips[indexPrevious]
        
    }
    
    pageContentViewController.theImage = self.theimage
    pageContentViewController.theQuote = self.thequote
    pageContentViewController.thePreviousQuote = self.PreviousQuote
        
    pageContentViewController.pageIndex = index
    pageContentViewController.ImageFrame = self.FrameImages[index]
        pageContentViewController.TurnInfo = self.TurnInfo[index] as NSString
        
        pageContentViewController.images = self.images
        
        pageContentViewController.Likes = self.LikeArray[index]
        
       // theimage = pageContentViewController.imageName
        
        pageContentViewController.playHidden = self.PlayHidden[index]
        
        pageContentViewController.stopHidden = self.StopHidden[index]
        
        pageContentViewController.TheAudioClip = self.AudioClips[index]
        
        pageContentViewController.MediaTypeTemp = self.MediaTypeArray[index]
        pageContentViewController.MediaTypeTemp2 = self.theMediaType
        pageContentViewController.GameID = self.GAME_ID
        
        pageContentViewController.TurnNumber = self.TurnNumbers[index]
        pageContentViewController.TurnNumber2 = self.theTurnNumber
        pageContentViewController.Fails = self.NumFails[index]
        pageContentViewController.LikePushed = self.LikedPushedArray[index]
        pageContentViewController.replyUser = String(describing: self.userNames[index]) as NSString
        pageContentViewController.replyUserID = self.Game_Data_ArrayID[index]
        pageContentViewController.hideBorder = self.hideBorder
        pageContentViewController.FirstLoad = self.LoadsArray[index]
        pageContentViewController.numberImageName = self.numberImages[index]!
       
        /*
        theimage = self.images[index]
        theUser = self.TurnInfo[index]
        theTurn = self.users[index]
        NewLikes = self.LikeArray[index]
        ReplaceAtRowNum = index
*/
        print("Replace at Row Num = \(ReplaceAtRowNum)")
        print("CURRENT View Controller at index = \(index.description)")
        
        if GAME_ID == "demo" {
        switch index.description {
        case "4":
            self.uploadBTn.layer.add(pulse, forKey: nil)
        case "5":
            self.commentBTN.layer.add(pulse, forKey: nil)
            self.uploadBTn.layer.removeAllAnimations()
        case "6":
            self.commentBTN.layer.removeAllAnimations()
            self.likeBTN.layer.add(pulse, forKey: nil)
        case "7":
            self.likeBTN.layer.removeAllAnimations()
            self.ViewFailBTN.layer.add(pulse, forKey: nil)
        case "8":
            self.ViewFailBTN.layer.removeAllAnimations()
        case "11":
            self.backBTN.layer.add(pulse, forKey: nil)
        default:
            break
        }
            
        }
        
    return pageContentViewController
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return users.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return 0
    }
    //CHANGE ERROR
    
    
    @IBAction func likeBTN(_ sender: AnyObject) {
      //  var theTurn: NSString = self.pageViewController.viewControllers!.last!.TurnInfo
        //var theUser: NSString = self.pageViewController.viewControllers!.last!.title!
        
        if theUser == username {
            let AC = JSController("Hey that's yours..", MyMessage: "You can't like your own picture or quote",Color: "Red")
            self.present(AC, animated: true, completion: nil)
        } else {
      
        
        print("Turn info = \(theTurn)")
        
        let LikeResult = LikeImage(GameIDInfo,username: username,TurnInfo: theTurn)
        
        if LikeResult {
            
            
            let AC = JSController("Success", MyMessage: "You Liked this Image",Color: "Green")
            self.present(AC, animated: true, completion: nil)
            
            
            
     
            
            //var replaceRow = self.pageViewController.viewControllers.last!.view.tag
            
            var replaceRow = ReplaceAtRowNum
            
           // NewLikes = self.pageViewController.viewControllers!.last!.Likes!
            
            //var templikes: Int!
            
            let templikes: Int = NewLikes
            
            print("Test New, Like replace at Row: \(self.ReplaceAtRowNum)")
            var NumLikes: Int!
            NumLikes = templikes + 1
            
            print("Like replace at Row: \(self.indexNum)")

            //pageContentViewController.Likes = self.LikeArray[ReplaceAtRowNum] + 1
            self.LikeArray.remove(at: self.ReplaceAtRowNum);
            self.LikeArray.insert(NumLikes, at: self.ReplaceAtRowNum)
            
            resetRefresh(ReplaceAtRowNum)
            
            /*
            if let NumLikes = NSNumberFormatter().numberFromString(NewLikes) {
                templikes = NumLikes.integerValue
                
            } else {
                
            }
            
            var testLikes: Int?
            
          testLikes = templikes + 1
*/
            
      //  self.pageViewController.viewControllers.last!.Likes = NumLikes.description.toInt()
           // reset()
            
            
        } else {
            
            let AC = JSController("Like Error", MyMessage: "There was an error Liking this Image, please try again",Color: "Red")
            self.present(AC, animated: true, completion: nil)
            
            }
        }
        
    }
    
    

    //CHANGE ERROR
    
    
    
    @IBAction func shareBTN(_ sender: AnyObject) {
        
        //var theimage: UIImage = self.pageViewController.viewControllers!.last!.
       // theimage = self.pageViewController.childViewControllers.last!.
       // var theimage: UIImage = images[thePageIndex]
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Share With Your Friends", message: "", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let FBAction: UIAlertAction = UIAlertAction(title: "Facebook", style: .default) { action -> Void in
            //Post to Facebook
          //  var controller: AnyObject? = self.pageViewController.viewControllers.last
          
          //  var picNum = Int()
         //  var indexnew = controller?.pageIndex
            
         //   getFBPermission()
            
            
            let newSize = CGSize(width: 700, height: 900)
            UIGraphicsBeginImageContext(newSize)
            
            let frameImage = UIImage(named: "chalkboardFrame2.png")
            
            let ih = self.theimage.size.height
            let iw = self.theimage.size.width
            print("ih = \(ih)")
            print("iw = \(iw)")
            let ivar = iw / ih
            let niw = 600 * ivar
            let StartX = 350 - (niw / 2)
            
            let Rect2 = CGRect(x: 0,y: 0,width: 700,height: 900)
            let picRect = CGRect(x: StartX,y: 90,width: niw,height: 600)
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            
            self.theimage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //    let imageData = UIImagePNGRepresentation(newImage)
            
            
            
            
            
            
         //   let FBImage = self.theimage
            let FBImage = newImage
          //  var FBImage = self.pageViewController.viewControllers!.ui
           // let postresult = shareImageToFaceBook2(FBImage)
            
            
            /* FACEBOOK INFO
            print("FBSDKAccess Token = \(FBSDKAccessToken.currentAccessToken())")
            
            //   if (FBSDKAccessToken.currentAccessToken() != nil)
            //    {
            let photo : FBSDKSharePhoto = FBSDKSharePhoto()
            photo.image = newImage as UIImage
            photo.userGenerated = true
            
            let linkContent : FBSDKShareLinkContent = FBSDKShareLinkContent()
            
            //  let photo : FBSDKSharePhoto = FBSDKSharePhoto()
            linkContent.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)")
            linkContent.contentTitle = "Pics & Quotes"
            linkContent.contentDescription = "Description"
            // photo.userGenerated = true
            
            
            
            let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
            //content.photos = [photo]
            //content.
            //content.
            content.contentURL = NSURL(string: "http://\(ServerInfo.sharedInstance)")
            content.photos = [photo]
           // content.
            let Share : FBSDKShareDialog = FBSDKShareDialog()
            Share.mode = .Native
            Share.fromViewController = self
            Share.shareContent = content
            //Share.delegate = self
            //Share.show()
            
            if (FBSDKAccessToken.currentAccessToken() != nil) {
            
            if !Share.canShow() {
                
            } else {
                Share.show()
            }
            } else {
                
                getFBPermission()
                print("FB Token = \(FBSDKAccessToken.currentAccessToken())")
                print("Getting permission")
                if !Share.canShow() {
                    
                } else {
                    Share.show()
                }
 
                
            }
            
            
          //  Share.showFromViewController(self, withContent: content, delegate: nil)
            
            
          /*
          let postresult = shareImageToFaceBook(FBImage)
            
            if postresult {
                print("Image posted to facebook")
            } else {
                print("error image not posted")
            }
           */
            
           */

            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                
                let FBSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
         
                FBSheet.setInitialText("I'm Playing Pics & Quotes")
                
              //  FBSheet.addURL(NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/GoToApp.php"))
                
                
                FBSheet.add(FBImage)
                
                FBSheet.completionHandler = {
                    result -> Void in
                
                //var fbImage2 = theimage
                let getResult = result as SLComposeViewControllerResult;
                switch(getResult.rawValue){
                case SLComposeViewControllerResult.cancelled.rawValue:
                    print("Cancelled")
                
                case SLComposeViewControllerResult.done.rawValue:
                    print("it's done")
                  print("Adding Points")
                
                    let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "5")
                    //numPoints = FilterUPData(UPurldata)
                    print("number of points after Add = \(numPoints)")
                    
                    let AC = JSController("Tokens & Pixie Points Earned!", MyMessage: "You just earned 5 tokens and 5 Pixie Points.",Color: "Green")
                    self.present(AC, animated: true, completion: nil)
                default:
                    print("error!")
                    
                }
                    self.dismiss(animated: true, completion: nil)
            }
            
                       // FBSheet.
                
                self.present(FBSheet, animated: true, completion: nil)
                
                
            } else {
                
                let alert = UIAlertController(title: "Accounts", message: "Please login to Facebook", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            


        }
        actionSheetController.addAction(FBAction)
        
        let TweetAction: UIAlertAction = UIAlertAction(title: "Twitter", style: .default) { action -> Void in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                
                let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.completionHandler = {
                    result -> Void in
                    
                    //var fbImage2 = theimage
                    let getResult = result as SLComposeViewControllerResult;
                    switch(getResult.rawValue){
                    case SLComposeViewControllerResult.cancelled.rawValue:
                        print("Cancelled")
                    case SLComposeViewControllerResult.done.rawValue:
                        print("it's done")
                        
                        let  numPoints = UPData(self.username, userid: self.userID, type: "add", points: "5", levelpoints: "0")
                        //numPoints = FilterUPData(UPurldata)
                        print("number of points = \(numPoints)")
                        
                        let AC = JSController("Tokens Earned!", MyMessage: "You just earned 5 tokens.",Color: "Green")
                        self.present(AC, animated: true, completion: nil)
                        
                    default:
                        print("error!")
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }
                twitterSheet.setInitialText("I'm Playing Pics & Quotes")
                
                let newSize = CGSize(width: 935, height: 701)
                UIGraphicsBeginImageContext(newSize)
                
                let frameImage = UIImage(named: "chalkboardFrame.png")
                
                let ih = self.theimage.size.height
                let iw = self.theimage.size.width
                
                let ivar = ih / iw
                let niw = 617 * ivar
                
                let Rect2 = CGRect(x: 0,y: 0,width: 935,height: 701)
                let picRect = CGRect(x: 47,y: 84,width: niw,height: 617)
                frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
                self.theimage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
                
                let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                //    let imageData = UIImagePNGRepresentation(newImage)
                
                
                
                
                
                
                //   let FBImage = self.theimage
                let TwitterImage = newImage
                
               // let TwitterImage = self.theimage
                
                twitterSheet.add(TwitterImage)
                
                self.present(twitterSheet, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        }

        actionSheetController.addAction(TweetAction)
        
        let WhatsAppAction: UIAlertAction = UIAlertAction(title: "WhatsApp", style: .default) { action -> Void in
            print("About to open What's App")
            
            let newSize = CGSize(width: 935, height: 701)
            UIGraphicsBeginImageContext(newSize)
            
            let frameImage = UIImage(named: "chalkboardFrame.png")
            
            let ih = self.theimage.size.height
            let iw = self.theimage.size.width
            
            let ivar = ih / iw
            let niw = 617 * ivar
            
            let Rect2 = CGRect(x: 0,y: 0,width: 935,height: 701)
            let picRect = CGRect(x: 47,y: 84,width: niw,height: 617)
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.theimage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            
           let filename = "myimage.wai"
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)[0] as NSString
            let destinationPath = documentsPath.appending("/" + filename)
                
              //  .stringByExpandingTildeInPath
            
            try? UIImagePNGRepresentation(newImage)!.write(to: URL(fileURLWithPath: destinationPath), options: [])
            let fileUrl = URL(fileURLWithPath: destinationPath) as URL
            
            self.documentController = UIDocumentInteractionController(url: fileUrl)
            self.documentController.delegate = self
            self.documentController.uti = "net.whatsapp.image"
            self.documentController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: false)
        }
        
      actionSheetController.addAction(WhatsAppAction)
        
        let InstagramAction: UIAlertAction = UIAlertAction(title: "Instagram", style: .default) { action -> Void in
            print("About to open Instagram")
            let instagramUrl = URL(string: "instagram://app")
            if(UIApplication.shared.canOpenURL(instagramUrl!)){
                let imageData = UIImageJPEGRepresentation(self.theimage, 1.0)
                
                
                let captionString = "I'm playing Pics & Quotes"
                let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("instagram.igo")
                print("Instagram Write Path = \(writePath)")
                if(!((try? imageData!.write(to: writePath, options: [.atomic])) != nil)) {
                    return
                } else {
                    let fileURL = writePath
                    self.documentController = UIDocumentInteractionController(url: fileURL)
                    self.documentController.delegate = self
                    self.documentController.uti = "com.instgram.exclusivegram"
                    self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstgramCaption" as NSCopying)
                    self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
                }
            } else {
                print("Insagram app not available")
            }
            
        }
        actionSheetController.addAction(InstagramAction)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Save to Images", style: .default) { action -> Void in
            
            let newSize = CGSize(width: 935, height: 701)
            UIGraphicsBeginImageContext(newSize)
            
            let frameImage = UIImage(named: "chalkboardFrame.png")
            
            let ih = self.theimage.size.height
            let iw = self.theimage.size.width
            
            let ivar = ih / iw
            let niw = 617 * ivar
            
            let Rect2 = CGRect(x: 0,y: 0,width: 935,height: 701)
            let picRect = CGRect(x: 47,y: 84,width: niw,height: 617)
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.theimage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            //    let imageData = UIImagePNGRepresentation(newImage)
            
            
            
            
            
            
            //   let FBImage = self.theimage
           // let FBImage = newImage
            //save to images
            let library = ALAssetsLibrary()
           // let imageToSave = filter.outputImage
            let orientation = self.theimage.imageOrientation
            let imageData = UIImageJPEGRepresentation(newImage, 1.0)
            let compressedJPGImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)//  library.writeImageToSavedPhotosAlbum(theimage.CGImage, orientation: orientation, completionBlock: nil)
          //  library.writeImageToSavedPhotosAlbum(theimage.CGImage, orientation: orientation, completionBlock: nil)
          //  UIImageWriteToSavedPhotosAlbum(theimage, self, "image.didFinishSavingWithError:contextInfo:", nil)
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Image has been saved to your photo album"
            alertView.backgroundColor = UIColor.lightGrayColor()
            alertView.tintColor = UIColor.darkGrayColor()
            //alertView.
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            */
            print("Should show JSSAlertView")
            
                       //alertview.close()
            let AC = JSController("Success", MyMessage: "The Image has been Saved to your photo album",Color: "Green")
            self.present(AC, animated: true, completion: nil)
            //alertview.show()
        }
        
        actionSheetController.addAction(nextAction)
        
        let SMSAction: UIAlertAction = UIAlertAction(title: "Send As Message", style: .default) { action -> Void in
            
            let newSize = CGSize(width: 935, height: 701)
            UIGraphicsBeginImageContext(newSize)
            
            let frameImage = UIImage(named: "chalkboardFrame.png")
            
            let ih = self.theimage.size.height
            let iw = self.theimage.size.width
            
            let ivar = ih / iw
            let niw = 617 * ivar
            
            let Rect2 = CGRect(x: 0,y: 0,width: 935,height: 701)
            let picRect = CGRect(x: 47,y: 84,width: niw,height: 617)
            frameImage!.draw(in: Rect2, blendMode:CGBlendMode.normal, alpha: 1.0)
            self.theimage.draw(in: picRect, blendMode: CGBlendMode.normal, alpha: 1.0)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            //    let imageData = UIImagePNGRepresentation(newImage)
            
            
            
            
            
            
            //   let FBImage = self.theimage
           // let FBImage = newImage
            
            //save to images
            let library = ALAssetsLibrary()
            // let imageToSave = filter.outputImage
            let orientation = self.theimage.imageOrientation
            let imageData = UIImageJPEGRepresentation(newImage, 1.0)
            let compressedJPGImage = UIImage(data: imageData!)
            
            let messageVC = MFMessageComposeViewController()
            
            
            messageVC.body = "";
           // messageVC.recipients = [""]
            messageVC.messageComposeDelegate = self;
            messageVC.addAttachmentData(imageData!, typeIdentifier: "image/jpeg", filename: "GamePhoto.jpeg")
            
            self.present(messageVC, animated: false, completion: nil)
            //UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)//
            //println("Should show JSSAlertView")
            
            //alertview.close()
            //let AC = JSController("Success", "The Image has been Saved to your photo album","Green")
          //  self.presentViewController(AC, animated: true, completion: nil)
            //alertview.show()
        }
        
        actionSheetController.addAction(SMSAction)
        //var VidAction = UIAlertAction
        
        var VidTitle = NSString()
        
        let tempVideoFile: NSString = self.VideoFile.description as NSString
        
        if tempVideoFile.isEqual(to: "")  {
            VidTitle = "Convert To Video"
        } else {
            VidTitle = "Share as Video"
        }
        
        
        let VidAction: UIAlertAction = UIAlertAction(title: "\(VidTitle)", style: .default) { action -> Void in
            
            
            print("Image Count = \(self.images.count)")
            let Image1 = UIImage(named: "QuoteBoxImage.png")
            let Image2 = UIImage(named: "imageFrame.png")
            
      //   self.writeImagesToMovieAtPath()
       //     createVideoFromImage((Image1?.CGImage)!)
            
            let tempVideoFile: NSString = self.VideoFile.description as NSString
            
            if tempVideoFile.isEqual(to: "")  {
          self.view.addSubview(self.progressHUD)
           
                
                
         self.CreateGameVideo()
            //Image1!, Image2: Image2!)
            print("Creating Video")
            } else {
            self.ShareVideo(self.VideoFile)
            }
            
    //   progressHUD.removeFromSuperview()
            
        }
        
        actionSheetController.addAction(VidAction)
        
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            //save to images
            
        }
        
        actionSheetController.addAction(CancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
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
    
    func FilterGameData(_ urlData: Data) -> [NSString] {
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
      //  print("Json valueJSON: \(json)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "0") {
                let gname = result["GameName"].stringValue
                
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
                
                
                
                
                let gamestyle = result["gamestyle"].stringValue
                
     
                
                
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
                
                useimageURLArray.append(useimageURL1temp as NSString)
                useimageURLArray.append(useimageURL2temp as NSString)
                useimageURLArray.append(useimageURL3temp as NSString)
                useimageURLArray.append(useimageURL4temp as NSString)
                useimageURLArray.append(useimageURL5temp as NSString)
                useimageURLArray.append(useimageURL6temp as NSString)
                useimageURLArray.append(useimageURL7temp as NSString)
                useimageURLArray.append(useimageURL8temp as NSString)
                useimageURLArray.append(useimageURL9temp as NSString)
                useimageURLArray.append(useimageURL10temp as NSString)
                
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
                
                imageURLArray.append(imageURL1temp as NSString)
                imageURLArray.append(imageURL2temp as NSString)
                imageURLArray.append(imageURL3temp as NSString)
                imageURLArray.append(imageURL4temp as NSString)
                imageURLArray.append(imageURL5temp as NSString)
                imageURLArray.append(imageURL6temp as NSString)
                imageURLArray.append(imageURL7temp as NSString)
                imageURLArray.append(imageURL8temp as NSString)
                imageURLArray.append(imageURL9temp as NSString)
                imageURLArray.append(imageURL10temp as NSString)
                imageURLArray.append(imageURL10temp as NSString)
                
                
                //= result["fails"].stringValue
                
                NumFails.append(numfails1!)
                NumFails.append(numfails2!)
                NumFails.append(numfails3!)
                NumFails.append(numfails4!)
                NumFails.append(numfails5!)
                NumFails.append(numfails6!)
                NumFails.append(numfails7!)
                NumFails.append(numfails8!)
                NumFails.append(numfails9!)
                NumFails.append(numfails10!)
                NumFails.append(numfails11!)
                
                //  var isComplete = result["isComplete"].stringValue
              //  var turnNumber = result["TurnNumber"].stringValue
                /*
                switch turnNumber
                {
                case "1":
                    TurnUser = player1
                case "2":
                    TurnUser = player2
                case "3":
                    TurnUser = player3
                case "4":
                    TurnUser = player4
                case "5":
                    TurnUser = player5
                case "6":
                    TurnUser = player6
                case "7":
                    TurnUser = player7
                case "8":
                    TurnUser = player8
                case "9":
                    TurnUser = player9
                case "10":
                    TurnUser = player10
                default:
                    println("Error")
                }
*/
                
                Game_Data_Array.append(gname as NSString)
                Game_Data_Array.append(gameID as NSString)
                Game_Data_Array.append(player1 as NSString)
                Game_Data_Array.append(player2 as NSString)
                Game_Data_Array.append(player3 as NSString)
                Game_Data_Array.append(player4 as NSString)
                Game_Data_Array.append(player5 as NSString)
                Game_Data_Array.append(player6 as NSString)
                Game_Data_Array.append(player7 as NSString)
                Game_Data_Array.append(player8 as NSString)
                Game_Data_Array.append(player9 as NSString)
                Game_Data_Array.append(player10 as NSString)
                Game_Data_Array.append(turn1)
                Game_Data_Array.append(turn2)
                Game_Data_Array.append(turn3)
                Game_Data_Array.append(turn4)
                Game_Data_Array.append(turn5)
                Game_Data_Array.append(turn6)
                Game_Data_Array.append(turn7)
                Game_Data_Array.append(turn8)
                Game_Data_Array.append(turn9)
                Game_Data_Array.append(turn10)
                Game_Data_Array.append(gamestyle as NSString)
                Game_Data_ArrayID.append(player1ID as NSString)
                Game_Data_ArrayID.append(player2ID as NSString)
                Game_Data_ArrayID.append(player3ID as NSString)
                Game_Data_ArrayID.append(player4ID as NSString)
                Game_Data_ArrayID.append(player5ID as NSString)
                Game_Data_ArrayID.append(player6ID as NSString)
                Game_Data_ArrayID.append(player7ID as NSString)
                Game_Data_ArrayID.append(player8ID as NSString)
                Game_Data_ArrayID.append(player9ID as NSString)
                Game_Data_ArrayID.append(player10ID as NSString)
                Game_Data_ArrayID.append("AllUsers")
                /*
                Game_Data_Array.append(like1)
                Game_Data_Array.append(like2)
                Game_Data_Array.append(like3)
                Game_Data_Array.append(like4)
                Game_Data_Array.append(like5)
                Game_Data_Array.append(like6)
                Game_Data_Array.append(like7)
                Game_Data_Array.append(like8)
                Game_Data_Array.append(like9)
                Game_Data_Array.append(like10)
                Game_Data_Array.append(likegame)
*/
                
                LikeArray.append(like1new!)
                LikeArray.append(like2new!)
                LikeArray.append(like3new!)
                LikeArray.append(like4new!)
                LikeArray.append(like5new!)
                LikeArray.append(like6new!)
                LikeArray.append(like7new!)
                LikeArray.append(like8new!)
                LikeArray.append(like9new!)
                LikeArray.append(like10new!)
                LikeArray.append(likegamenew!)
                
                LikedPushedArray.append(LikeBool1)
                LikedPushedArray.append(LikeBool2)
                LikedPushedArray.append(LikeBool3)
                LikedPushedArray.append(LikeBool4)
                LikedPushedArray.append(LikeBool5)
                LikedPushedArray.append(LikeBool6)
                LikedPushedArray.append(LikeBool7)
                LikedPushedArray.append(LikeBool8)
                LikedPushedArray.append(LikeBool9)
                LikedPushedArray.append(LikeBool10)
                LikedPushedArray.append(LikeBoolGame)
               
                
                MediaTypeArray.append(media1 as NSString)
                MediaTypeArray.append(media2 as NSString)
                MediaTypeArray.append(media3 as NSString)
                MediaTypeArray.append(media4 as NSString)
                MediaTypeArray.append(media5 as NSString)
                MediaTypeArray.append(media6 as NSString)
                MediaTypeArray.append(media7 as NSString)
                MediaTypeArray.append(media8 as NSString)
                MediaTypeArray.append(media9 as NSString)
                MediaTypeArray.append(media10 as NSString)
                MediaTypeArray.append("Game Complete")
                
                
              //  print("Media Type Array = \(MediaTypeArray)")
                /*
                gnameArray.append(gname)
                GameIdArray.append(gameID)
                Player1Array.append(player1)
                Player2Array.append(player2)
                Player3Array.append(player3)
                Player4Array.append(player4)
                Player5Array.append(player5)
                Player6Array.append(player6)
                Player7Array.append(player7)
                Player8Array.append(player8)
                Player9Array.append(player9)
                
                Player10Array.append(player10)
                      Turn1Array.append(turn1)
                      Turn2Array.append(turn2)
                      Turn3Array.append(turn3)
                      Turn4Array.append(turn4)
                      Turn5Array.append(turn5)
                      Turn6Array.append(turn6)
                      Turn7Array.append(turn7)
                      Turn8Array.append(turn8)
                      Turn9Array.append(turn9)
                      Turn10Array.append(turn10)
                TurnNumberArray.append(turnNumber)
                IsCompleteArray.append(isComplete)
                UsersTurnArray.append(TurnUser)
*/
            }
            
        }
  
        return Game_Data_Array
        
    }
    
    @IBAction func BackBTN(_ sender: AnyObject) {
        print("back button pressed")
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        if GAME_ID != "demo" {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissVC"), object: nil, userInfo: nil);
        
      //  self.performSegueWithIdentifier("restart", sender: self)
            
        self.dismiss(animated: true, completion: nil)
            
        } else {
            
         let democomplete = prefs.bool(forKey: "VIEWCOMPLETEDDEMOGAME")
            
            
            if democomplete {
            
            
            self.dismiss(animated: true, completion: nil)
                
            } else {
                
                
                DispatchQueue.main.async(execute: {
                    
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Not yet", subTitle: "Almost done, just finish viewing this game and you'll be ready to play.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                })
                
                
            }
        
        
        
        }
      //  self.performSegueWithIdentifier("BackToMyGames", sender: self)
 
       // self.performSegueWithIdentifier("goto_mygames", sender: self)
        
        
    }
      func createPhotoReel2 () {

        print("adding images")
        let image1 = images[0]
        let image2 = images[1]
        let image3 = images[2]
        let image4 = images[3]
        let image5 = images[4]
        let image6 = images[5]
        let image7 = images[6]
        let image8 = images[7]
        let image9 = images[8]
        let image10 = images[9]
        
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
      
        
        if MediaTypeArray[0] == "audio" {
           quote1 = "(Audio Clip, convert to video to share)"
        } else {
         quote1 = Quotes[0]
        }
        
        if MediaTypeArray[1] == "audio" {
            quote2 = "(Audio Clip, convert to video to share)"
        } else {
            quote2 = Quotes[1]
        }

      
        if MediaTypeArray[2] == "audio" {
            quote3 = "(Audio Clip, convert to video to share)"
        } else {
            quote3 = Quotes[2]
        }
        
        if MediaTypeArray[3] == "audio" {
            quote4 = "(Audio Clip, convert to video to share)"
        } else {
            quote4 = Quotes[3]
        }
        
        
       
        if MediaTypeArray[4] == "audio" {
            quote5 = "(Audio Clip, convert to video to share)"
        } else {
            quote5 = Quotes[4]
        }
        
        if MediaTypeArray[5] == "audio" {
            quote6 = "(Audio Clip, convert to video to share)"
        } else {
            quote6 = Quotes[5]
        }
        
        
        if MediaTypeArray[6] == "audio" {
            quote7 = "(Audio Clip, convert to video to share)"
        } else {
            quote7 = Quotes[6]
        }
        
        if MediaTypeArray[7] == "audio" {
            quote8 = "(Audio Clip, convert to video to share)"
        } else {
            quote8 = Quotes[7]
        }
       
        
        if MediaTypeArray[8] == "audio" {
            quote9 = "(Audio Clip, convert to video to share)"
        } else {
            quote9 = Quotes[8]
        }
        
        if MediaTypeArray[9] == "audio" {
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
        let GameLogo = UIImage(named: "PQPhoto2.png")
        
        
        
        
        
        
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
        
        
        let BGColor = getImageWithColor(UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 1.0), size: CGSize(width: DeviceWidth, height: DeviceHeight))
        
        BGColor.draw(in: RectBG, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        var title = "Pics & Quotes"
        
        GameLogo!.draw(in: RectTitle, blendMode:CGBlendMode.normal, alpha: 1.0)
        
        
       // title.drawInRect(RectTitle, withAttributes: textFontAttributesTitle)
        
        if (GameStyleInfo.description != "picture") {
            
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
        
        
        images.append(newImage)
        FullGameImage = newImage
        print("image count = \(images.count)")
        // testImageView.image = newImage
   
    }
    

    func CreateGameVideo() {
        
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
        
        //SET UP TRACK 1
       if MediaTypeArray[0] == "audio" {
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
        
        if MediaTypeArray[0] == "gif" {
          
        let gifURL = URL(string: "\(imageURLArray[0]).gif")
        images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
            
        } else {
        images2.append(images[0])
        
        }
        
        
        }
       // let audioTrack1:AVAssetTrack = aTrack1[0]
        //END SET UP AUDIO TRACK 1
        
       
        if MediaTypeArray[1] == "audio" {
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
            
            
            if MediaTypeArray[1] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[1]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            
            images2.append(images[1])
            }
        }
        
        
        if MediaTypeArray[2] == "audio" {
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
            
            if MediaTypeArray[2] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[2]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            
            images2.append(images[2])
            }
        }
        //SET UP AUDIO TRACK 4
        
        if MediaTypeArray[3] == "audio" {
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
            
            if MediaTypeArray[3] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[3]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            images2.append(images[3])
            }
        }
        
        //SET UP AUDIO TRACK 5
        
        if MediaTypeArray[4] == "audio" {
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
            
            if MediaTypeArray[4] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[4]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            images2.append(images[4])
            }
        }
        
        
        if MediaTypeArray[5] == "audio" {
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
            if MediaTypeArray[5] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[5]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            
    images2.append(images[5])
            }
    TimeLength6 = CMTimeMake(STInt, 1) + TotalTime
    Audio7Time = TimeLength6
    TotalTime = TimeLength6
    TimeLength6 = SlideTime
        }
    
    
        if MediaTypeArray[6] == "audio" {
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
            if MediaTypeArray[6] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[6]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            images2.append(images[6])
        }
    }
    
        if MediaTypeArray[7] == "audio" {
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
            
            if MediaTypeArray[7] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[7]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            
    images2.append(images[7])
            }
    }
    
        if MediaTypeArray[8] == "audio" {
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
            if MediaTypeArray[8] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[8]).gif")
                images2.append(UIImage.animatedImage(withAnimatedGIFURL: gifURL))
                
            } else {
            
     images2.append(images[8])
            }
    }
    
    
        if MediaTypeArray[9] == "audio" {
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
            if MediaTypeArray[9] == "gif" {
                
                let gifURL = URL(string: "\(imageURLArray[9]).gif")
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
        if MediaTypeArray[5] == "gif" {
            
            print("Turn 6 is a Gif")
            
        //var ImageLayer6AV = AVPlayerLayer
            
        let gifURL = URL(string: "\(imageURLArray[5]).gif")
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
    
    
    func exportDidFinish(_ session: AVAssetExportSession) {
        switch (session.status) {
        case AVAssetExportSessionStatus.completed :
            let outputURL = session.outputURL
            
            
        
        self.progressHUD.removeFromSuperview()
            
            VideoFile = outputURL!
            ShareVideo(outputURL!)

        //}
        case AVAssetExportSessionStatus.exporting:
            print("Exporting")
        case AVAssetExportSessionStatus.failed:
            self.progressHUD.removeFromSuperview()

            
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
    
  
    func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0,y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
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
        
        self.prefs.set(true, forKey: "DidShowHowTo_GameComplete")
        
        
    }
    
    @IBAction func ViewHowTo(_ sender: AnyObject) {
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        if !ViewHowTo {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.View1TOP.constant = middleY
                
                self.ViewHolder.center.y = self.ViewHolder.center.y - 1000
                
                self.ViewHolderTOP.constant = 0
                //self.ViewShowing = true
                // ShowingInfo = true
                
                // self.ViewTransTOP.constant = 0
            })
            
            ViewHowTo = true
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ShowComments" {
            if let destination = segue.destination as? CommentsViewController {

                destination.GameID = GAME_ID
                destination.ReplyUserID = userID
                destination.ReplyUser = username
                //
            }
        }
        
        if segue.identifier == "SocialMedia" {
            if let destination = segue.destination as? SocialViewController {
                
                destination.view.backgroundColor = UIColor.clear
                destination.gameid = GAME_ID
               
                //
            }
        }
        
        if segue.identifier == "BackToMyGames" {
            
            let controller = segue.destination as! GameViewController
            controller.IsUnwinding = true
        }

        
    }
    @IBAction func TestShare(_ sender: AnyObject) {
        
        // SShare = SocialShare(text: "Creating Video, Please Wait...")
         //  self.view.addSubview(SShare)
       // self.SShare.hidden = false
//self.performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
        //  progressHUD.removeFromSuperview()
    }
    func closeView(_ sender: UIButton!) {
        
    //self.SShare.removeFromSuperview()
    self.SShare.isHidden = true
    }
    
    
    @IBAction func failedBTN(_ sender: AnyObject) {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Fail", message: "What were they thinking?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Fail", style: .default) { action -> Void in
            
          
            //SaveLikeFailData(self.gameid, username: self.username, turn: self.turnnumber, type: "fail", replyuser: self.replyuser)
            
            
        }
        //ERROR
        /*
        var subView = actionSheetController.view.subviews.first as! UIView
        var contentView = subView.subviews.first as! UIView
        var contentView2 = subView.subviews.last as! UIView
        
        contentView.backgroundColor = UIColor(red: 0.249, green: 0.549, blue: 0.674, alpha: 0.5)
        contentView.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        // contentView.
        contentView2.tintColor = UIColor(red: 0.572, green: 0.882, blue: 0.949, alpha: 1.0)
        */
        
        
        actionSheetController.addAction(nextAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func ViewFail(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Fail") as! FailViewController
        
        savingsInformationViewController.faildelegate = self
        savingsInformationViewController.gameid = self.GAME_ID
     //   savingsInformationViewController.turnnumber = self.theTurnNumber
        
        savingsInformationViewController.replyuser  = self.theUser
        
        savingsInformationViewController.turnnumber  = self.theTurn
        
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
        savingsInformationViewController.gameid = self.GAME_ID
        
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
    
    @IBAction func ViewLikes(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "Like") as! LikesViewController
        
        savingsInformationViewController.likedelegate = self
        savingsInformationViewController.gameid = self.GAME_ID
      //  savingsInformationViewController.turnnumber = self.theTurnNumber
        
        savingsInformationViewController.replyuser  = self.theUser
        
        savingsInformationViewController.turnnumber  = self.theTurn
        
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
    
    
    func startGifWithURL(_ url: URL, layer: CALayer) {
        
       // let url = NSURL(string: TheImageURL2 as String)
        //let data = NSData(contentsOfURL: url)
        //let animation =  animationForGifWithURL(url)
      //  let animation = animatedImageWithAnimatedGIFURL(url)
        
       // let animation = animated
        //layer.addAnimation(animation, forKey: "contents")
        //var gifImage = UIImage()
        //gifImage = UIImage.an
        //layer.contents = gifImage
    }
    /*
    
    func animationForGifWithURL(url: NSURL) -> CAKeyframeAnimation {
        var animation = CAKeyframeAnimation()
        animation.keyPath = "contents"
        
        var frames = NSMutableArray()
        var delayTimes = NSMutableArray()
        
        var totalTime: CGFloat = 0.0
        var gifWidth = CGFloat()
        var gifHeight = CGFloat()
        
      //  var gifSource = CGImage
     //   var gifSource = CGImageSourceCreateWithURL(url, nil)
        
     //   var frameCount: size_t = CGImage
        
        
        
        
        return animation
    }
    */
    
    
    func ShowGameAsViewed(_ GameIDNum: NSString) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "CompletedGames", in: managedContext)
        
        let game = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        game.setValue(GameIDNum, forKey: "id")
        
        print("Show Game with ID: \(GameIDNum)  as VIEWED")
        
        var error: NSError?
        
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
        /*
        Friends.append(person)
        CurNum = NumFriends.count
        CurNum++
        NumFriends.append(CurNum)
        */
    }
    
    
    
}


extension PageIntroViewController {
    //}: FBFriendsViewControllerDelegate {
    func FailViewControllerFinished(_ failviewController: FailViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        /*
        let replaceRow = 2
        var EmailInfo = [NSString]()
        */
        //let item : String = EmailInfo[replaceRow] as String;
        
        let item = failviewController.TotalFails
        print("replacing item in fail array , adding \(item)")
        NumFails.remove(at: ReplaceAtRowNum);
       
        NumFails.insert(item, at: ReplaceAtRowNum)

        
        
        
    }
}
extension PageIntroViewController {
    //}: FBFriendsViewControllerDelegate {
    func LikesViewControllerFinished(_ likesviewController: LikesViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
     
        let item  = likesviewController.TotalLikes
        print("replacing item in like array , adding \(item)")
       // let item2  = likesviewController.LikedPUshed
        NumFails.remove(at: ReplaceAtRowNum);
        
        NumFails.insert(item, at: ReplaceAtRowNum)
        
      //  LikedPushedArray.removeAtIndex(ReplaceAtRowNum);
        
      //  LikedPushedArray.insert(item2, atIndex: ReplaceAtRowNum)
    }
}

extension PageIntroViewController {
    //}: FBFriendsViewControllerDelegate {
    func SocialViewControllerFinished(_ socialviewController: SocialViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        //self.FBFriendName = fbfriendsviewController.FBFriendName
        
        self.CanCreateVideo = socialviewController.CanCreateVideo
        
        if self.CanCreateVideo  {
           
            
            _ = NSString()
            
print("VIdeo File Desc: \(self.VideoFile)")
            var tempVideoFile: NSString?
            if VideoFile == nil {
                tempVideoFile = ""
            } else {
                tempVideoFile = VideoFile.description as NSString?
            }
            
            
            
            
                if (tempVideoFile?.isEqual(to: ""))!  {
                    self.view.addSubview(self.progressHUD)
                    
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
}
