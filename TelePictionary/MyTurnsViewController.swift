//
//  MyTurnsViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/12/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class MyTurnsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
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
    
    
    
    var ViewStatusArray = [NSString]()
    var MediaTypeArray = [NSString]()
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
    var AudioClips = [Data]()
    var AudioStringArray = [String]()
    var Photos = [UIImage]()
    var NumFails = [NSString]()
    
    var PhotoST = [PhotoInfo]()
    var TurnStruc = [TurnSearchInfo]()
    var ViewHowTo = Bool()
    
    
     @IBOutlet weak var menuButton: UIBarButtonItem!
    
  
    
    override func viewDidLoad() {
        
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
        self.refreshControl.addTarget(self, action: #selector(MyTurnsViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        self.title = "My Turns"
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //  collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        
        if prefs.value(forKey: "PLAYERID") != nil {
            
            playerID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            playerID = ""
        }

        
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
    
    @objc func RefreshCommentData(_ sender:AnyObject) {
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
            
            DispatchQueue.main.async(execute: {
                
               // self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
                
                self.TurnStruc = self.FilterTurnData(self.LFURLData)
                
                
                print("Photos count REFRESH = \(self.Photos.count)")
                DispatchQueue.main.async(execute: {
                    
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
      //  })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        
       // self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        if !ISLOGGEDIN {
            
            
            let fromWhere: NSString = prefs.object(forKey: "LOGINSENTFROM") as! NSString
            if fromWhere.isEqual(to: "MYTURNS") {
                
                
                //   let fromView = tabBarController?.selectedViewController?.view
                // let toView = tabBarController?.viewControllers![2] as! UINavigationController
                //  let toView = tabBarController?.viewControllers![2] as! GalleryViewController
                
                prefs.set("NONE", forKey: "LOGINSENTFROM")
                
               // tabBarController?.selectedIndex = 2
                
                //  UIView.transitionFromView(fromView!, toView: toView, duration: 0.325, options: UIView.AnimationOptions.CurveEaseInOut, completion: nil)
                
                
            } else {
            
         self.performSegue(withIdentifier: "login", sender: self)
            
                
            }
            /*

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
            */
            
            
        } else {

        
        
        ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        
        let DeviceH = self.view.frame.height
        let middleScreenY = DeviceH / 2
        let middleY = middleScreenY - 200
        
        let AlreadySeenHowTo = prefs.bool(forKey: "DidShowHowTo_MyTurns")
        
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
            
        //LFURLData = GetUserTurnData(self.playerID)
        LFURLData = GetUserTurnData(self.playerID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
                + 50))
        print("RECEIVED THE NSDATA FOR THE TURNS")
        
        self.NumTurnsLoaded = self.NumTurnsLoaded + 50
            
        
        DispatchQueue.main.async(execute: {
            
          //  self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            print("FILTERING TURN DATA NOW")
            self.TurnStruc = self.FilterTurnData(self.LFURLData)
            
            
           // print("Photos count = \(self.Photos.count)")
            DispatchQueue.main.async(execute: {
                
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
                
            })
            
            
            
            DispatchQueue.main.async(execute: {
            
             
                if !AlreadySeenHowTo {
                    
                    UIView.animate(withDuration: 1.0, animations: { () -> Void in
                        
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

                
            })
            
        })
                
      }
            
     AlreadyLoadedView = true
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
    
    @objc func PlayAudioClicked(_ sender: UIButton!) {
        
        
        let RowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        let MyTurnData = TurnStruc[RowSelected]
    
        let audioURLString = MyTurnData.URL
        // var audioURLString = self.AudioStringArray[RowSelected] as String
        //var AudioData = self.AudioClips[RowSelected] as NSData
        //    dispatch_async(dispatch_get_main_queue(),{
        //            let audioURL = NSURL(fileURLWithPath: audioURLString)

        let audioURL = URL(string:audioURLString)
    
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

    @objc func TurnViewStatusClickedMe(_ sender: UIButton!) {
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
    
    @objc func TurnViewStatusClickedBestFriends(_ sender: UIButton!) {
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
    @objc func TurnViewStatusClickedFriends(_ sender: UIButton!) {
        
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

    @objc func TurnViewStatusClickedPublic(_ sender: UIButton!) {
        
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
        let viewstatusTEMP = MyTurnData.viewstatus
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
        
        let MyTurnData = TurnStruc[(indexPath as NSIndexPath).row]

        
        
        //var string = PhotoID[indexPath.row] as String
        
        let string = MyTurnData.gameturnid
            
            //PhotoID[indexPath.row] as String
        
        // var word = "Apple"
        // var string = "Hello Swift"
        if let range = string.range(of: "Turn") {
            let firstPart = string[string.startIndex..<range.lowerBound]
            print(firstPart) // print Hello
            let lastPart = string[range.lowerBound..<string.endIndex]
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
            
            //   let CTF: Character = "n"
            
            //   if let index = find(string, CTF) {
            
            //    NewTurnNumber = string.substringFromIndex(advance(firstPart, 1))
            //     print("new Turn Number = \(NewTurnNumber)")
            //  }
        }
        /*
        theAudioData = AudioClips[indexPath.row]
        MainImage = Photos[indexPath.row]
        MediaType = MediaTypeArray[indexPath.row]
        TurnInfo = PhotoID[indexPath.row]
        */
        
       // theAudioData = MyTurnData.theImage
        MainImage = MyTurnData.theImage
        theAudioDataURL = MyTurnData.URL
        MainImageURL = MyTurnData.URL
        MediaType = MyTurnData.mediatype as NSString
        TurnInfo = MyTurnData.gameturnid as NSString
        
        self.performSegue(withIdentifier: "showImage", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return TurnStruc.count
//        return Photos.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LikeFailPhotoCell
        //2
        
        
        let MyTurnData = TurnStruc[(indexPath as NSIndexPath).row]
        
        cell.TurnImage?.layer.cornerRadius = 5
        cell.TurnImage?.layer.masksToBounds = true
        cell.playBTN?.addTarget(self, action: #selector(MyTurnsViewController.PlayAudioClicked(_:)), for: .touchUpInside)
        cell.playBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.meBTN?.addTarget(self, action: #selector(MyTurnsViewController.TurnViewStatusClickedMe(_:)), for: .touchUpInside)
        cell.meBTN?.tag = (indexPath as NSIndexPath).row
        cell.friendsBTN?.addTarget(self, action: #selector(MyTurnsViewController.TurnViewStatusClickedFriends(_:)), for: .touchUpInside)
        cell.friendsBTN?.tag = (indexPath as NSIndexPath).row
        cell.publicBTN?.addTarget(self, action: #selector(MyTurnsViewController.TurnViewStatusClickedPublic(_:)), for: .touchUpInside)
        cell.publicBTN?.tag = (indexPath as NSIndexPath).row
        cell.bestfriendsBTN?.addTarget(self, action: #selector(MyTurnsViewController.TurnViewStatusClickedBestFriends(_:)), for: .touchUpInside)
        cell.bestfriendsBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.playBTN?.isHidden = false
        
        // cell.myLabel.text = self.items[indexPath.item]
        if MyTurnData.mediatype == "audio" {
            
            
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = false
            
            
        } else {
        
       // if MyTurnData.mediatype == "image" {
            
          // cell.TurnImage?.image = MyTurnData.theImage as UIImage
           // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            
            let request: URLRequest = URLRequest(url: URL(string: MyTurnData.URL)!)
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
                            
                            if MyTurnData.mediatype == "gif" {
                                cell.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                            } else {
                            
                            cell.TurnImage?.image = image
                                
                            }
                            //let GIFData = NSData
                            
                            // cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                            //cellToUpdate.TurnImage?.image = image
                        }
                    })
                }
                else {
                    cell.TurnImage?.image = MyTurnData.theImage as UIImage
                    
                    print("Error: \(error!.localizedDescription)")
                }
            })
            
            
            /*
            if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: MyTurnData.URL)) {
                // print("image Data = \(data)")
                //make sure your image in this url does exist, otherwise unwrap in a if let check
                cell.TurnImage?.image = UIImage(data: data)!
            } else {
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            }
            */
            
           cell.CellLBL?.text = MyTurnData.gamename as String
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
        
        
        if segue.identifier == "login" {
            if let destination = segue.destination as? LoginViewController {
                destination.FromMyTurns = true
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
                        self.NumFails.append(gamenametemp as NSString)
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
                        self.NumFails.append(gamenametemp as NSString)
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
                        self.NumFails.append(gamenametemp as NSString)
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
                        self.NumFails.append(gamenametemp as NSString)
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
    
    
    func FilterTurnData(_ urlData: Data) -> [TurnSearchInfo] {
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
    
    
    func LoadNextFive(_ CurrentTurnsLoaded: Int) {
        //var NewTurnsLoaded = CurrentTurnsLoaded
        let StartNumber = CurrentTurnsLoaded
        let EndNumber = CurrentTurnsLoaded + 50
        
        print("Getting Data for turns \(StartNumber) through \(EndNumber)")
        
        LFURLData = GetUserTurnData(self.playerID, StartNum: StartNumber, EndNum: EndNumber)
        print("RECEIVED THE NEXT FIVE TURNS")
        
        DispatchQueue.main.async(execute: {
            
            //self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            print("FILTERING THE NEXT FIVE TURNS NOW")
            
            self.TurnStruc = self.FilterTurnData(self.LFURLData)
            
            
          //  print("Photos count = \(self.Photos.count)")
            
            
            DispatchQueue.main.async(execute: {
                
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
                //self.actInd.stopAnimating()
                
                self.NumTurnsLoaded = EndNumber
                print("New Number set for NumTurnsLoaded: \(self.NumTurnsLoaded)!!!!!!!!!!!!!!!")
                
            })
            
        })
        
        
    }
    
    
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
            
            self.LoadNextFive(self.NumTurnsLoaded)
          
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
