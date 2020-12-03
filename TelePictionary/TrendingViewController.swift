//
//  TrendingViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/26/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class TrendingViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var PhotoIndex = Int()
    var TurnInfo = NSString()
    
    var FollowingData = Data()
    var FollowingStruc = [TurnSearchInfoFollow]()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var menuButtonRight: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView?
    
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var username = NSString()
    var userID = NSString()
    
    var ViewStatusArray = [NSString]()
    var MediaTypeArray = [NSString]()
    var MediaType = NSString()
    var NewTurnNumber = String()
    var MainImage = UIImage()
    
    var IsMyTurns = Bool()
    var PlayerMain: AVAudioPlayer!
    // var PlayerMain: AVPlayer!
    var theAudioData = Data()
    var theAudioDataURL = String()
    var MainImageURL = String()
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    
    let threshold: CGFloat = 100.0
    let Topthreshold: CGFloat = 0.0
    var isLoadingMore = Bool()
    var isRefreshing = Bool()
    var TableYPos = CGFloat()
    
    var refreshControl:UIRefreshControl!
    
    let prefs:UserDefaults = UserDefaults.standard
    
     fileprivate let reuseIdentifier = "LikeFailViewCell"
    
    let boomBox = UIImage(named: "BoomBox1.png")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(TrendingViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        self.title = "Following"
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.2352, green: 0.62745, blue: 0.8196, alpha: 1.0)
        
        if let font = UIFont(name: "DK Cool Crayon", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            menuButtonRight.target = self.revealViewController()  //revealViewController()
            menuButtonRight.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        if prefs.value(forKey: "PLAYERID") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            username = "guest"
            userID = "guest"
        }
        
        //  collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let ISLOGGEDIN = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
        print("View will appear - is logged in = \(ISLOGGEDIN)")
        
        
        // self.IsGameCenter = NSUserDefaults.standardUserDefaults().boolForKey("GameCenterEnabled")
        if !ISLOGGEDIN {
            
            
            let fromWhere: NSString = prefs.object(forKey: "LOGINSENTFROM") as! NSString
            if fromWhere.isEqual(to: "FOLLOWINGPEOPLE") {
                
                
                //   let fromView = tabBarController?.selectedViewController?.view
                // let toView = tabBarController?.viewControllers![2] as! UINavigationController
                //  let toView = tabBarController?.viewControllers![2] as! GalleryViewController
                
                prefs.set("NONE", forKey: "LOGINSENTFROM")
                
                // tabBarController?.selectedIndex = 2
                
                //  UIView.transitionFromView(fromView!, toView: toView, duration: 0.325, options: UIView.AnimationOptions.CurveEaseInOut, completion: nil)
                
                
            } else {
                
                self.performSegue(withIdentifier: "login", sender: self)
                
                
            }
            
            
            
        } else {
            
            
            
            if prefs.value(forKey: "USERNAME") != nil {
                
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
            } else  {
                username = "guest"
                userID = "guest"
            }
            
            
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
            
            ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
            
            let DeviceH = self.view.frame.height
            let middleScreenY = DeviceH / 2
            let middleY = middleScreenY - 200
            
            let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_MyTurns")

*/
            
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
            
          //  if !AlreadyLoadedView {
                
                //LFURLData = GetUserTurnData(self.playerID)
            
            
              //  FollowingData = GetUserFollowingTurnData(self.userID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded + 50))
            
            
            if Reachability.isConnectedToNetwork() {
                
              
          
            
            FollowingData = GetUserFollowingTurnData(self.userID, StartNum: self.NumTurnsLoaded, EndNum: 50)
            
                
                self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                print("RECEIVED THE NSDATA FOR THE \(self.NumTurnsLoaded) TURNS")
                
                DispatchQueue.main.async(execute: {
                    
                    //  self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
                    print("FILTERING TURN DATA NOW")
                    self.FollowingStruc = self.FilterFollowingData(self.FollowingData)
                    
                    
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
                    
                    
                    /*
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        
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
                        
                        
                    })
                    
                    */
                    
                })
                
            }
                
            else
                
            {
                
                
                
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
                
            }

            
          //  }
            
           // AlreadyLoadedView = true
        }
        
    }
    
    func RemoveAllFromArray(){
        
        self.FollowingStruc.removeAll()
    
    }
    
    @objc func RefreshCommentData(_ sender:AnyObject) {
        print("removing array data")
        //Photos.removeAll()
        //LCountArray.removeAll()
        self.RemoveAllFromArray()
        
        print("adding array data")
        
        // dispatch_async(dispatch_get_main_queue(),{
        
        self.NumTurnsLoaded = 0
        
        //FollowingData = GetUserFollowingTurnData(self.userID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded + 50))
        
        FollowingData = GetUserFollowingTurnData(self.userID, StartNum: self.NumTurnsLoaded, EndNum: 50)
        
        self.NumTurnsLoaded = self.NumTurnsLoaded + 50
        
        DispatchQueue.main.async(execute: {
            
            // self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            
            self.FollowingStruc = self.FilterFollowingData(self.FollowingData)
            
            
           // print("Photos count REFRESH = \(self.Photos.count)")
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return FollowingStruc.count
        //        return Photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let HalfDeviceW = self.view.frame.width / 2
        let Width = HalfDeviceW - 10
        let Height = Width + 20
        
        return CGSize(width: Width, height: Height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let MyTurnData = FollowingStruc[(indexPath as NSIndexPath).row]
        PhotoIndex = (indexPath as NSIndexPath).row
       
        
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
    
    @objc func PlayAudioClicked(_ sender: UIButton!) {
        
        
        let RowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")
        let MyTurnData = FollowingStruc[RowSelected]
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LikeFailPhotoCell
        //2
        
        
        let MyTurnData = FollowingStruc[(indexPath as NSIndexPath).row]
        
        cell.TurnImage?.layer.cornerRadius = 5
        cell.TurnImage?.layer.masksToBounds = true
        cell.playBTN?.addTarget(self, action: #selector(TrendingViewController.PlayAudioClicked(_:)), for: .touchUpInside)
        cell.playBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.meBTN?.addTarget(self, action: "TurnViewStatusClickedMe:", for: .touchUpInside)
        cell.meBTN?.tag = (indexPath as NSIndexPath).row
        cell.friendsBTN?.addTarget(self, action: "TurnViewStatusClickedFriends:", for: .touchUpInside)
        cell.friendsBTN?.tag = (indexPath as NSIndexPath).row
        cell.publicBTN?.addTarget(self, action: "TurnViewStatusClickedPublic:", for: .touchUpInside)
        cell.publicBTN?.tag = (indexPath as NSIndexPath).row
        cell.bestfriendsBTN?.addTarget(self, action: "TurnViewStatusClickedBestFriends:", for: .touchUpInside)
        cell.bestfriendsBTN?.tag = (indexPath as NSIndexPath).row
        
        cell.playBTN?.isHidden = false
        
        // cell.myLabel.text = self.items[indexPath.item]
        if MyTurnData.mediatype == "audio" {
            
            
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            //cell.CellLBL?.text = MyTurnData.gamename as String
            cell.playBTN?.isHidden = false
            
            
        } else {
            
            // if MyTurnData.mediatype == "image" {
            
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            // cell.TurnImage?.image = MyTurnData.theImage as UIImage
            
            
            
            
            if MyTurnData.canView {
            
            
            let request: URLRequest = URLRequest(url: URL(string: MyTurnData.URL)!)
            let mainQueue = OperationQueue.main
            
            
            if MyTurnData.mediatype == "gif" {
                //  let request: NSURLRequest = NSURLRequest(URL: NSURL(string: "\(MyTurnData.turnURL)\(mediaSuf)")!)
                //  let mainQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                    if error == nil {
                        // Convert the downloaded data in to a UIImage object
                        let image = UIImage(data: data!)
                        // Store the image in to our cache
                        //  self.imageCache[urlString] = image
                        // Update the cell
                        
                        if !fileExists(URL(string: MyTurnData.URL)!) {
                            print("file DOES NOT exists - \(MyTurnData.URL))")
                            cell.TurnImage?.image = UIImage(named: "noImage.png")
                            
                        } else {
                            // print("file exists - \(MyTurnData.turnURL)\(mediaSuf)")
                            DispatchQueue.main.async(execute: {
                                if let cellToUpdate = collectionView.cellForItem(at: indexPath) {
                                //if let cellToUpdate = TableView.cel
                               // if let cellToUpdate = self.TableView.cellForRowAtIndexPath(indexPath) {
                                    
                                    if MyTurnData.mediatype == "gif" {
                                        //  cell.blurCoverIMG?.hidden = false
                                        //  let randomBox = Int(arc4random_uniform(UInt32(self.BlurryImages.count)))
                                        //  var tempBlurImage = self.BlurryImages[randomBox]
                                        
                                        //  cell.blurCoverIMG?.image = tempBlurImage
                                        
                                        cell.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                                        // cell.Turn1ImageBack?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
                                        // cell.Turn1ImageBack?.hidden = true
                                        cell.TurnImage?.isHidden = false
                                        
                                    } else if MyTurnData.mediatype == "image" {
                                        cell.TurnImage?.image = image
                                        cell.TurnImage?.isHidden = false
                                        
                                    } else if MyTurnData.mediatype == "quote" {
                                        cell.TurnImage?.image = image
                                        cell.TurnImage?.isHidden = false
                                        
                                        
                                    } else {
                                        
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
                        cell.TurnImage?.image = UIImage(named: "noImage.png")
                        print("Error: \(error!.localizedDescription)")
                    }
                })
                
            } else if MyTurnData.mediatype == "audio"  {
              
                print("audio URL = \(MyTurnData.URL)")
                
                var tempI = self.boomBox!
                
                cell.TurnImage?.image = tempI
                //let URL = Foundation.URL(string: MyTurnData.URL)!
                //cell.TurnImage?.h .hnk_setImage(from: URL)
                cell.TurnImage?.contentMode = UIView.ContentMode.scaleAspectFit
                
            } else  {
                
                print("jpg  URL = \(MyTurnData.URL)")
                
               // var tempI = UIImage(named: "noImage.png")!
                
                //cell.TurnImage?.image = tempI
                
                let URL = Foundation.URL(string: MyTurnData.URL)!
                cell.TurnImage?.hnk_setImage(from: URL)
                cell.TurnImage?.contentMode = UIView.ContentMode.scaleAspectFit
                
            }
            
            /*
                 
                 else {
                print("else URL = \(MyTurnData.URL)")
                
                //var tempI = UIImage(named: "noImage.png")!
                
                
                let URL = Foundation.URL(string: MyTurnData.URL)!
                //cell.TurnImage?.hnk_setImage
                cell.TurnImage?.hnk_setImage(from: URL)
                cell.TurnImage?.contentMode = UIView.ContentMode.scaleAspectFit
                
            }
 
 */
            
            } else {
                
                cell.TurnImage?.image = UIImage(named: "blurry3.png")
                cell.TurnImage?.contentMode = UIView.ContentMode.scaleAspectFit
            }
        
            
            /*
            
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) {
                            
                            // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                            
                            if MyTurnData.mediatype == "gif" {
                                cell.TurnImage?.image = UIImage.animatedImageWithAnimatedGIFData(data!)
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
            
            */
            
            
            /*
            if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: MyTurnData.URL)) {
            // print("image Data = \(data)")
            //make sure your image in this url does exist, otherwise unwrap in a if let check
            cell.TurnImage?.image = UIImage(data: data)!
            } else {
            cell.TurnImage?.image = MyTurnData.theImage as UIImage
            }
            */
            
            cell.CellLBL?.text = MyTurnData.playername as String
            cell.playBTN?.isHidden = true
            
            
        }
        
        
        cell.CellLBL?.text = MyTurnData.playername as String
        
        
        
        cell.bgView.layer.cornerRadius = 5
       // cell.bgView.layer.borderWidth = 2
      //  cell.bgView.layer.borderColor = UIColor.whiteColor().CGColor
        cell.bgView.clipsToBounds = true
        cell.bgView.layer.masksToBounds = true
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
    
    
    func FilterFollowingData(_ urlData: Data) -> [TurnSearchInfoFollow] {
        /*
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        */
        //self.RemoveAllFromArray()
        
        var TurnStrucTemp = [TurnSearchInfoFollow]()
        
        
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
                
                let playernametemp = result["playername"].stringValue
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
                  //  Photos.append(tempImage)
                } else if mediatype_temp == "gif" {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).gif"
                    tempImage = UIImage(named: "noImage.png")!
                   // Photos.append(tempImage)
                    
                } else {
                    
                    imgStringTemp = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(photo_ID).jpg"
                    tempImage = UIImage(named: "noImage.png")!
                    //Photos.append(tempImage)
                    
                }
                
                var canView = Bool()
                
                let canViewtemp = result["canView"].stringValue
                
                if canViewtemp == "yes" {
                    canView = true
                } else {
                    canView = false
                }
                
                
                TurnStrucTemp.append(TurnSearchInfoFollow(gameturnid: photo_ID, mediatype: mediatype_temp, gamename: gamenametemp, viewstatus: viewstatustemp, gameid: gameidtemp, theImage: tempImage, URL: imgStringTemp, canView: canView, playername: playernametemp))
            }
            
        }
        
        //  print("PhotoData Struct = \(TurnStrucTemp)")
        // print("Photos Count = \(Photos.count)")
        return TurnStrucTemp
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showImageOld" {
            
            
            if let destination = segue.destination as? CollectionImageViewController {
                
                destination.MediaType = self.MediaType as String
                destination.MainImage = self.MainImage
                destination.MainImageURL = self.MainImageURL
                //destination.ShowB2 = true
                destination.NewTurnNumber = self.NewTurnNumber
                destination.AudioData = self.theAudioData
                destination.AudioDataURL = self.theAudioDataURL
                
                destination.IsMyTurns = false
                destination.TurnInfo = self.TurnInfo
                //  destination.playerID = self.replyUserID
                print("Profile show segue")
            }
        }
        
        if segue.identifier == "showImage" {
            
            
            if let destination = segue.destination as? TurnPageLoadViewController {
                
                destination.FollowTurnIDArray = self.FollowingStruc
               // destination.MediaTypeArray = self.MediaTypeArray
                destination.PhotoIndex = self.PhotoIndex
                
                /*
                destination.MediaType = self.MediaType as String
                destination.MainImage = self.MainImage
                destination.MainImageURL = self.MainImageURL
                //destination.ShowB2 = true
                destination.NewTurnNumber = self.NewTurnNumber
                destination.AudioData = self.theAudioData
                destination.AudioDataURL = self.theAudioDataURL
                
                destination.IsMyTurns = false
                destination.TurnInfo = self.TurnInfo
                
                */
                //  destination.playerID = self.replyUserID
                print("Profile show segue")
            }
        }

        
        
        if segue.identifier == "login" {
            if let destination = segue.destination as? LoginViewController {
                destination.FromFollowingTurns = true
            }
        }
        
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
    
    func LoadNextFive(_ CurrentTurnsLoaded: Int) {
        //var NewTurnsLoaded = CurrentTurnsLoaded
        let StartNumber = CurrentTurnsLoaded
        let EndNumber = CurrentTurnsLoaded + 50
        
        print("Getting Data for turns \(StartNumber) through \(EndNumber)")
        
        FollowingData = GetUserFollowingTurnData(self.userID, StartNum: StartNumber, EndNum: 50) // EndNumber)
        
        
        print("RECEIVED THE NEXT FIVE TURNS")
        
        DispatchQueue.main.async(execute: {
            
            //self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            print("FILTERING THE NEXT FIVE TURNS NOW")
            
            self.FollowingStruc = self.FilterFollowingData(self.FollowingData)
            
            
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
