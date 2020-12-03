//
//  LIkeFailCollectionViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/7/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class LIkeFailCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var AlreadyLoadedView = Bool()
    var LastPartInfo = NSString()
    var TheGameID = NSString()
    
    @IBOutlet weak var noContentLBL: UILabel!
    var IsGameCenter = Bool()
    var MyTotalTurns = Int()
    var NumTurnsLoaded = Int()
    
    var PlayerMain: AVAudioPlayer!
   // var PlayerMain: AVPlayer!
    var theAudioData = Data()
    var theAudioDataURL = String()
    var MainImageURL = String()
    var username = NSString()
    var myID = NSString()
    //@IBOutlet weak var audioBTN: UIButton!
   // @IBOutlet weak var audioBTNMAIN: UIButton!
    var TurnInfo = NSString()
   
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
    
    let prefs:UserDefaults = UserDefaults.standard
    var HideAudioArray = [Bool]()
    
    var PlayerName = NSString()
    var playerID = NSString()
    var TurnType = NSString()
    @IBOutlet var collectionView: UICollectionView?
    var UserIDArray = [NSString]()
    var UserNameArray = [NSString]()
    
    
    let boomBox = UIImage(named: "BoomBox1.png")
    
    var refreshControl:UIRefreshControl!
    var LFURLData = Data()
    
    var photoForIndexPath = [String]()
    var AudioClips = [Data]()
    var AudioStringArray = [String]()
    var Photos = [UIImage]()
    var NumFails = [NSString]()
    
    var PhotoST = [PhotoInfo]()
    
    var TurnStruc = [TurnSearchInfo]()
    
    var testURLs = ["http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/TestTurn1.jpg", "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/TestTurn2.jpg", "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/TestTurn3.jpg"  ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       noContentLBL.isHidden = true
        if prefs.value(forKey: "PLAYERID") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            myID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            username = "guest"
            myID = "guest"
        }

        
        self.refreshControl = UIRefreshControl()
        print("Will retrieve \(TurnType) turn data on playerID = \(playerID)")
        
       // Photos.append(UIImage(named: "PQLoadingStart.png")!)
      //  Photos.append(UIImage(named: "PQLoadingStart.png")!)
      //  Photos.append(UIImage(named: "PQLoadingStart.png")!)
        
        infoLBL.text = "Check out \(PlayerName)'s \(TurnType)s"
        
        
        self.refreshControl.addTarget(self, action: #selector(LIkeFailCollectionViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        
        /*
        
        for stringImage in testURLs {
          
            var imgURL: NSURL = NSURL(string: stringImage)!
            print("Image URL = \(imgURL)")
            
            /*
            if let imgURL = NSBundle.mainBundle().URLForResource("imageName", withExtension: "jpg"), let data = NSData(contentsOfURL: imgURL), let image = UIImage(data: data) {
                // imageURL.contentMode = .ScaleAspectFit
                //  imageURL.image = image
                print("Image Data = \(data)")
                dispatch_async(dispatch_get_main_queue(),{
                self.Photos.append(image)
                })
            }
            */
            
            if let data = NSData(contentsOfURL: imgURL) {
            print("image Data = \(data)")
                //make sure your image in this url does exist, otherwise unwrap in a if let check
            let theImage = UIImage(data: data)
               
            dispatch_async(dispatch_get_main_queue(),{
            
                self.Photos.append(theImage!)
                
            })
          }
            
            
        }
        */
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //  collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        
        /*
        
        LFURLData = GetUserLikeFailData(self.playerID, likefail: self.TurnType, MyID: self.myID)
        
        
        dispatch_async(dispatch_get_main_queue(),{
            
            self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            
            // self.collectionView!.reloadData()
            
            
            
            
            print("Done looping array")
            
            // Photos = load_images(testURLs)
            
            
            
            
            //  collectionView!.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            // Do any additional setup after loading the view.
            
            // self.collectionView!.registerClass(LikeFailViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        /*
        dispatch_async(dispatch_get_main_queue(),{

        self.PhotoST = self.FilterLikeFailPhotoData(LFURLData)
        
       // self.collectionView!.reloadData()
        
       
        
        
        print("Done looping array")
        
       // Photos = load_images(testURLs)
        
        
        
        
      //  collectionView!.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
        
       // self.collectionView!.registerClass(LikeFailViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        print("Photos count = \(self.PhotoST.count)")
        dispatch_async(dispatch_get_main_queue(),{
            self.collectionView?.reloadData()
            print("dont animating")
            self.actInd.stopAnimating()
            
        })
        
        })
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
        
        //LFURLData = GetUserTurnData(self.playerID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
          //  + 50))
        
        LFURLData = GetUserLikeFailData(self.playerID, likefail: self.TurnType, MyID: self.myID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
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
                
                if self.TurnStruc.count == 0 {
                    self.noContentLBL.isHidden = false
                } else {
                    self.noContentLBL.isHidden = true
                }
                
            })
            
        })
        
        
        //  })
    }
    
    
    /*
    func RefreshCommentData(sender:AnyObject) {
        print("removing array data")
        //Photos.removeAll()
        //LCountArray.removeAll()
        
        
        print("adding array data")
          dispatch_async(dispatch_get_main_queue(),{
            
            let LFURLData = GetUserLikeFailData(self.playerID, likefail: self.TurnType, MyID: self.myID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
                + 50))
        
        
        dispatch_async(dispatch_get_main_queue(),{
        
            dispatch_async(dispatch_get_main_queue(),{
        
            self.PhotoST = self.FilterLikeFailPhotoData(LFURLData)
        })
        
        self.collectionView!.reloadData()
        
        self.refreshControl.endRefreshing()
            
            if self.Photos.count == 0 {
                   self.noContentLBL.hidden = false
            }
            
        })
        })
    }
    
    */
    
    
  
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
        
    self.PlayerMain.play()

    // try self.PlayerMain = AVPlayer(URL: audioURL!)
    } catch {
    print("player not available")
        
        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Audio Error", subTitle: "There is an error with this audio clip", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    }
    //   self.PlayerMain.prepareToPlay()
   // self.PlayerMain.play()
    
    } else {
    
    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Audio Error", subTitle: "There is an error with this audio clip", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    
    }
    //   })
    }
    

    /*

    func PlayAudioClicked(sender: UIButton!) {
        
        
        var RowSelected = sender.tag
        print("the game rowselected: \(sender.tag)")

        var audioURLString = self.AudioStringArray[RowSelected] as String
        
        var AudioData = self.AudioClips[RowSelected] as NSData
        
        
    //    dispatch_async(dispatch_get_main_queue(),{

        let audioURL = NSURL(string:audioURLString)
//            let audioURL = NSURL(fileURLWithPath: audioURLString)
        
        print("Audio URL = \(audioURLString)")
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
            
     //   })
    }
   
*/

    override func viewDidAppear(_ animated: Bool) {
        
        print("My Username = \(username)")
        print("My UserID = \(myID)")
        
        //if self.Photos.count == 0 {
          /*
        if self.TurnStruc.count == 0 {
            self.noContentLBL.hidden = false
        }
        */
        
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
            
            
           // ViewHolder2.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
            
          //  let DeviceH = self.view.frame.height
          //  let middleScreenY = DeviceH / 2
          //  let middleY = middleScreenY - 200
            
           // let AlreadySeenHowTo = prefs.boolForKey("DidShowHowTo_MyTurns")
            
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
            
            //LFURLData = GetUserTurnData(self.playerID)
           // LFURLData = GetUserTurnData(self.playerID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
               // + 50))
           
            
            
            if !AlreadyLoadedView  {
                
                RefreshCommentData(self)
                
                /*
                
            self.RemoveAllFromArray()
            
            LFURLData = GetUserLikeFailData(self.playerID, likefail: self.TurnType, MyID: self.myID, StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
                + 50))
            
            print("RECEIVED THE NSDATA FOR THE TURNS")
            
            self.NumTurnsLoaded = self.NumTurnsLoaded + 50
            
            
            dispatch_async(dispatch_get_main_queue(),{
                
                //  self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
                print("FILTERING TURN DATA NOW")
                self.TurnStruc = self.FilterTurnData(self.LFURLData)
                // self.TurnStruc = self.FilterTurnData(self.LFURLData)
                
                // print("Photos count = \(self.Photos.count)")
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
                    
                })

                
            })
           
                
                */
          AlreadyLoadedView  = true
                
        }
           
          noContentLBL.isHidden = true
            
     //   }
        
        
        
        DispatchQueue.main.async(execute: {
            
        
            self.collectionView?.reloadData()

        })


        /*
        dispatch_async(dispatch_get_main_queue(),{
        
            self.PhotoST = self.FilterLikeFailPhotoData(self.LFURLData)
            
            // self.collectionView!.reloadData()
            
            
            
            
            print("Done looping array")
            
            // Photos = load_images(testURLs)
            
            
            
            
            //  collectionView!.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            // Do any additional setup after loading the view.
            
            // self.collectionView!.registerClass(LikeFailViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            print("Photos count = \(self.Photos.count)")
            dispatch_async(dispatch_get_main_queue(),{
                self.collectionView?.reloadData()
                print("done animating")
                self.actInd.stopAnimating()
                
            })
            
        })

*/
        
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
        
        /*
        
        var string = PhotoID[indexPath.row] as String
    
       // var word = "Apple"
       // var string = "Hello Swift"
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
            
         //   let CTF: Character = "n"
            
         //   if let index = find(string, CTF) {
            
        //    NewTurnNumber = string.substringFromIndex(advance(firstPart, 1))
       //     print("new Turn Number = \(NewTurnNumber)")
          //  }
        }
        
        theAudioData = AudioClips[indexPath.row]
        MainImage = Photos[indexPath.row]
        MediaType = MediaTypeArray[indexPath.row]
        TurnInfo = PhotoID[indexPath.row]
        self.performSegueWithIdentifier("showImage", sender: self)
        
        */
        
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
            LastPartInfo = lastPart as NSString
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
        TheGameID = MyTurnData.gameid as NSString
        
           DispatchQueue.main.async(execute: {
        
        self.performSegue(withIdentifier: "showImage", sender: self)
            
        })
        
        
    }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       // return Photos.count

    return TurnStruc.count
    }
    
    
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LikeFailPhotoCell
        //2
    
       // cell.myLabel.text = self.items[indexPath.item]
    //cell.TurnImage?.image = Photos[indexPath.row] as UIImage
    let MyTurnData = TurnStruc[(indexPath as NSIndexPath).row]

    
    cell.TurnImage?.layer.cornerRadius = 5
    cell.TurnImage?.layer.masksToBounds = true
    
    cell.playBTN?.addTarget(self, action: #selector(LIkeFailCollectionViewController.PlayAudioClicked(_:)), for: .touchUpInside)
    
    cell.playBTN?.tag = (indexPath as NSIndexPath).row
    //cell.playBTN?.hidden = HideAudioArray[indexPath.row]
    
    
    
    
    cell.playBTN?.isHidden = false
    
    // cell.myLabel.text = self.items[indexPath.item]
    if MyTurnData.mediatype == "audio" {
        
        
        cell.TurnImage?.image = MyTurnData.theImage as UIImage
        cell.CellLBL?.text = MyTurnData.gamename as String
        cell.playBTN?.isHidden = false
        
        
    } else {
        
        // if MyTurnData.mediatype == "image" {
        
        // cell.TurnImage?.image = MyTurnData.theImage as UIImage
        cell.TurnImage?.image = MyTurnData.theImage as UIImage
        
        
        
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
                    if collectionView.cellForItem(at: indexPath) != nil {
                        
                        
                        if MyTurnData.mediatype == "gif" {
                            cell.TurnImage?.image = UIImage.animatedImage(withAnimatedGIFData: data!)
                        } else {
                        
                        // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                        cell.TurnImage?.image = image
                            
                        }
                        //cellToUpdate.TurnImage?.image = image
                    }
                })
            }
            else {
                cell.TurnImage?.image = UIImage(named: "noImage.png")!
                    //MyTurnData.theImage as UIImage
                //UIImage(named: "noImage.png")!
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
    
    if NumFails[indexPath.row] as String == "1" {
          cell.CellLBL?.text = "\(NumFails[indexPath.row] as String) \(TurnType)"
    } else {
         cell.CellLBL?.text = "\(NumFails[indexPath.row] as String) \(TurnType)s"
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
                destination.TurnInfo = self.TurnInfo
                destination.replyUser = self.PlayerName
                destination.replyUserID = self.playerID
                destination.MediaType = self.MediaType as String
                destination.GameSelected = self.TheGameID
                destination.LastPartInfo = self.LastPartInfo
                print("Profile show segue")
            }
        }
        

    }
    
    
    func FilterLikeFailPhotoData(_ urlData: Data) -> [PhotoInfo] {
        self.Photos.removeAll()
        self.PhotoID.removeAll()
        self.NumFails.removeAll()
        self.AudioStringArray.removeAll()
        self.HideAudioArray.removeAll()
        
        let PhotoData = [PhotoInfo]()
        
        
       // var Game_ID_Array = [NSString]()
      //  var Game_CountArray = [NSString]()
      //  var GameUserIDArray = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["username"] != "NA") {
                
                let game_username = result["username"].stringValue
                let game_userID = result["userid"].stringValue
                let photo_ID = result["imagename"].stringValue
                let count_temp = result["total"].stringValue
                let mediatype_temp = result["mediatype"].stringValue
                print("username = \(game_username)")
                
               // LvarNum++
               // LNumbers.append(LvarNum.description)
                
                
                    
             //   if !PhotoID.contains(photo_ID){
                    
                    print("is not in current collection array")
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
                      if !self.PhotoID.contains(photo_ID as NSString){
                    
                    self.Photos.append(PhotoImageTemp)
                    
                    }
                }
                    
               // dispatch_async(dispatch_get_main_queue(),{
                    
                    print("PhotoID Array = \(self.PhotoID)")
                    print("Photo_Id item =\(photo_ID)")
                    
                    print("Photo_id is in array = \(self.PhotoID.contains(photo_ID as NSString))")
                    
                    if !self.PhotoID.contains(photo_ID as NSString){
                    
                    self.AudioClips.append(tempNSData)
                    self.MediaTypeArray.append(mediatype_temp as NSString)
                    self.AudioStringArray.append("")
                    self.NumFails.append(count_temp as NSString)
                    self.PhotoID.append(photo_ID as NSString)
                    self.HideAudioArray.append(true)
                    self.collectionView?.reloadData()
                        
                    }
                    
                 //   })
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
                            if !self.PhotoID.contains(photo_ID as NSString){
                            self.AudioClips.append(data)
                            }
                            //self.Photos.append(PhotoImageTemp)
                            
                        }

                        
                        //   })
                        print("PhotoID Array = \(self.PhotoID)")
                        print("Photo_Id item =\(photo_ID)")
                        
                        print("Photo_id is in array = \(self.PhotoID.contains(photo_ID as NSString))")
                        
                        if !self.PhotoID.contains(photo_ID as NSString){
                        
                self.AudioStringArray.append(imgStringTemp)
                self.Photos.append(self.boomBox!)
                self.NumFails.append(count_temp as NSString)
                self.PhotoID.append(photo_ID as NSString)
                self.HideAudioArray.append(false)
                    
                self.MediaTypeArray.append(mediatype_temp as NSString)
                        
                self.collectionView?.reloadData()
                            
                }
                //self.TableView.reloadData()
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
            
    //    }
        
        }
        
        print("PhotoData Struct = \(PhotoData)")
        print("Photos Count = \(Photos.count)")
        return PhotoData
        
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
                let photo_ID = result["imagename"].stringValue
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
                
                let Found = TurnStrucTemp.filter{$0.gameid == gameidtemp}.count > 0
                    
                    if Found {

                    print("Already contains this turn")

                } else {
                
                TurnStrucTemp.append(TurnSearchInfo(gameturnid: photo_ID, mediatype: mediatype_temp, gamename: gamenametemp, viewstatus: viewstatustemp, gameid: gameidtemp, theImage: tempImage, URL: imgStringTemp))
                    
                }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
