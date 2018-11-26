//
//  CollectionImageViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/8/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class CollectionImageViewController: UIViewController {

    
    var LastPartInfo = NSString()
    var replyUserID = NSString()
//var replyUser = NSString()
    var LikedTurn = Bool()
    var FailTurn = Bool()
    let prefs:UserDefaults = UserDefaults.standard
    var username = NSString()
    var userID = NSString()
    var GameName = NSString()
    var FromFollowingTurns = Bool()
    var pageIndex = Int()
    var GameSelected = NSString()
    var CurrentPhotInfo: TurnSearchInfoFollow?
    
    @IBOutlet weak var ReportView: UIView!
    var IsMyTurns = Bool()
    @IBOutlet weak var mainView: UIView!
    var MainImage = UIImage()
    var MainImageURL = String()
    var PreviousImage = UIImage()
    var NewTurnNumber = String()
    var Player1: AVAudioPlayer!
    var PlayerMain: AVAudioPlayer!
    var AudioData = Data()
    var AudioDataURL = String()
    var testData = Data()
    var TurnInfo = NSString()
    var replyUser = NSString()
    
    @IBOutlet weak var audioBTN: UIButton!
    @IBOutlet weak var audioBTNMAIN: UIButton!
    
  
    
    var HidePreviousAudio = Bool()
    var HideCurrentAudio = Bool()
    
    var MediaType = String()
    @IBOutlet weak var PreviousImageView: UIImageView!
    
    @IBOutlet weak var MainImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if prefs.value(forKey: "USERNAME") != nil {
            
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            userID = (prefs.value(forKey: "PLAYERID") as! NSString) as String as String as NSString
        } else  {
            username = "guest"
            userID = "guest"
        }
        
        
        print("GameID = \(self.GameSelected)")
        print("username = \(self.username)")
        print("Turn Number = \(self.LastPartInfo)")
        print("replyuser: \(self.replyUser)")
        print("userID: \(self.userID)")
        print("replyuserid: \(self.replyUserID)")
        print("mediaType: \(MediaType)")
        print("New Turn Number = \(self.NewTurnNumber)")
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
            
        if FromFollowingTurns {
            
           
            
            let string = CurrentPhotInfo!.gameturnid
            
            
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
                
                
            }
            
            GameSelected = CurrentPhotInfo!.gameid as NSString
            MainImage = CurrentPhotInfo!.theImage
            AudioDataURL = CurrentPhotInfo!.URL
            MainImageURL = CurrentPhotInfo!.URL
            MediaType = CurrentPhotInfo!.mediatype
            TurnInfo = CurrentPhotInfo!.gameturnid as NSString
            GameName = CurrentPhotInfo!.gamename as NSString
   
        }
        
        /*else {
        
        
      //  var string = CurrentPhotInfo!.gameturnid
        
        if let range = string.rangeOfString("Turn") {
            let firstPart = string[string.startIndex..<range.startIndex]
            print(firstPart) // print Hello
            let lastPart = string[range.startIndex..<string.endIndex]
            print("last part = \(lastPart)")
            
            LastPartInfo = lastPart
 
        }
            
            GameSelected = CurrentPhotInfo!.gameid
            MediaType = CurrentPhotInfo!.mediatype
        
        }
        */
        
        audioBTN.isHidden = true
        print("New Turn number = \(NewTurnNumber)")
        var theImage = UIImage()
        audioBTNMAIN.isHidden = true
        
        if MediaType == "audio" {
        audioBTNMAIN.isHidden = false
            
            if IsMyTurns {
              ReportView.isHidden = true
            }
            
   PreviousImageView.layer.cornerRadius = 5
   PreviousImageView.layer.masksToBounds = true
   MainImageView.layer.cornerRadius = 5
   MainImageView.layer.masksToBounds = true
   MainImageView.contentMode = UIViewContentMode.scaleAspectFit
   PreviousImageView.contentMode = UIViewContentMode.scaleAspectFit
          //  MainView.layer.mask
            
            if let AudioData = try? Data(contentsOf: URL(string: AudioDataURL)!) {
            
                do {
                    try PlayerMain = AVAudioPlayer(data: AudioData)
                } catch {
                    print("player not available")
                }
                PlayerMain.prepareToPlay()

            } else {
                
                do {
                    try PlayerMain = AVAudioPlayer(data: AudioData)
                } catch {
                    print("player not available")
                }
                PlayerMain.prepareToPlay()
                
            }
            
        theImage = UIImage(named: "BoomBox1.png")!
        MainImageView.image = theImage
        MainImageView.contentMode = UIViewContentMode.scaleAspectFit
            
            
            
    DispatchQueue.main.async(execute: {
       let stringImageOLD = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(self.NewTurnNumber).jpg"
       let imgURLOLD: URL = URL(string: stringImageOLD)!

            print("initial Previous URL = \(imgURLOLD)")
        //   var tempImage2 = UIImage()
        // dispatch_async(dispatch_get_main_queue(),{
      DispatchQueue.main.async(execute: {
        if let data = try? Data(contentsOf: imgURLOLD) {//make sure your image in this url does exist, otherwise unwrap in a if let check
            print("Initial Previous Image Data = \(data)")
            self.testData = data
            
            
            DispatchQueue.main.async(execute: {
            if let tempImage2 = UIImage(data: data) {
                self.PreviousImageView.image = tempImage2
                self.PreviousImageView.contentMode = UIViewContentMode.scaleAspectFit
            } else {
                self.PreviousImageView.image = UIImage(named: "noImage.jpg")
            }
        })
            
        }
        })
     })
            
            
        } else {
        
         
        if let data = try? Data(contentsOf: URL(string: MainImageURL)!) {
            
               // PhotoImageTemp = UIImage(data: data)!
            
            
            let request: URLRequest = URLRequest(url: URL(string:  MainImageURL)!)
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    //  self.imageCache[urlString] = image
                    // Update the cell
                    DispatchQueue.main.async(execute: {
                      //  if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) {
                            
                            // if let cellToUpdate = collectionView.cellForRowAtIndexPath(indexPath) {
                            self.MainImageView.image = image
                        self.MainImageView.contentMode = UIViewContentMode.scaleAspectFit
                            //cellToUpdate.TurnImage?.image = image
                    //    }
                    })
                }
                else {
                    self.MainImageView.image = UIImage(named: "noImage.jpg")
                    
                    print("Error: \(error!.localizedDescription)")
                }
            })
            
            
            
       // MainImageView.image = UIImage(data: data)!
            
        } else {
            
          MainImageView.image = UIImage(named: "noImage.jpg")
        
        }
            
            
        audioBTNMAIN.isHidden = true
        //ITS AN IMAGE
            
        DispatchQueue.main.async(execute: {
            
        let stringImage = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(self.NewTurnNumber).jpg"
        let imgURL: URL = URL(string: stringImage)!
        
       // dispatch_async(dispatch_get_main_queue(),{
   
        if let data = try? Data(contentsOf: imgURL) {//make sure your image in this url does exist, otherwise unwrap in a if let check
            DispatchQueue.main.async(execute: {
            self.testData = data

            if let tempImage2 = UIImage(data: data) {
                self.PreviousImageView.image = tempImage2
            } else {
               // self.PreviousImageView.image = nil
                
                 self.PreviousImageView.image = UIImage(named: "noImage.jpg")
            }
        })
         self.audioBTN.isHidden = true
        
 
            
        } else {
            
            let stringAudio = "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/GameData/\(self.NewTurnNumber).mp3"
            let audioURL: URL = URL(string: stringAudio)!
            
            if let data2 = try? Data(contentsOf: audioURL) {//make sure your image in this url does exist, otherwise unwrap in a if let check
                
                let audioImage = UIImage(named: "BoomBox1.png")!
                self.PreviousImageView.image = audioImage
                self.audioBTN.isHidden = false
                
                do {
                    try self.Player1 = AVAudioPlayer(data: data2)
                } catch {
                    print("player not available")
                }
                self.Player1.prepareToPlay()

                
                
            } else {
         self.PreviousImageView.image = UIImage(named: "noImage.jpg")
          //  self.PreviousImageView.image = nil
            
            }
                //theImage = nil
        }
    })
      //  })
        
        
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playerMainPlay(_ sender: AnyObject) {
        PlayerMain.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func reportContentBTN(_ sender: AnyObject) {
        
      
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Yes") {
            
            ReportContent(self.TurnInfo)
            
            
            let theAlert2 = SCLAlertView()
            theAlert2.addButton("Ok") {
                
            }
            
            theAlert2.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Content Reported", subTitle: "We are reviewing this now.  Thanks!")

        }
        
        theAlert.addButton("Cancel") {
            
            print("Cancel pushed")
        }

        theAlert.showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.red, title: "Report Content?", subTitle: "Would you like to report this content as inappropriate?")
        
        
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Report Content?", message: "Would you like to report this content as inappropriate?  This will remove it from viewing.", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
            
            ReportContent(self.TurnInfo)
            
            let AC = JSController("Content Reported", MyMessage: "We are reviewing the content you reported.  While we review it, the content has been removed from viewing.  Thanks for your feedback!",Color: "Red")
            self.presentViewController(AC, animated: true, completion: nil)

           // self.mainImageView.image = nil
           // self.tempImageView.image = nil
        }
        
        
        
        
        actionSheetController.addAction(nextAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
*/
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ViewThisGame" {
    
    if let destination = segue.destination as? GalleryItemViewController {
    
    //destination.NumComments = NumComments
    destination.GameID = GameSelected
    destination.GameNameSelected = GameName
    //destination.ReplyUser = username
    //destination.ReplyUserID = userID
    //                    destination.Reply
    
    }
    
    }
        
    }
    
    
    @IBAction func LikeBTN(_ sender: AnyObject) {
        
        
         if Reachability.isConnectedToNetwork() {
        
        
        if username == replyUser {
            
            //    let AC = JSController("Hey that's yours..", MyMessage: "You can't 'Like' you own turn.",Color: "Red")
            //   self.presentViewController(AC, animated: true, completion: nil)
            
            
            //  SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Hey that's yours..", subTitle: "You can't 'Like' you own turn.")
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Hey that's yours..", subTitle: "You can't 'Like' you own turn.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            
            //     if !MuteAudio {
           // LikePlayer?.play()
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
                
                
                SaveLikeFailData(self.GameSelected, username: self.username, turn: self.LastPartInfo, type: "like", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaType)" as NSString)
                
                
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
                
                print("The Media type2, before image upload is = \(MediaType)")
                print("The Media type, before image upload is = \(MediaType)")
               
                
                
                
                
                
                
              //  NSNotificationCenter.defaultCenter().postNotificationName("AddLike", object: nil, userInfo: ["likes":"1","index":"\(pageIndex)"])
                
                
                
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
                            
                            if self.GameSelected != "demo" {
                                
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
                                    
                                   // self.LevelPlayer?.play()
                                    
                                    
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
            
        }
            
    }
            
        else
            
        {
            
            
            
            
            SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
        }
        
    }
    
    @IBAction func ViewGameBTN(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "ViewThisGame", sender: self)
    }
    
    @IBAction func FailBTN(_ sender: AnyObject) {
        
   if Reachability.isConnectedToNetwork() {
        
        if username == replyUser {
            
            // let AC = JSController("Hey that's yours..", MyMessage: "You can't mark you own turn as a 'Fail'.",Color: "Red")
            // self.presentViewController(AC, animated: true, completion: nil)
            
            
            //SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor.redColor(), title: "Uh..that's yours.", subTitle: "You're trying to 'Fail' your own turn...nope.")
            
            // theAlert.showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor.redColor(), title: "Uh..that's yours.", subTitle: "You're trying to 'Fail' your own turn...nope.")
            
            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Uh..that's yours", subTitle: "You're trying to 'Fail' your own turn...nope.", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
        } else {
            
            
            
            
            //  if !MuteAudio {
            //FailPlayer?.play()
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
                
                SaveLikeFailData(self.GameSelected, username: self.username, turn: self.LastPartInfo, type: "fail", replyuser: self.replyUser, userID: self.userID, replyuserid: self.replyUserID, mediaType: "\(MediaType)" as NSString)
                
                
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
                print("The Media type, before image upload is = \(MediaType)")
              //  print("The Media type2, before image upload is = \(MediaTypeTemp2)")
                //UploadGameFile(imageName, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                //   UploadGameFile(TempImageCurrent, FileName: "Game\(self.GameID)\(self.TurnNumber)")
                
                
                
                
                
                
                
                
               // NSNotificationCenter.defaultCenter().postNotificationName("AddFail", object: nil, userInfo: ["fails":"1","index":"\(pageIndex)"])
                
                
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
                            
                            if self.GameSelected != "demo" {
                                
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
                                    
                                  //  self.LevelPlayer?.play()
                                    
                                    
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
            
        }
    }
    
    
    else
    
    {
    
    
    
    
    SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
    
    
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
